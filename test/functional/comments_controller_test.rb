require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
    setup do
        @comment = comments(:one)
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
    
    test "should create sight comment" do
        assert_difference('Comment.count') do
            post :create, :comment => {:sight_id => @sight.id, :comment => 4}
        end
        assert_response :found
    end
    
    test "should create photo comment" do
        assert_difference('Comment.count') do
            post :create, :comment => {:photo_id => @photo.id, :comment => 4}
        end
        assert_response :found
    end
    
    test "should update comment" do
        put :update, :id => @comment.id, :comment => {:comment => 3}
        assert_response :found
    end
    
    test "should destroy sight_comment" do
        assert_difference('Comment.count', -1) do
            delete :destroy, :id => @comment.id
        end
    end
end
