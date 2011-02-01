require 'test_helper'

class PhotoCommentsControllerTest < ActionController::TestCase
  setup do
    @photo_comment = photo_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_comment" do
    assert_difference('PhotoComment.count') do
      post :create, :photo_comment => @photo_comment.attributes
    end

    assert_redirected_to photo_comment_path(assigns(:photo_comment))
  end

  test "should show photo_comment" do
    get :show, :id => @photo_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @photo_comment.to_param
    assert_response :success
  end

  test "should update photo_comment" do
    put :update, :id => @photo_comment.to_param, :photo_comment => @photo_comment.attributes
    assert_redirected_to photo_comment_path(assigns(:photo_comment))
  end

  test "should destroy photo_comment" do
    assert_difference('PhotoComment.count', -1) do
      delete :destroy, :id => @photo_comment.to_param
    end

    assert_redirected_to photo_comments_path
  end
end
