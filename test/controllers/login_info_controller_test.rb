# frozen_string_literal: true

require 'test_helper'

class LoginInfoControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def test_save
    @login_infos = LoginInfo.new
    assert !@login_infos.save
  end

  def test_save_two
    params = {}
    params['email'] = 'xyz@gmail.com'
    params['password'] = 'xyz@gmail.com'
    @login_infos = LoginInfo.new params
    assert @login_infos.save
    assert @login_infos.destroy
  end

  # cant save without the password
  def test_save_three
    params = {}
    params['email'] = 'xyz@gmail.com'
    @login_infos = LoginInfo.new params
    assert !@login_infos.save
  end

  def test_list
    LoginInfo.search email: general_infos(:perl_cb)
    assert true
  end

  def test_login_infos_search_one
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    perl_search_one = LoginInfo.search email: general_infos(:java_cb)
    assert_not_equal perl_search, perl_search_one
  end

  def test_login_infos_search_two
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    perl_search_one = LoginInfo.search email: general_infos(:perl_cb)
    assert_equal perl_search, perl_search_one
  end

  def test_login_infos_search_three
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    assert_not_nil perl_search
  end

  def test_login_infos_search_three_one
    perl_search = LoginInfo.search email: 'undefined@gmail.com'
    assert_not_nil perl_search
  end
end
