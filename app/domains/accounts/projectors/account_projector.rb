module Accounts
  module Projectors
    class AccountProjector
      def call(event)
        case event
        when Accounts::Events::AccountCreated
          # Create a new post read model
          Accounts::ReadModels::AccountReadModel.create!(
            id: event.data[:id], 
            name: event.data[:name], 
            email: event.data[:email],
            api_key: event.data[:api_key]
          )
        # when Blog::Events::PostPublished
        #   # Find the post read model and update it
        #   post = Blog::ReadModels::PostReadModel.find(event.data[:id])
        #   post.update!(published: true)
        end
      end
    end
  end
end