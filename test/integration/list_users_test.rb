require 'test_helper'

class ListUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'yojisan', email: 'yojisan@example.com', password: 'password')
    @user2 = User.create(username: 'yojikun', email: 'yojikun@example.com', password: 'password')
  end

  test 'should show new users' do
    get '/users'
    assert_select 'a[href=?]', user_path(@user), text: @user.username
    assert_select 'a[href=?]', user_path(@user2), text: @user2.username
  end
end
