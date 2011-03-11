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
    
    test "should get new" do
        assert_raises(ActionController::RoutingError) do
            get :new
        end
    end
    
    test "should show sight" do
        get :show, :id => @sight.id
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
    
    test "should create sight" do
        assert_raises(ActionController::RoutingError) do
            post :create, :sight => {:name => "new sight", :radius => 10,
                :latitude => 10, :longitude => 10}
        end
    end
    
    test "should destroy sight" do
        assert_difference('Sight.count', -1) do
            delete :destroy, :id => @sight.id
        end
    end
end