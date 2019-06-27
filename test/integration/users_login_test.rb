# frozen_string_literal: true

require 'test_helper'

# UsersSignupTest
class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@mial.com',
                        password: 'password', admin: true)
  end

  test 'invalid login information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: ' ', password: 'password' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-messages'
    assert_select 'div.alert.alert-danger'
    assert_select 'div#flash_danger'
    assert_select 'form[action="/login"]'
  end

  test 'valid login information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    sign_in_as(@user, 'password')
    assert_redirected_to @user
  end
end
