# frozen_string_literal: true

require 'test_helper'

class SearchProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    assert true
  end

  def test_general_infos_search
    perl_search = GeneralInfo.search first_name: general_infos(:perl_cb)
<<<<<<< HEAD
    perl_search_one = GeneralInfo.search first_name: general_infos(:perl_cb)
    assert_equal perl_search, perl_search_one
  end

  def test_general_infos_search_two
    perl_search = GeneralInfo.search last_name: general_infos(:perl_cb)
    perl_search_one = GeneralInfo.search last_name: general_infos(:perl_cb)
    assert_equal perl_search, perl_search_one
  end

  def test_general_infos_search_three
    search_arg = {}
    search_arg['first_name'] = 'Avinash'
    search_arg['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search search_arg
    assert_not_nil perl_search

    # perl_search_one=GeneralInfo.search :last_name =>general_infos(:perl_cb)

    # assert_equal perl_search,perl_search_one
  end

  # test equality of two searched strings
  def test_general_infos_search_four
    search_arg = [{}, {}]
    search_arg[0]['first_name'] = 'Avinash'
    search_arg[0]['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search search_arg[0]
    assert_not_nil perl_search

    search_arg[1]['last_name'] = 'Saxena'
    search_arg[1]['last_name_regex'] = 'Contains'

    perl_search_one = GeneralInfo.search search_arg[1]
    assert_not_nil perl_search_one
    # perl_search_one=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search, perl_search_one
  end

  # Phone number and lastname searches for same
  def test_general_infos_search_five
    search_arg = {}
    search_arg['phone'] = '979'
    perl_search = GeneralInfo.search search_arg
    assert_not_nil perl_search

    search_arg = {}
    search_arg['last_name'] = 'Saxena'
    search_arg['last_name_regex'] = 'Contains'

    perl_search_one = GeneralInfo.search search_arg
    assert_not_nil perl_search_one
    # perl_search_one=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search, perl_search_one
  end

  # search for different profiles
  def test_general_infos_search_six
    search_arg = {}
    search_arg['phone'] = '979'
    search_arg['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search search_arg
    assert_not_nil perl_search

    search_arg = {}
    search_arg['phone'] = '828'
    perl_search_one = GeneralInfo.search search_arg
    assert_not_nil perl_search_one

    assert_equal perl_search, perl_search_one
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
=======
    perl_search1 = GeneralInfo.search first_name: general_infos(:perl_cb)
    assert_equal perl_search, perl_search1
  end

  def test_general_infos_search_2
    perl_search = GeneralInfo.search last_name: general_infos(:perl_cb)
    perl_search1 = GeneralInfo.search last_name: general_infos(:perl_cb)
    assert_equal perl_search, perl_search1
  end

  def test_general_infos_search_3
    searchArg = {}
    searchArg['first_name'] = 'Avinash'
    searchArg['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search searchArg
    assert_not_nil perl_search

    # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)

    # assert_equal perl_search,perl_search1
  end

  # test equality of two searched strings
  def test_general_infos_search_4
    searchArg = {}
    searchArg['first_name'] = 'Avinash'
    searchArg['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg = {}
    searchArg['last_name'] = 'Saxena'
    searchArg['last_name_regex'] = 'Contains'

    perl_search1 = GeneralInfo.search searchArg
    assert_not_nil perl_search1
    # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search, perl_search1
  end

  # Phone number and lastname searches for same
  def test_general_infos_search_5
    searchArg = {}
    searchArg['phone'] = '979'
    perl_search = GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg = {}
    searchArg['last_name'] = 'Saxena'
    searchArg['last_name_regex'] = 'Contains'

    perl_search1 = GeneralInfo.search searchArg
    assert_not_nil perl_search1
    # perl_search1=GeneralInfo.search :last_name =>general_infos(:perl_cb)
    assert_equal perl_search, perl_search1
  end

  # search for different profiles
  def test_general_infos_search_6
    searchArg = {}
    searchArg['phone'] = '979'
    searchArg['first_name_regex'] = 'Contains'
    perl_search = GeneralInfo.search searchArg
    assert_not_nil perl_search

    searchArg = {}
    searchArg['phone'] = '828'
    perl_search1 = GeneralInfo.search searchArg
    assert_not_nil perl_search1

    assert_equal perl_search, perl_search1
  end

  def test_login_infos_search_1
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    perl_search1 = LoginInfo.search email: general_infos(:java_cb)
    assert_not_equal perl_search, perl_search1
  end

  def test_login_infos_search_2
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    perl_search1 = LoginInfo.search email: general_infos(:perl_cb)
    assert_equal perl_search, perl_search1
  end

  def test_login_infos_search_3
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
    perl_search = LoginInfo.search email: general_infos(:perl_cb)
    assert_not_nil perl_search
  end

<<<<<<< HEAD
  def test_login_infos_search_three_one
=======
  def test_login_infos_search_3
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
    perl_search = LoginInfo.search email: 'undefined@gmail.com'
    assert_not_nil perl_search
  end
end
