require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get record" do
    get :record
    assert_response :success
  end

end
