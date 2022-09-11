require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @user = User.create(username: 'yojisekiya', email: 'yojisekiya@example.com', password: 'password')
    @article = Article.new(title: 'some title', description: 'some description', user_id: 1)
  end

  test 'article should be valid' do
    assert @article.valid?
  end

  test 'article should be present' do
    @article.title = ''
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 'a' * 101
    assert_not @article.valid?
  end

  test 'title should not be too short' do
    @article.title = 'a' * 5
    assert_not @article.valid?
  end

  test 'description should not be too long' do
    @article.description = 'a' * 301
    assert_not @article.valid?
  end

  test 'description should not be too short' do
    @article.description = 'a' * 9
    assert_not @article.valid?
  end
end
