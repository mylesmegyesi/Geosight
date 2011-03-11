require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    teardown do
        Photo.all.each do |photo|
            photo.destroy
        end
    end
    
    test "should get index" do
        get :index, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should get new" do
        assert_raises(ActionController::RoutingError) do
            get :new
        end
    end    
    
    test "should show photo" do
        photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        get :show, :id => photo.id, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should get edit" do
        assert_raises(ActionController::RoutingError) do
            get :edit
        end
    end
    
    test "should update photo" do
        assert_raises(ActionController::RoutingError) do
            get :update
        end
    end
    
    test "should destroy photo" do
        photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        assert_difference('Photo.count', -1) do
            delete :destroy, :id => photo.id, :sight_id => @sight.id
        end
    end
end
