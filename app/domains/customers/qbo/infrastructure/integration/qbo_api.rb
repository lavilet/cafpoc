module Customers
  module Qbo
    module Infrastructure
      module Integration
        class QboApi
          QBO_API_BASE_URL = 'https://sandbox-quickbooks.api.intuit.com'.freeze
          RequestFailed = Class.new(StandardError)
    
          def initialize(bearer_token:, company_id:)
            @bearer_token = bearer_token
            @company_id = company_id
            @connection = Faraday.new(url: QBO_API_BASE_URL) do |faraday|
              faraday.request :json
              faraday.response :json, content_type: /\bjson$/
              faraday.adapter Faraday.default_adapter
            end
          end
    
          def create_customer(data)
            response = @connection.post do |request|
              request.url "/v3/company/#{@company_id}/customer"
              request.headers = headers
              request.body = data
            end
            # binding.pry
            raise RequestFailed, parse_error(response.body) unless response.success?
            response.body
          end
    
          def get_customer(id)
            response = @connection.get do |request|
              request.url "/v3/company/#{@company_id}/customer/#{id}"
              request.headers = headers
            end
            response.body
          end

          def get_all_customers
            response = @connection.get do |request|
              query = "SELECT * FROM Customer"
              endpoint = "/v3/company/#{@company_id}/query?query=#{CGI.escape(query)}"
              request.url endpoint
              request.headers = headers
            end
            raise RequestFailed, parse_error(response.body) unless response.success?

            response.body
          end
    
          private
    
          def headers
            {
              'Content-Type' => 'application/json',
              'Accept' => 'application/json',
              'Authorization' => "Bearer #{@bearer_token}"
            }
          end

          def parse_error(response)
            {
              type: response['Fault']['type'],
              errors: response['Fault']['Error'].map { |error| 
                {
                  message: error['Message'], 
                  detail: error['Detail'], 
                  code: error['code'] 
                } 
              }
            }
          end
        end
      end
    end
  end
end
