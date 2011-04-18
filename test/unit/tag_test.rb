require 'test_helper'

class PhotoTagTest < ActiveSupport::TestCase
    setup do
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should create tag" do
        tag = Tag.new({:tag => "this is a tag"})
        assert tag.save, "Tag should save"
    end
    
    test "tag too small" do
        tag = Tag.new({:tag => ""})
        assert !tag.save, "Tag saves when too small"
    end
    
    test "tag too big" do
        tag = Tag.new({:tag => "this tag is going to be too big"})
        assert !tag.save, "Tag saves when too big"
    end
    
    test "no tag" do
        tag = Tag.new()
        assert !tag.save, "Tag saves when empty"
    end
    
end
