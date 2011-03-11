require 'test_helper'

class TempPhotosControllerTest < ActionController::TestCase
    def setup
        @user = users(:one)
        UserSession.create(@user)
    end
    
    def teardown
        TempPhoto.all.each do |temp_photo|
            temp_photo.destroy
        end
        Photo.all.each do |photo|
            photo.destroy
        end
    end
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    test "should create temp_photo" do
        assert_difference('TempPhoto.count') do
            post :create, :temp_photo => {:user_id => @user.id,
                :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0089.jpg"))
            }
        end
    end
    
    test "should show temp_photo" do
        @temp_photo = TempPhoto.create(:user_id => @user.id, 
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")))
        get :show, :id => @temp_photo.id
        assert_redirected_to(:controller => "temp_photos", :action=>"edit")
    end
    
    test "should get edit" do
        @temp_photo = TempPhoto.create(:user_id => @user.id, 
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")))
        get :edit, :id => @temp_photo.id
        assert_response :success
    end 
    
    test "should create new sight" do
        @temp_photo = TempPhoto.create(:user_id => @user.id, 
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")))
        assert_difference("TempPhoto.count", -1) do
            assert_difference("Photo.count", 1) do
                assert_difference("Sight.count", 1) do
                    post :update, :id => @temp_photo.id, :old_sight_id => "0",
                        :name => "new sight", :radius => 10
                    assert_response :found
                end
            end
        end
    end
    
    test "should add to old sight" do
        @temp_photo = TempPhoto.create(:user_id => @user.id, 
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")))
        possible_sights = Sight.possible_sights(@temp_photo.latitude, @temp_photo.longitude)
        if possible_sights.empty?
            assert false, "No possible sights to add to"
        end
        assert_difference("TempPhoto.count", -1) do
            assert_difference("Photo.count", 1) do
                post :update, :id => @temp_photo.id, :old_sight_id => possible_sights[0]
                assert_response :found
            end
        end
    end
    
    test "should destroy temp_photo" do 
        @temp_photo = TempPhoto.create(:user_id => @user.id, 
            :file => File.open(File.join(Rails.root, "test", "fixtures", "IMAG0091.jpg")))
        assert_difference("TempPhoto.count", -1) do
            delete :destroy, :id => @temp_photo.id, :user_id => @user.id
        end
        assert_redirected_to temp_photos_path
    end
end
