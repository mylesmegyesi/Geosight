require 'test_helper'

class TempPhotosControllerTest < ActionController::TestCase
    setup do
        @temp_photo = temp_photos(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    test "should create temp_photo" do
        assert_difference('TempPhoto.count') do
            post :create, :temp_photo => {:user_id => @user.id,
                :file => File.open(File.join(Rails.root, "test", "fixtures", "samplegps1.jpg"))
            }
        end
    end
    
    test "should show temp_photo" do
        get :show, :id => @temp_photo.to_param
        assert_response :found
    end
    
    test "should get edit" do
        get :edit, :id => @temp_photo.to_param
        assert_response :success
    end
    
    test "should update temp_photo" do
        # need to write tests for the creation of photos from temp photos
        assert true
    end
    
    test "should destroy temp_photo" do
        assert_difference('TempPhoto.count', -2) do
            delete :destroy, :id => @temp_photo.id, :user_id => @user.id
            delete :destroy, :id => temp_photos(:two).id, :user_id => @user.id
        end
        
        assert_redirected_to temp_photos_path
    end
end
