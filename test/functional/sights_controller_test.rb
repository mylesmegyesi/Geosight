require 'test_helper'

class SightsControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)
        @user = users(:one)
    end
    
    test "should get index" do
        get :index
        assert_response :success, "Successful response"
        assert_not_nil assigns(:sights)
    end
    
    test "should show sight" do
        get :show, :id => @sight.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @sight.id
        assert_response :found
    end
    
    test "should update sight" do
        put :update, :id => @sight.id, :sight => { }
        assert_response :found
    end
    
    test "should destroy sight" do
        UserSession.create(@user)
        assert_difference('Sight.count', -1) do
            delete :destroy, :id => @sight.id
        end
    end
end
