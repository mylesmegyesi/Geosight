require 'test_helper'

class SightsControllerTest < ActionController::TestCase
    setup do
        @sight = sights(:one)        
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should search" do
        get :index, :seach => "give me some sights"
        assert_response :success
    end
    
    test "should search tags" do
        get :index, :tag_search => "1", :seach => "give me some tags"
        assert_redirected_to tags_path
    end
    
    test "should show sight" do
        get :show, :id => @sight.id
        assert_response :success
    end
    
    test "should not show sight" do
        id = Sight.all.last.id + 1
        get :show, :id => id
        assert_redirected_to not_found_path
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    
    # uncomment once sight editing is added
    #
    # test "should get edit" do
    #     get :edit, :id => @sight.id
    #     assert_response :success
    # end
    # 
    # test "should not get edit" do
    #     id = Sight.all.last.id + 1
    #     get :edit, :id => id
    #     assert_redirected_to not_found_path
    # end
    
    test "should create sight" do
        assert_difference("Sight.count", 1) do
            post :create, :sight => {:name => "new sight", :latitude => 0, :longitude => 0, :radius => 100}
        end
    end
    
    test "should not create sight" do
        assert_no_difference("Sight.count") do
            post :create
        end
        assert_redirected_to new_sight_path
    end
    
    test "should update sight" do
        post :update, :id => @sight, :sight => {}
        assert_response :found
    end
    
    test "should not update sight" do
        post :update, :id => @sight
        assert_redirected_to edit_sight_path
    end
    
    test "update cannot find sight" do
        id = Sight.all.last.id + 1
        post :update, :id => id, :sight => {}
        assert_redirected_to not_found_path
    end
    
    test "should destroy sight" do
        assert_difference('Sight.count', -1) do
            delete :destroy, :id => @sight.id
        end
    end
    
    test "should not destroy sight" do
        id = Sight.all.last.id + 1
        assert_no_difference('Sight.count') do
            delete :destroy, :id => id
        end
    end
end