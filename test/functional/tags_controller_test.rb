require 'test_helper'

class TagsControllerTest < ActionController::TestCase
    setup do
        @tag = tags(:one)
        @sight = sights(:one)      
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should show tag" do
        get :show, :id => @tag.id
        assert_response :success
    end
    
    test "should not show tag" do
        id = Tag.all.last.id + 1
        get :show, :id => id
        assert_redirected_to not_found_path
    end
    
    test "should create tag" do
        len = @sight.tags.length
        post :create, :sight_id => @sight.id, :tag => {:tag => "This is a tag"}
        sight = Sight.find_by_id(@sight.id)
        assert_equal (len+1), sight.tags.length
    end
    
    test "should destroy photo_tag" do
        len = @sight.tags.length
        delete :destroy, :id => @tag.id, :sight_id => @sight.id
        sight = Sight.find_by_id(@sight.id)
        assert_equal (len-1), sight.tags.length
    end
        
end
