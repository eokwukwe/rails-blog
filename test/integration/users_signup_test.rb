# frozen_string_literal: true

require 'test_helper'

# UsersSignupTest
class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: ' ',
                                         email: 'example@mail.com',
                                         password: 'password',
                                         admin: false } }
    end
    assert_select 'div.panel-danger'
    assert_select 'div.panel-heading'
    assert_select 'ul.error-messages'
    assert_select 'form[action="/users"]'
  end

  test 'valid signup information' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'example',
                                         email: 'example@mail.com',
                                         password: 'password',
                                         admin: false } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_match 'example', response.body
  end
end
