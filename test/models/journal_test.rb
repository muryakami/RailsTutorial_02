require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  def setup
    @user = users(:nekojarashi)
    @journal = @user.journals.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @journal.valid?
  end

  test "user id should be present" do
    @journal.user_id = nil
    assert_not @journal.valid?
  end

  test "content should be present" do
    @journal.content = "   "
    assert_not @journal.valid?
  end

  test "content should be at most 140 characters" do
    @journal.content = "a" * 141
    assert_not @journal.valid?
  end

  test "order should be most recent first" do
    assert_equal journals(:most_recent), Journal.first
  end

end
