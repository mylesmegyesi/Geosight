require 'test_helper'

class SightsControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should show sight" do
        get :show, :id => @sight.id
        assert_response :success
    end
    
    test "should destroy sight" do
        assert_difference('Sight.count', -1) do
            delete :destroy, :id => @sight.id
        end
    end
end