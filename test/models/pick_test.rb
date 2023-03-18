require "test_helper"

class PickTest < ActiveSupport::TestCase
  test "can add to an empty collection" do
    collections(:two_in_progress).picks << Pick.new(team: teams(:good_in_progress))
    assert_equal 1, collections(:two_in_progress).picks.size
  end

  test "can add to a collection with an empty slot" do
    collections(:two_in_progress).picks << Pick.new(team: teams(:good_in_progress))
    collections(:two_in_progress).picks << Pick.new(team: teams(:bad_in_progress))
    assert_equal 2, collections(:two_in_progress).picks.size
  end

  test "can’t add to a full collection" do
    p = Pick.new(team: teams(:average_in_progress), collection: collections(:one_in_progress))
    assert p.invalid?
    assert p.errors.messages[:pick].any? { |message| message.start_with?("Нельзя выбрать больше") }
  end

  test "can’t add when a sum of prices is above a limit" do
    p = Pick.new(team: teams(:average_in_progress), collection: collections(:one_in_progress))
    assert p.invalid?
    assert p.errors.messages[:pick].any? { |message| message.start_with?("Недостаточно очков") }
  end

  test "can’t add the same team twice" do
    collections(:two_in_progress).picks << Pick.new(team: teams(:bad_in_progress))
    p = Pick.new(team: teams(:bad_in_progress), collection: collections(:two_in_progress))
    assert p.invalid?
    assert p.errors.messages[:pick].any? { |message| message.start_with?("Команда уже выбрана") }
  end
end
