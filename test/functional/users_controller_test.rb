require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    
    setup do
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    test "should create user" do
        assert_difference('User.count', 1) do
            post :create, :user => { :first_name => "ben", :last_name => "rocks",
                :email => "ben@blah.com", :password => "benrocks",
                :password_confirmation => "benrocks"
            }
        end
    end
    
    test "should show user" do
        get :show
        assert_response :success
    end
    
    test "should get edit" do
        get :edit
        assert_response :success
    end
    
    test "should update user" do
        put :update, :user => {}
        assert_response :found
    end
    
    test "should destroy user" do
        assert_difference('User.count', -1) do
            delete :destroy
        end
    end
end
