require "rails_event_store"
require "aggregate_root"
require "arkency/command_bus"

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::JSONClient.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  # Subscribe event handlers below
  Rails.configuration.event_store.tap do |store|
    # store.subscribe(InvoiceReadModel.new, to: [InvoicePrinted])
    # store.subscribe(lambda { |event| SendOrderConfirmation.new.call(event) }, to: [OrderSubmitted])
    # store.subscribe_to_all_events(lambda { |event| Rails.logger.info(event.event_type) })

    store.subscribe_to_all_events(RailsEventStore::LinkByEventType.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCorrelationId.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCausationId.new)

    store.subscribe(Accounts::Projectors::AccountProjector.new, to: [Accounts::Events::AccountCreated])
    store.subscribe(Customers::Qbo::Projectors::CustomerProjector.new, to: [Customers::Qbo::Events::CustomerCreated])
    store.subscribe(Customers::Qbo::CustomerEventHandler.new, to: [Customers::Qbo::Events::CustomerCreated])

  end

  # Register command handlers below
  # Rails.configuration.command_bus.tap do |bus|
  #   bus.register(PrintInvoice, Invoicing::OnPrint.new)
  #   bus.register(SubmitOrder, ->(cmd) { Ordering::OnSubmitOrder.new.call(cmd) })
  # end
end

def testing_create(name: 'elo', email: 'pozdrawiam@elo.com', api_key: '123')
  params = { name: name, email: email, api_key: api_key }

  command = Accounts::Commands::CreateAccountCommand.new(SecureRandom.uuid, params[:name], params[:email], params[:api_key])
  handler = Accounts::AccountCommandHandler.new
  handler.call(command)
end

def testing_create(id: SecureRandom.uuid, first_name: "Lukasz", last_name: 'Szyndzielorz', display_name: 'Lukson1', email: 'l.szyndzielorz@gmail.com', phone_number: '+48577798968', notes: 'Super customer', additional_data: { address: 'Poland' })
  params = {
    id: id,
    first_name: first_name,
    last_name: last_name,
    display_name: display_name,
    email: email,
    phone_number: phone_number,
    notes: notes,
    additional_data: additional_data
  }

  command = Customers::Qbo::Commands::CreateCustomerCommand.new(**params)
  handler = Customers::Qbo::CustomerCommandHandler.new
  handler.call(command)
end


def rebuild_read_models
  event_store = Rails.configuration.event_store
  events = [Accounts::Events::AccountCreated]
  # Get all the events related to the Post aggregate
  events = event_store.read.of_type(events).to_a
  
  # Pass each event to the projector
  projector = Accounts::Projectors::AccoutnProjector.new
  events.each do |event|
    projector.call(event)
  end
end