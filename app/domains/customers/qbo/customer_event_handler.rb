module Customers
  module Qbo
    class CustomerEventHandler
      def call(event)
        case event
        when Customers::Qbo::Events::CustomerCreated
          refresh_token = 'AB11698522704kzSK1Ram9nFVbySmcY1nO33uJCQmMVGAU8K9S' # Needed from HCP
          client_config = Customers::Qbo::Infrastructure::Integration::ClientConfiguration.new
          oauth_client = Customers::Qbo::Infrastructure::Integration::OauthClient.new(client_configuration: client_config)
          token = oauth_client.refresh_token(refresh_token)
          company_id = '4620816365319268300' # Neede from HCP

          qbo_api_service = Customers::Qbo::Infrastructure::Integration::QboApi.new(
            bearer_token: token,
            company_id: company_id
          )

          payload = {
            'Notes' => event.data[:notes],
            'PrimaryEmailAddr' => { "Address" => event.data[:email] },
            'PrimaryPhone' => { 'FreeFormNumber' => event.data[:phone_number] },
            'DisplayName' => event.data[:display_name]
          }
          qbo_api_service.create_customer(payload)
        end
      end
    end
  end
end


# "refreshToken": "AB11698522704kzSK1Ram9nFVbySmcY1nO33uJCQmMVGAU8K9S",
# "accessToken": "eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..R8w4GU9sRpbowePJEBBIhQ.lmJwUZOwDc9RtM5IxMfHT-uOzqnIDSsAkfYgb1n_bek45Pslfl7NIsg4-U2_Gv8BF9h_wOMC67zQh8my26nK-fDrS6F7BN0HRQ3zWpJaLc0Lvo2ZKeQOS92X0oTg139Dzz_BhJbNM1RwUGVQH0FKhUeMPxUhnAQT66Tt20SixKQzagTcEj2FEy1KWGWMZ_81eApo-hOkH9MBI8v4972kO05hpZvt3pIsWJXJ89SPj7sQOKbXJ_a1TlVmpuwZ0RXDl-7d-zZ9adq1vaEOttB5TFcd6ENoZ3FIB3yTpYWhT0OGxZ4F3zuz9aXeCPsfCTZ14giL9OaQ71ENqoDhCQRg_wcK33HalMOyTXXtV1leq8-w8cvuxCBNfJqYNUW3KwtNvkrSMo1tpV-PE2EY2GkTA1sbFkJbEIEeE-DoxCwr86AwgFQAE46RT1AUcPxFlquqEIfHwkvdo8ISsurkMKZVKcTJUa5PZsDP5ARnVt3PAuqEIYSAIQBU9Ok6Nib6xk0vuwaUrOdb5KKm5rbsacUKSRTIGjBsX7uYB0IftTRCXmzGGvQaNNMNHUZut2xXcM-l0Jg-Al4XxK97L8MvsOlHZDQMrtvCHGx-nwGmnT5xXKsd7EHR59XYo4qMAggmgXi4MtAiBI2u969KH3JAj3TahIohhzWWnjzWeciwo7T4JPHGy0TLC3ZBj0rKAxXcOrg5P-aX1AI5_60Oht6acci6V7cjjFG5iah4K81Ha8cE1gHaqUo_xhG97v9Yjtu8ngql.r6cCdiyWlQ1PaTjccnP6NQ",