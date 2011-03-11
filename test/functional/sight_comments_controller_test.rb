require 'test_helper'

class SightCommentsControllerTest < ActionController::TestCase
    setup do
        @sight_comment = sight_comments(:one)
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index, :sight_id => @sight.id
        assert_response :success
        assert_not_nil assigns(:sight_comments)
    end
    
    test "should get new" do
        get :new, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should create sight_comment" do
        assert_difference('SightComment.count') do
            post :create, :sight_id => @sight.id,
                :sight_comment => {:comment => "this is a comment"}
        end
    end
    
    test "should show sight_comment" do
        get :show, :id => @sight_comment.id, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should get edit" do
        get :edit, :id => @sight_comment.id, :sight_id => @sight.id
        assert_response :success
    end
    
    test "should update sight_comment" do
        put :update, :id => @sight_comment.id, :sight_id => @sight.id, 
            :sight_comment => {:comment => "This is a different comment"}
        assert SightComment.find(@sight_comment.id).comment == "This is a different comment"
    end
    
    test "should destroy sight_comment" do
        assert_difference('SightComment.count', -1) do
            delete :destroy, :id => @sight_comment.id, :sight_id => @sight.id
        end
    end
end
