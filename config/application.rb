# frozen_string_literal: true

class Application < Roda
  plugin :json
  plugin :all_verbs
end
