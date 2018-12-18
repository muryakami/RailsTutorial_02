require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title, "ねこ日報"
    assert_equal full_title("Help"), "Help | ねこ日報"
  end

end