require "test_helper"

class DataEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_entry = data_entries(:one)
  end

  test "should get index" do
    get data_entries_url, as: :json
    assert_response :success
  end

  test "should create data_entry" do
    assert_difference("DataEntry.count") do
      post data_entries_url, params: { data_entry: { name: @data_entry.name } }, as: :json
    end

    assert_response :created
  end

  test "should show data_entry" do
    get data_entry_url(@data_entry), as: :json
    assert_response :success
  end

  test "should update data_entry" do
    patch data_entry_url(@data_entry), params: { data_entry: { name: @data_entry.name } }, as: :json
    assert_response :success
  end

  test "should destroy data_entry" do
    assert_difference("DataEntry.count", -1) do
      delete data_entry_url(@data_entry), as: :json
    end

    assert_response :no_content
  end
end
