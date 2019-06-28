# frozen_string_literal: true

require 'test_helper'

# CreateCategoriesTest
class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@mial.com',
                        password: 'password', admin: true)
  end

  test 'get new category form and create category' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article:
        { title: 'test article',
          description: 'test article for integration test' } }
    end
    follow_redirect!
    assert_template 'articles/show'
    assert_match 'test article', response.body
  end

  test 'invalid article submission results in failure' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article:
        { title: 'te',
          description: 'test article for integration test' } }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'invalid article submission results in failure' do
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article:
        { title: 'te',
          description: 'test article for integration test' } }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
