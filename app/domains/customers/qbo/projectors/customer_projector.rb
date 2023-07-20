module Customers
  module Qbo
    module Projectors
      class CustomerProjector
        def call(event)
          case event
          when Customers::Qbo::Events::CustomerCreated
            Customers::Qbo::ReadModels::CustomerReadModel.create!(
              id: event.data[:id], 
              first_name: event.data[:first_name], 
              last_name: event.data[:last_name], 
              display_name: event.data[:display_name], 
              phone_number: event.data[:phone_number], 
              notes: event.data[:notes], 
              email: event.data[:email],
              additional_data: event.data[:additional_data],
            )
          end
        end
      end
    end
  end
end