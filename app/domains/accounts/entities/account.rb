module Accounts
  module Entities
    class Account
      include AggregateRoot
      attr_reader :id
    
      def initialize(id)
        @id = id
      end
    
      def create(id, name, email, api_key)
        apply Accounts::Events::AccountCreated.new(data: { id: id, name: name, email: email, api_key: api_key })
      end
    
      # def publish
      #   apply Blog::Events::PostPublished.new(data: { id: @id })
      # end
    
      on Accounts::Events::AccountCreated do |event|
        @id = event.data[:id]
        @name = event.data[:name]
        @email = event.data[:email]
        @api_key = event.data[:api_key]
      end
    
      # on Blog::Events::PostPublished do |event|
      #   @published = true
      # end
    end
  end
end
