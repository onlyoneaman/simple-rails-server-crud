module BaseError

  class IGAccountsOver < StandardError
    def initialize(message)
      super(message)
    end
  end

  class BadRequest < StandardError
    def initialize(message)
      super(message)
    end
  end

  class RateLimit < StandardError
    def initialize(message)
      super(message)
    end
  end

  class NotFound < StandardError
    def initialize(message)
      super(message)
    end
  end

  class Forbidden < StandardError
    def initialize(message)
      super(message)
    end
  end

  class Unauthorized < StandardError
    def initialize(message)
      super(message)
    end
  end

  class InternalError < StandardError
    def initialize(message)
      super(message)
    end
  end

  class UnprocessableEntityError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
