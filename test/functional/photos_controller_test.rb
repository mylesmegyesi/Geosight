require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)
        @user = users(:one)
        UserSession.create(@user)
        @unassigned_photo = Photo.create(:user_id => @user.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        @photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
    end
    
    teardown do
        @unassigned_photo.destroy
        @photo.destroy
    end
    
    test "should get index with sight" do
        get :index, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should get index without sight" do
        get :index
        assert_response :success
    end
    
    test "should show photo" do
        get :show, :id => @photo.id
        assert_response :success
    end
    
    test "should show unassigned photo" do
        get :show, :id => @unassigned_photo.id
        assert_redirected_to edit_photo_path(@unassigned_photo)
    end
    
    test "should get edit" do
        get :edit, :id => @photo.id
        assert_redirected_to photo_path(@photo)
    end
    
    test "should get unassigned edit" do
        get :edit, :id => @unassigned_photo.id
        assert_response :success
    end
    
    test "should add to existing sight" do
        put :update, :id => @unassigned_photo.id, :photo => {:existing_sight_id => @sight.id}
        assert_redirected_to photo_path(@unassigned_photo)
    end
    
    test "should add to new sight" do
        put :update, :id => @unassigned_photo.id, :photo => {:existing_sight_id => "0",
            :name => "new sight", :radius => 10 }
        assert_redirected_to photo_path(@unassigned_photo)
    end
    
    test "should destroy photo" do
        photo = Photo.create(:user_id => @user.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        assert_difference('Photo.count', -1) do
            delete :destroy, :id => photo.id
        end
    end
end
