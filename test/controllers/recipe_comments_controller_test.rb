require 'test_helper'

class RecipeCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get recipe_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get recipe_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get recipe_comments_update_url
    assert_response :success
  end

  test "should get create" do
    get recipe_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get recipe_comments_destroy_url
    assert_response :success
  end

end
