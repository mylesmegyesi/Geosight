require 'test_helper'

class PhotoCommentsControllerTest < ActionController::TestCase
    setup do
        @photo_comment = photo_comments(:one)
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
        @photo = Photo.create(:user_id => @user.id, :sight_id => @sight.id,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")),
            :latitude => 10, :longitude => 10)
        @photo_comment.update_attributes({:photo_id => @photo.id})
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
    
    test "should create photo_comment" do
        assert_difference('PhotoComment.count', 1) do
            post :create, :sight_id => @sight.id, :photo_id => @photo.id,
                :photo_comment => {:comment => "This is a comment"}
        end
    end
    
    test "should show photo_comment" do
        get :show, :id => @photo_comment.id, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @photo_comment.id, :sight_id => @sight.id, :photo_id => @photo.id
        assert_response :success
    end
    
    test "should update photo_comment" do
        put :update, :id => @photo_comment.id, :sight_id => @sight.id, :photo_id => @photo.id,
            :photo_comment => {:comment => "This is a different comment"}
        assert PhotoComment.find(@photo_comment.id).comment == "This is a different comment"
    end
    
    test "should destroy photo_comment" do
        assert_difference('PhotoComment.count', -1) do
            delete :destroy, :id => @photo_comment.id, :sight_id => @sight.id, :photo_id => @photo.id
        end
    end
end
