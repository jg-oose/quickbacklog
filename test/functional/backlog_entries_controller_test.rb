require 'test_helper'

class BacklogEntriesControllerTest < ActionController::TestCase
  setup do
    @backlog_entry = backlog_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backlog_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backlog_entry" do
    assert_difference('BacklogEntry.count') do
      post :create, backlog_entry: @backlog_entry.attributes
    end

    assert_redirected_to backlog_entry_path(assigns(:backlog_entry))
  end

  test "should show backlog_entry" do
    get :show, id: @backlog_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backlog_entry
    assert_response :success
  end

  test "should update backlog_entry" do
    put :update, id: @backlog_entry, backlog_entry: @backlog_entry.attributes
    assert_redirected_to backlog_entry_path(assigns(:backlog_entry))
  end

  test "should destroy backlog_entry" do
    assert_difference('BacklogEntry.count', -1) do
      delete :destroy, id: @backlog_entry
    end

    assert_redirected_to backlog_entries_path
  end
end
