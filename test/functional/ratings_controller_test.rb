require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
    setup do
        @rating = ratings(:one)
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
        @photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
    end
    
    teardown do
        @photo.destroy
    end
    
    test "should create sight rating" do
        assert_difference('Rating.count') do
            post :create, :rating => {:sight_id => @sight.id, :rating => 4}
        end
        assert_response :found
    end
    
    test "should create photo rating" do
        assert_difference('Rating.count') do
            post :create, :rating => {:photo_id => @photo.id, :rating => 4}
        end
        assert_response :found
    end
    
    test "should update rating" do
        put :update, :id => @rating.id, :rating => {:rating => 3}
        assert_response :found
    end
    
    test "should destroy sight_rating" do
        assert_difference('Rating.count', -1) do
            delete :destroy, :id => @rating.id
        end
    end
end
