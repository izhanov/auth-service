# frozen_string_literal: true

module Operations
  module Users
    class Create
      include Dry::Monads[:result, :do]
    end
  end
end
