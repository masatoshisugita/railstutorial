require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get  signup_path
    assert_select "title", full_title("Sign up")
  end

  def setup
    @user = users(:michael)
  end

  test "layouts linls when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path #users/index
    assert_select "a[href=?]", user_path(@user) #users_show
    assert_select "a[href=?]", edit_user_path(@user)     #users/edit
    assert_select "a[href=?]", logout_path #users/logout
  end
end
