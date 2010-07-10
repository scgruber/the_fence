class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    
    unless user.nil? # TODO: could use more controller-level testing
      can :create, Event
      can :edit, Event, :creator_id => user.id
    end
  end

end
