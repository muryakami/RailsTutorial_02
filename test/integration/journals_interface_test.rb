require 'test_helper'

class JournalsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nekojarashi)
    @other_user = users(:inujarashi)
  end

  test "journal interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Journal.count' do
      post journals_path, params: { journal: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This journal really ties the room together"
    assert_difference 'Journal.count', 1 do
      post journals_path, params: { journal: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_journal = @user.journals.paginate(page: 1).first
    assert_difference 'Journal.count', -1 do
      delete journal_path(first_journal)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:inujarashi))
    assert_select 'a', text: 'delete', count: 0
  end

  test "journal sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.journals.count} journals", response.body
    # まだジャーナルを投稿していないユーザー
    other_user = users(:kijijarashi)
    log_in_as(other_user)
    get root_path
    assert_match "0 journals", response.body
    other_user.journals.create!(content: "A journal")
    get root_path
    assert_match "1 journal", response.body
  end

end
