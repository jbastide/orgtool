require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "root layout links" do
    get root_path
    assert_template 'organizations/index'
    assert_select "a[href=?]", new_organization_path
    assert_select "form"
    assert_select "form input", { value: "Search Organizations" } 
  end

  test "new organization layout links" do
    get new_organization_path
    assert_template 'organizations/new'
    assert_select "form"
    assert_select "form input", { value: "Create Organization" }
    assert_select "a[href=?]", root_path
  end

end
