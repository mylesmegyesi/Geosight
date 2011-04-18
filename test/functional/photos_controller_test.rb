require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)
        @photo = photos(:one)
        @user = users(:one)
        UserSession.create(@user)
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
    
    test "should get new" do 
        get :new
        assert_response :success
    end
    
    test "should create photo" do
        assert_difference('Photo.count', 1) do
            post :create, :photo => {:file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0089.jpg"))}
        end
    end
    
    test "create - no photo parameter" do
        post :create
        assert_redirected_to new_photo_path
    end
    
    test "should destroy photo" do
        assert_difference('Photo.count', -1) do
            delete :destroy, :id => @photo.id
        end
    end
    
    test "destroy - bad id" do
        id = Photo.all.last.id + 1
        assert_no_difference('Photo.count') do
            delete :destroy, :id => id
        end
    end
end
