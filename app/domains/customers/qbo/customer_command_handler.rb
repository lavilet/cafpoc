module Customers
  module Qbo
    class CustomerCommandHandler
      def call(command)
        stream_name = "Customer$#{command.id}"
        customer = repository.load(Customers::Qbo::Entities::Customer.new(command.id), stream_name)
  
        case command
        when Customers::Qbo::Commands::CreateCustomerCommand
          customer.create(command.id, command.first_name, command.last_name, command.display_name, command.email, command.phone_number, command.notes, command.additional_data)
        end
        repository.store(customer, stream_name)
      end
    
      private
    
      def repository
        @repository ||= AggregateRoot::Repository.new
      end
    end
  end
end