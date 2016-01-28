require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    @organization = organizations(:one)
    #byebug
  end

  # Just test for the presence of the page and organizations instance variable.
  test "should get index" do
    get :index
    assert_response :success

    # I'm leaving in this line as an example. Because our index action can
    # allow nil values for @organization, if the search returns no results.

    #assert_not_nil assigns(:organization)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      # Note: test data in the hash.
      post :create, organization: { name: 'test1', orgnumber: '99' }
      #byebug
    end

    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should show organization" do
    get :show, id: @organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organization
    assert_response :success
  end

  # Modifying this test to match the desired action, which isn't a redirect
  # to the organization path.
  test "should update organization" do
    patch :update, id: @organization, organization: { orgnumber: 999, name: 'test99' }
    assert_redirected_to root_path
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end

    assert_redirected_to organizations_path
  end
end
