module Customers
  module Qbo
    module Infrastructure
      module Integration
        class ClientConfiguration

          CLIENT_ID = 'ABY2uIkQiLAZ1eAquYRZQ0ZLvH3JNOr7VUHn2a41AYAnELuBrz'
          CLIENT_SECRET = 'F7kzfFYQ8MVjAxPmhQdn0fqH70ahFi9n6TpwyHt8'
          REDIRECT_URI = 'https://1290-2a02-a313-23d-8600-f97c-aaec-6baf-358a.ngrok-free.app/alpha/common_accounting_framework/callbacks/quickbooks_oauth_callback'
          INTUIT_SCOPE_ACCOUNTING = 'com.intuit.quickbooks.accounting'
          AUTHORIZATION_URL = 'https://appcenter.intuit.com/connect/oauth2'
          TOKEN_URL = 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'
          BASE_API_URL = 'https://sandbox-quickbooks.api.intuit.com' # PROD: https://quickbooks.api.intuit.com/v3/company'

          attr_reader :client_id, :client_secret, :redirect_uri, :base_api_url, :authorization_url, :scope, :token_url

          def initialize(client_id: 'AB4UB8EjDnWYOED6ogA2G3R4fueyexDNdmH2DupQuTMJ1Q65zp', client_secret: 'QFtyHWoZZzp9HpTUuygcrTwn4RkJNEDUFDgvLsrz', redirect_uri: 'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl', base_api_url: 'https://sandbox-quickbooks.api.intuit.com',
                         authorization_url: 'https://appcenter.intuit.com/connect/oauth2', 
                         scope: 'com.intuit.quickbooks.accounting', 
                         token_url: 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer')
            @client_id = client_id
            @client_secret = client_secret
            @redirect_uri = redirect_uri
  
            # These could be injected as a separate OauthConfig
            @base_api_url = base_api_url
            @authorization_url = authorization_url
            @scope = scope
            @token_url = token_url
          end
        end
      end
    end
  end
end

