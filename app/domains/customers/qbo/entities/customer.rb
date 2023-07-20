module Customers
  module Qbo
    module Entities
      class Customer
        include AggregateRoot
        attr_reader :id
      
        def initialize(id)
          @id = id
        end
      
        def create(id, first_name, last_name, display_name, email, phone_number, notes, additional_data)
          args = {
            data: {
              id: id,
              first_name: first_name, 
              last_name: last_name, 
              display_name: display_name,
              email: email,
              phone_number: phone_number,
              notes: notes,
              additional_data: additional_data
            }
          }
          apply Customers::Qbo::Events::CustomerCreated.new(**args)
        end

        def sync_with_qbo(id, first_name, last_name, display_name, email, phone_number, notes, additional_data)
          args = {
            data: {
              id: id,
              first_name: first_name, 
              last_name: last_name, 
              display_name: display_name,
              email: email,
              phone_number: phone_number,
              notes: notes,
              additional_data: additional_data
            }
          }
          apply Customers::Qbo::Events::CustomerSyncedWithQbo.new(**args)
        end
      
        on Customers::Qbo::Events::CustomerCreated do |event|
          @id = event.data[:id]
          @first_name = event.data[:first_name]
          @last_name = event.data[:last_name]
          @display_name = event.data[:display_name]
          @email = event.data[:email]
          @phone_number = event.data[:phone_number]
          @notes = event.data[:notes]
          @additional_data = event.data[:additional_data]
        end

        on Customers::Qbo::Events::CustomerSyncedWithQbo do |event|
          @id = event.data[:id]
          @first_name = event.data[:first_name]
          @last_name = event.data[:last_name]
          @display_name = event.data[:display_name]
          @email = event.data[:email]
          @phone_number = event.data[:phone_number]
          @notes = event.data[:notes]
          @additional_data = event.data[:additional_data]
          @synced_with_qbo = true
        end
      end
    end
  end
end
