require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)
        @photo = photos(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    teardown do
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should show photo" do
        get :show, :id => @photo.id
        assert_response :success
    end
    
    test "should not show photo" do
        id = Photo.all.last.id + 1
        get :show, :id => id
        assert_redirected_to not_found_path
    end
    
    test "should destroy photo" do
        assert_difference('Photo.count', -1) do
            delete :destroy, :id => @photo.id
        end
    end
end
