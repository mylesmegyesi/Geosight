require 'test_helper'

class SightTest < ActiveSupport::TestCase
    
    setup do
        @sight = sights(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    teardown do
    end
    
    # test a good sight
    test "should save" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight", :radius => 10,
            :latitude => 10, :longitude => 10)
        assert sight.save, "Sight should have saved"
    end
    
    # test validations
    
    test "no name" do
        sight = Sight.new(:user_id => @user.id, :radius => 10,
            :latitude => 10, :longitude => 10)
        assert !sight.save, "Sight saved without name"
    end
    
    test "no radius" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :latitude => 10, :longitude => 10)
        assert !sight.save, "Sight saved without radius"
    end
    
    test "no latitude" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => 10, :longitude => 10)
        assert !sight.save, "Sight saved without latitude"
    end
    
    test "no longtude" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => 10, :latitude => 10)
        assert !sight.save, "Sight saved without longitude"
    end
    
    test "invalid name length" do
        sight = Sight.new(:user_id => @user.id, :name => "This sight name is too long",
            :radius => 10, :latitude => 10, :longitude => 10)
        assert !sight.save, "Sight saved with invalid name length"
    end
    
    test "latitude not a number" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => 10, :latitude => "a string", :longitude => 10)
        assert !sight.save, "Sight saved with latitude not a number"
    end
    
    test "longitude not a number" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => 10, :latitude => 10, :longitude => "a string")
        assert !sight.save, "Sight saved with latitude not a number"
    end
    
    test "radius not a number" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => "a string", :latitude => 10, :longitude => 10)
        assert !sight.save, "Sight saved with radius not a number"
    end
    
    test "radius too big" do
        sight = Sight.new(:user_id => @user.id, :name => "new sight",
            :radius => 201, :latitude => 10, :longitude => 10)
        assert !sight.save, "Sight saved with radius greater than 100"
    end

end
