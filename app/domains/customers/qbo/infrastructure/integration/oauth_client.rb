module Customers
  module Qbo
    module Infrastructure
      module Integration
        class OauthClient
          def initialize(client_configuration:)
            @client_configuration = client_configuration
          end
  
          def authorize_url
            client.auth_code.authorize_url(
              redirect_uri: client_configuration.redirect_uri, 
              state: SecureRandom.uuid, 
              scope: client_configuration.scope
            )
          end
  
          def access_token(authorization_code)
            client.auth_code.get_token(authorization_code, redirect_uri: client_configuration.redirect_uri).token
          end
  
          def refresh_token(refresh_token)
            access_token = OAuth2::AccessToken.from_hash(client, refresh_token: refresh_token)
            access_token = access_token.refresh!
            access_token.token
          end
  
          private
  
          attr_reader :client_configuration, :oauth_configuration
  
          def client
            @client ||= OAuth2::Client.new(
              client_configuration.client_id, 
              client_configuration.client_secret,
              site: client_configuration.authorization_url,
              token_url: client_configuration.token_url,
              authorize_url: client_configuration.authorization_url)
          end
        end
      end
    end
  end
end