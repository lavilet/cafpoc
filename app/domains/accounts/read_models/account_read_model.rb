module Accounts
  module ReadModels
    class AccountReadModel < ApplicationRecord
      self.table_name = 'accounts'
    end    
  end
end