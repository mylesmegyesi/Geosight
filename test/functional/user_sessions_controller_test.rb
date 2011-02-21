require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user session" do
    post :create, :user_session => { :email => "johnsmith@blah.com", :password => "benrocks" }
    user_session = UserSession.find
    assert_equal users(:one), user_session.user
  end
  
  test "should destroy user session" do
    delete :destroy
    assert_nil UserSession.find
  end
end
