require 'test_helper'

class UnassignedsControllerTest < ActionController::TestCase
  setup do
    @unassigned = unassigneds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unassigneds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unassigned" do
    assert_difference('Unassigned.count') do
      post :create, :unassigned => @unassigned.attributes
    end

    assert_redirected_to unassigned_path(assigns(:unassigned))
  end

  test "should show unassigned" do
    get :show, :id => @unassigned.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @unassigned.to_param
    assert_response :success
  end

  test "should update unassigned" do
    put :update, :id => @unassigned.to_param, :unassigned => @unassigned.attributes
    assert_redirected_to unassigned_path(assigns(:unassigned))
  end

  test "should destroy unassigned" do
    assert_difference('Unassigned.count', -1) do
      delete :destroy, :id => @unassigned.to_param
    end

    assert_redirected_to unassigneds_path
  end
end
