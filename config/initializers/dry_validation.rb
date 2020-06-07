# frozen_string_liteal: true

require "dry/validation"
require "dry/monads/result"
module Dry
  module Validation
    class Result
      include Dry::Monads::Result::Mixin
      def to_monad
        success? ? Success(self) : Failure({ code: :validation_error, payload: self.errors.to_h })
      end
    end
  end
end
