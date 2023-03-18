class Pick < ApplicationRecord
  belongs_to :collection
  belongs_to :team
  delegate :game, to: :collection
  delegate :price, to: :team
  delegate :points, to: :team

  validate :player_can_add_one_more_team, :player_has_enough_points, :game_is_active, :team_is_not_duplicate

  before_destroy do
    game_is_active
    throw(:abort) if errors.present?
  end

  def player_has_enough_points
    unless collection.spent + price <= game.points_limit
      errors.add(:pick, "Недостаточно очков для этой команды")
    end
  end

  def player_can_add_one_more_team
    unless has_empty_slot?
      errors.add(:pick, "Нельзя выбрать больше #{game.teams_limit} команд")
    end
  end

  def game_is_active
    if Time.current > game.deadline
      errors.add(:pick, "Игра закончена")
    end
  end

  def team_is_not_duplicate
    if collection.picks.pluck(:team_id).include?(team_id)
      errors.add(:pick, "Команда уже выбрана")
    end
  end

  private

  def has_empty_slot?
    collection.picks.length < game.teams_limit
  end
end