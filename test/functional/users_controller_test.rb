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
        assert_difference('User.count') do
            post :create, :user => { :first_name => "ben", :last_name => "rocks",
                :email => "ben@blah.com", :password => "benrocks",
                :password_confirmation => "benrocks"
            }
        end
    end
    
    test "should show user" do
        get :show, :id => @user.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @user.id
        assert_response :success
    end
    
    test "should update user" do
        put :update, :id => @user.id, :user => { }
        assert_response :found
    end
end
