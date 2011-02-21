require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :first_name => "ben", :last_name => "rocks", 
        :email => "ben@blah.com", :password => "benrocks", 
        :password_confirmation => "benrocks" }
    end
  end
  
  test "should show user" do
    UserSession.create(users(:one))
    get :show, :id => users(:one).id
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(users(:one))
    get :edit, :id => users(:one).id
    assert_response :success
  end

  test "should update user" do
    UserSession.create(users(:one))
    put :update, :id => users(:one).id, :user => { }
    assert_response :found
  end
end
