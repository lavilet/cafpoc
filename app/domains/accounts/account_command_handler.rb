module Accounts
  class AccountCommandHandler
    def call(command)
      stream_name = "Account$#{command.id}"
      account = repository.load(Accounts::Entities::Account.new(command.id), stream_name)

      case command
      when Accounts::Commands::CreateAccountCommand
        account.create(command.id, command.name, command.email, command.api_key)
      end
      repository.store(account, stream_name)
    end
  
    private
  
    def repository
      @repository ||= AggregateRoot::Repository.new
    end
  end
end