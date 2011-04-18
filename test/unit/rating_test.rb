require 'test_helper'

class SightRatingTest < ActiveSupport::TestCase
    setup do
        @sight = sights(:one)
        @photo = photos(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should create sight rating" do
        rating = Rating.new({:rating => 4, :sight_id => @sight.id})
        assert rating.save, "Rating is not saving when valid"
    end
    
    test "should create photo rating" do
        rating = Rating.new({:rating => 4, :photo_id => @photo.id})
        assert rating.save, "Rating is not saving when valid"
    end
    
    test "without rating" do
        rating = Rating.new({:photo_id => @photo.id})
        assert !rating.save, "Rating is saving when rating is not given"
    end
    
    test "without parent" do
        rating = Rating.new({:rating => 4})
        assert !rating.save, "Rating is saving when not parent is given"
    end
    
    test "rating too big" do
        rating = Rating.new({:rating => 6, :photo_id => @photo.id})
        assert !rating.save, "Rating is saving when rating is too large"
    end
    
    test "rating too small" do
        rating = Rating.new({:rating => 0, :photo_id => @photo.id})
        assert !rating.save, "Rating is saving when rating is too small"
    end
    
    test "rating not integer" do
        rating = Rating.new({:rating => "a string", :photo_id => @photo.id})
        assert !rating.save, "Rating is saving when rating is a string"
    end
end
