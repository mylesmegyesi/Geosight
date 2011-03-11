require 'test_helper'

class SightRatingsControllerTest < ActionController::TestCase
    setup do
        @sight_rating = sight_ratings(:one)
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index, :sight_id => @sight.id  
        assert_response :success
        assert_not_nil assigns(:sight_ratings)
    end
    
    test "should get new" do
        get :new, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should create sight_rating" do
        assert_difference('SightRating.count') do
            post :create, :sight_id => @sight.id, :sight_rating => {:rating => 4}
        end
    end
    
    test "should show sight_rating" do
        get :show, :id => @sight_rating.id, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @sight_rating.id, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should update sight_rating" do
        put :update, :id => @sight_rating.id, :sight_id => @sight.id, :sight_rating => {:rating => 4}
        assert SightRating.find(@sight_rating.id).rating == 4
    end
    
    test "should destroy sight_rating" do
        assert_difference('SightRating.count', -1) do
            delete :destroy, :id => @sight_rating.id, :sight_id => @sight.id
        end
    end
end
