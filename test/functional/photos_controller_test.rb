require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
    setup do
        @user = users(:one)
        UserSession.create(@user)
    end
    
    teardown do
        TempPhoto.all.each do |temp_photo|
            temp_photo.destroy
        end
        Photo.all.each do |photo|
            photo.destroy
        end
    end
    
    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:photos)
    end
    
    test "should show photo" do
        get :show, :id => @photo.to_param
        assert_response :success
    end
    
    test "should destroy photo" do
        assert_difference('Photo.count', -1) do
            delete :destroy, :id => @photo.to_param
        end
        
        assert_redirected_to photos_path
    end
end
