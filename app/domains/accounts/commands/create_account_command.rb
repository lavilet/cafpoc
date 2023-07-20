module Accounts
  module Commands
    class CreateAccountCommand
      attr_reader :id, :name, :email, :api_key
    
      def initialize(id, name, email, api_key)
        @id = id
        @name = name
        @email = email
        @api_key = generate_api_key
      end

      def generate_api_key
        puts "ELUWINA!"
        SecureRandom.uuid
      end
    end  
  end
end