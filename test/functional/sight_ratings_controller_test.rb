require 'test_helper'

class SightRatingsControllerTest < ActionController::TestCase
  setup do
    @sight_rating = sight_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sight_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sight_rating" do
    assert_difference('SightRating.count') do
      post :create, :sight_rating => @sight_rating.attributes
    end

    assert_redirected_to sight_rating_path(assigns(:sight_rating))
  end

  test "should show sight_rating" do
    get :show, :id => @sight_rating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sight_rating.to_param
    assert_response :success
  end

  test "should update sight_rating" do
    put :update, :id => @sight_rating.to_param, :sight_rating => @sight_rating.attributes
    assert_redirected_to sight_rating_path(assigns(:sight_rating))
  end

  test "should destroy sight_rating" do
    assert_difference('SightRating.count', -1) do
      delete :destroy, :id => @sight_rating.to_param
    end

    assert_redirected_to sight_ratings_path
  end
end
