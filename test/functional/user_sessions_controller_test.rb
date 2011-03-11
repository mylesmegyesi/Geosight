require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
    
    test "should get index" do
        assert_raises(ActionController::RoutingError) do
            get :index
        end
    end
    
    test "should get show" do
        assert_raises(ActionController::RoutingError) do
            get :index
        end
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    test "should get edit" do
        assert_raises(ActionController::RoutingError) do
            get :edit
        end
    end
    
    test "should update sight" do
        assert_raises(ActionController::RoutingError) do
            post :update
        end
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
