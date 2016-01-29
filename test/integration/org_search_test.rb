require 'test_helper'

class OrgSearchTest < ActionDispatch::IntegrationTest

  test "search for a non-existent company by name" do
    query = "poooooooo"
    get root_path, {:search => query}
    assert_equal 'No organization found by that name.', flash[:notice]
  end

  test "search for an existing company by name" do
    query = "weird"
    get root_path, {:search => query}
    assert_not_equal 'No organization found by that name.', flash[:notice]

  end

end
