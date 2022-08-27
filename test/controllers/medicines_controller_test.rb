require "test_helper"

class MedicinesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get medicines_show_url
    assert_response :success
  end
end
