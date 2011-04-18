require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
    setup do
        @comment = comments(:one)
        @sight = sights(:one)        
        @photo = photos(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should create sight comment" do
        assert_difference("Comment.count", 1) do
            post :create, :comment => {:sight_id => @sight.id, :comment => "comment"}
        end
    end
    
    test "should create photo comment" do
        assert_difference("Comment.count", 1) do
            post :create, :comment => {:photo_id => @photo.id, :comment => "comment"}
        end
    end
    
    test "create - no comment parameter" do
        assert_no_difference("Comment.count", 1) do
            post :create
        end
    end
    
    test "should update comment" do
        put :update, :id => @comment.id, :comment => {:comment => "comment"}
        assert_response :found
    end
    
    test "update - bad id" do
        id = Comment.all.last.id + 1
        put :update, :id => id, :comment => {:comment => "comment"}
        assert_redirected_to not_found_path
    end
    
    test "should destroy sight_comment" do
        assert_difference('Comment.count', -1) do
            delete :destroy, :id => @comment.id
        end
    end
    
    test "destroy - bad id" do
        id = Comment.all.last.id + 1
        delete :destroy, :id => id
        assert_redirected_to not_found_path
    end
end
