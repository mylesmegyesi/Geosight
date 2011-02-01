require 'test_helper'

class PhotoTagsControllerTest < ActionController::TestCase
  setup do
    @photo_tag = photo_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_tag" do
    assert_difference('PhotoTag.count') do
      post :create, :photo_tag => @photo_tag.attributes
    end

    assert_redirected_to photo_tag_path(assigns(:photo_tag))
  end

  test "should show photo_tag" do
    get :show, :id => @photo_tag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @photo_tag.to_param
    assert_response :success
  end

  test "should update photo_tag" do
    put :update, :id => @photo_tag.to_param, :photo_tag => @photo_tag.attributes
    assert_redirected_to photo_tag_path(assigns(:photo_tag))
  end

  test "should destroy photo_tag" do
    assert_difference('PhotoTag.count', -1) do
      delete :destroy, :id => @photo_tag.to_param
    end

    assert_redirected_to photo_tags_path
  end
end
