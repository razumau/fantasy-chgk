class Pick < ApplicationRecord
  belongs_to :collection
  belongs_to :team
  delegate :game, to: :team

  validate :player_can_add_one_more_team, :player_has_enough_points, :game_is_active

  before_destroy do
    game_is_active
    throw(:abort) if errors.present?
  end

  after_save :deduct_points

  def player_has_enough_points
    unless collection.points + team.price <= game.points_limit
      errors.add(:pick, "Недостаточно очков для этой команды")
    end
  end

  def player_can_add_one_more_team
    unless no_teams? || has_empty_slot?
      errors.add(:pick, "Нельзя выбрать больше #{game.teams_limit} команд")
    end
  end

  def game_is_active
    if Time.current > game.deadline
      errors.add(:pick, "Игра закончена")
    end
  end

  def deduct_points
    collection.points -= team.price
    player.save
  end

  private
  def no_teams?
    player.teams.nil?
  end

  def has_empty_slot?
    player.teams.length < game.teams_limit
  end
end