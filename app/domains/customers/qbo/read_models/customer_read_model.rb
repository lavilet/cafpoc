module Customers
  module Qbo
    module ReadModels
      class CustomerReadModel < ApplicationRecord
        self.table_name = 'qbo_customers'
      end    
    end
  end
end