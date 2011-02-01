require 'test_helper'

class SightCommentsControllerTest < ActionController::TestCase
  setup do
    @sight_comment = sight_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sight_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sight_comment" do
    assert_difference('SightComment.count') do
      post :create, :sight_comment => @sight_comment.attributes
    end

    assert_redirected_to sight_comment_path(assigns(:sight_comment))
  end

  test "should show sight_comment" do
    get :show, :id => @sight_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sight_comment.to_param
    assert_response :success
  end

  test "should update sight_comment" do
    put :update, :id => @sight_comment.to_param, :sight_comment => @sight_comment.attributes
    assert_redirected_to sight_comment_path(assigns(:sight_comment))
  end

  test "should destroy sight_comment" do
    assert_difference('SightComment.count', -1) do
      delete :destroy, :id => @sight_comment.to_param
    end

    assert_redirected_to sight_comments_path
  end
end
