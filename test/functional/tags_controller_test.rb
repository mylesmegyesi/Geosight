require 'test_helper'

class TagsControllerTest < ActionController::TestCase
    setup do
        @tag = tags(:one)
        @sight = sights(:one)   
        @photo = photos(:one)
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
    
    test "should create sight tag" do
        len = @sight.tags.length
        post :create, :sight_id => @sight.id, :tag => {:tag => "This is a tag"}
        sight = Sight.find_by_id(@sight.id)
        assert_equal (len+1), sight.tags.length
    end
    
    test "should create photo tag" do
        len = @photo.tags.length
        post :create, :photo_id => @photo.id, :tag => {:tag => "This is a tag"}
        photo = Photo.find_by_id(@photo.id)
        assert_equal (len+1), photo.tags.length
    end
    
    test "create - no tag paramater" do
        post :create, :photo_id => @photo.id
        assert_redirected_to photo_path(@photo)
    end
    
    test "create - no tag" do
        post :create, :photo_id => @photo.id, :tag => {}
        assert_redirected_to photo_path(@photo)
    end
    
    test "create - no parent" do
        post :create, :tag => {}
        assert_redirected_to not_found_path
    end
    
    test "create - existing tag" do
        tag = @photo.tags.first
        assert_no_difference("Tag.count") do
            post :create, :photo_id => @photo.id, :tag => {:tag => tag.tag}
        end
    end
    
    test "should destroy photo_tag" do
        len = @sight.tags.length
        delete :destroy, :id => @tag.id, :sight_id => @sight.id
        sight = Sight.find_by_id(@sight.id)
        assert_equal (len-1), sight.tags.length
    end
    
    test "should destroy tag" do
        assert_difference("Tag.count", -1) do
            @tag.photos.each do |photo|
                delete :destroy, :id => @tag.id, :photo_id => photo.id
            end
            @tag.sights.each do |sight|
                delete :destroy, :id => @tag.id, :sight_id => sight.id
            end
        end
    end
    
    test "destroy - bad id" do
        id = Tag.all.last.id + 1
        delete :destroy, :id => id, :sight_id => @sight.id
        assert_redirected_to not_found_path
    end
    
    test "destroy - no parent" do
        delete :destroy, :id => @tag.id
        assert_redirected_to not_found_path
    end
        
end
