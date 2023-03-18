require "test_helper"

class CollectionTest < ActiveSupport::TestCase
  test "spent for collection" do
    assert_equal 20, collections(:one_in_progress).spent
    assert_equal 0, collections(:two_in_progress).spent
    assert_equal 25, collections(:one_ended).spent
  end
end
