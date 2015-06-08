require 'test_helper'

class FlexiloadsControllerTest < ActionController::TestCase
  setup do
    @flexiload = flexiloads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flexiloads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flexiload" do
    assert_difference('Flexiload.count') do
      post :create, flexiload: { amount: @flexiload.amount, flmcs_order_id: @flexiload.flmcs_order_id, phone: @flexiload.phone, type: @flexiload.type }
    end

    assert_redirected_to flexiload_path(assigns(:flexiload))
  end

  test "should show flexiload" do
    get :show, id: @flexiload
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flexiload
    assert_response :success
  end

  test "should update flexiload" do
    patch :update, id: @flexiload, flexiload: { amount: @flexiload.amount, flmcs_order_id: @flexiload.flmcs_order_id, phone: @flexiload.phone, type: @flexiload.type }
    assert_redirected_to flexiload_path(assigns(:flexiload))
  end

  test "should destroy flexiload" do
    assert_difference('Flexiload.count', -1) do
      delete :destroy, id: @flexiload
    end

    assert_redirected_to flexiloads_path
  end
end
