require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test 'get signup form and signing up a user' do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'yoji', email: 'yoji@example.com', password: 'password' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'articles', response.body
  end

  test 'get signup form and reject invalid user' do
    get '/signup'
    assert_response :success
    assert_no_difference 'User.count', 1 do
      post users_path, params: { user: { username: '', email: 'yoji@example.com', password: 'password' } }
    end
    assert_match 'errors', response.body
    puts response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
