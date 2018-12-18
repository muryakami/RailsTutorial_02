require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @journal = journals(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Journal.count' do
      post journals_path, params: { journal: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Journal.count' do
      delete journal_path(@journal)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:nekojarashi))
    journal = journals(:ants)
    assert_no_difference 'Journal.count' do
      delete journal_path(journal)
    end
    assert_redirected_to root_url
  end

end
