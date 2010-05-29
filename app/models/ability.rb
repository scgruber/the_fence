class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :create, Event unless user.nil?
  end

end
