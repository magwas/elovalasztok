
# frozen_string_literal: true

if Rails.application.secrets.dig(:omniauth, :ada, :enabled)
  require "omniauth/strategies/ada"

  Devise.setup do |config|
    config.omniauth :ada,
                    name: "ada",
                    client_id: Rails.application.secrets.dig(:omniauth, :ada, :client_id),
                    client_secret: Rails.application.secrets.dig(:omniauth, :ada, :client_secret)
  end

  Decidim::User.omniauth_providers << :ada
end
