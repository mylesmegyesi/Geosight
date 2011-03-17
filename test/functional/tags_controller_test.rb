require 'test_helper'

class PhotoTagsControllerTest < ActionController::TestCase
    setup do
        @photo_tag = photo_tags(:one)
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
        @photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        @photo_tag.update_attributes({:photo_id => @photo.id})
    end
    
    teardown do
        Photo.all.each do |photo|
            photo.destroy
        end
    end
    
    test "should get index" do
        get :index, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should get new" do
        get :new, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should create photo_tag" do
        assert_difference('PhotoTag.count', 1) do
            post :create, :sight_id => @sight.id, :photo_id => @photo.id,
                :photo_tag => {:tag => "This is a tag"}
        end
    end
    
    test "should show photo_tag" do
        get :show, :id => @photo_tag.id, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @photo_tag.id, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should update photo_tag" do
        put :update, :id => @photo_tag.id, :sight_id => @sight.id, :photo_id => @photo.id,
            :photo_tag => {:tag => "This is a different tag"}
        assert PhotoTag.find(@photo_tag.id).tag == "This is a different tag"
    end
    
    test "should destroy photo_tag" do
        assert_difference('PhotoTag.count', -1) do
            delete :destroy, :id => @photo_tag.id, :sight_id => @sight.id, :photo_id => @photo.id
        end
    end
        
end
