
# frozen_string_literal: true

if Rails.application.secrets.dig(:omniauth, :participa, :enabled)
  require "omniauth/strategies/ada"

  Devise.setup do |config|
    config.omniauth :ada,
                    name: "ada",
                    identifier: Rails.application.secrets.dig(:omniauth, :ada, :identifier)
  end

  Decidim::User.omniauth_providers << :ada
end
