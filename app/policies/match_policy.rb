class MatchPolicy
  attr_reader :user, :match

  def initialize(user, match)
    @user = user
    @match = match
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end
end
