module Customers
  module Qbo
    module Commands
      class CreateCustomerCommand
        attr_reader :id, :first_name, :last_name, :display_name, :email, :phone_number, :notes, :additional_data
      
        def initialize(id:, first_name:, last_name:, display_name:, email:, phone_number:, notes:, additional_data:)
          @id = id
          @first_name = first_name
          @last_name = last_name
          @email = email
          @display_name = display_name
          @phone_number = phone_number
          @notes = notes
          @additional_data = additional_data
        end
      end  
    end
  end
end