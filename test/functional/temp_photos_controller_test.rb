require 'test_helper'

class TempPhotosControllerTest < ActionController::TestCase
  setup do
    @temp_photo = temp_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temp_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp_photo" do
    assert_difference('TempPhoto.count') do
      post :create, :temp_photo => @temp_photo.attributes
    end

    assert_redirected_to temp_photo_path(assigns(:temp_photo))
  end

  test "should show temp_photo" do
    get :show, :id => @temp_photo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @temp_photo.to_param
    assert_response :success
  end

  test "should update temp_photo" do
    put :update, :id => @temp_photo.to_param, :temp_photo => @temp_photo.attributes
    assert_redirected_to temp_photo_path(assigns(:temp_photo))
  end

  test "should destroy temp_photo" do
    assert_difference('TempPhoto.count', -1) do
      delete :destroy, :id => @temp_photo.to_param
    end

    assert_redirected_to temp_photos_path
  end
end
