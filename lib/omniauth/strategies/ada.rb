require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ada < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "Ada"

      option :auth_scheme, :request_body
      option :provider_ignores_state, true

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
	      :site => "https://sso.edemokraciagep.org/ada/v1/",
	      :authorize_url => "https://sso.edemokraciagep.org/ada/v1/oauth2/auth",
	      :token_url => "https://sso.edemokraciagep.org/ada/v1/oauth2/token",
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['userid'] }

      info do
        {
          :name => 'Anonim Felhasználó',
          :email => raw_info['email'],
          :id => raw_info['userid'],
	  :officialized_at => officialized_at,
	  :officialized_as => officialized_as
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
	resp = access_token.get('/ada/v1/users/me')
	r = resp.parsed
        @raw_info ||= r
      end

      def officialized_as
	   if ("" == assurances)
	   then
	      @officialized_as = nil
	   else
	      @officialized_as = {"hu" => assurances }
	   end
      end

      def officialized_at
	   if ("" == assurances)
	   then
	      @officialized_at = nil
	   else
		   @officialized_at = Time.current
	   end
      end

      def assurances
          @assurances = raw_info["assurances"].to_set.to_a.sort.join(", ")
      end

    end
  end
end
