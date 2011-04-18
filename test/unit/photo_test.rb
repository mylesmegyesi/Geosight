require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
    setup do       
        @photo = photos(:one)
        @user = users(:one)
        UserSession.create(@user)
    end
    
    test "should create sight" do
        photo = Photo.new(:file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0089.jpg")))
        assert photo.save, "Sight should have saved"
        photo.destroy
    end
    
    test "without GPS data" do
        photo = Photo.new(:file => File.open(File.join(Rails.root, "test", "fixtures", "avatar.jpg")))
        assert !photo.save, "Sight saved without GPS data"
    end
    
    test "with manual GPS data" do
        photo = Photo.new(:latitude => 1, :longitude => 1,
            :file => File.open(File.join(Rails.root, "test", "fixtures", "avatar.jpg")))
        assert photo.save, "Sight did not save with manual GPS data"
        photo.destroy
    end
    
    test "remove tags upon destroy" do
        @photo.destroy
        assert @photo.tags.empty?, "Photo did not remove entries in tag join table"
        assert @photo.sights.empty?, "Photo did not remove entries in sight join table"
    end
end
