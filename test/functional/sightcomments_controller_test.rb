require 'test_helper'

class SightcommentsControllerTest < ActionController::TestCase
  setup do
    @sightcomment = sightcomments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sightcomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sightcomment" do
    assert_difference('Sightcomment.count') do
      post :create, :sightcomment => @sightcomment.attributes
    end

    assert_redirected_to sightcomment_path(assigns(:sightcomment))
  end

  test "should show sightcomment" do
    get :show, :id => @sightcomment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sightcomment.to_param
    assert_response :success
  end

  test "should update sightcomment" do
    put :update, :id => @sightcomment.to_param, :sightcomment => @sightcomment.attributes
    assert_redirected_to sightcomment_path(assigns(:sightcomment))
  end

  test "should destroy sightcomment" do
    assert_difference('Sightcomment.count', -1) do
      delete :destroy, :id => @sightcomment.to_param
    end

    assert_redirected_to sightcomments_path
  end
end
