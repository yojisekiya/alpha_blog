require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'yojisekiya', email: 'yojisekiya@example.com', password: 'password', admin: false)
    sign_in_as(@user)
  end

  test 'get new article form and create article' do
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'some title', description: 'some description' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'some title', response.body
  end

  test 'get new article form and reject invalid article submission' do
    get new_article_path
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: '', description: 'some description', category: ' ' } }
    end
    puts response.body
    assert_match 'prevented', response.body
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
