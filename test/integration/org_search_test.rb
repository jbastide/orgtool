require 'test_helper'

class OrgSearchTest < ActionDispatch::IntegrationTest

  # A negative testcase.
  test "search for a non-existent company by name" do
    query = "poooooooo"
    get root_path, {:search => query}

    # Printing the HTML response can be useful for debugging.
    #puts response.body

    # Test for an HTML element
    assert_select 'ul', false

    # Test for a flash message.
    assert_equal 'No organization found by that name.', flash[:notice]
  end

  # A positive testcase.
  test "search for an existing company by name" do
    # Load one of our fixtures.
    query = organizations(:two).name
    expected_orgnumber = organizations(:two).orgnumber

    get root_path, {:search => query}

    # Let's make sure we don't see the flash message....
    assert_not_equal 'No organization found by that name.', flash[:notice]

    # Test for HTML elements
    assert_select 'ul', true

    # Look for the presence of a specific HTML response
    assert_select "ul>li#orgname", { text: "Orgname:#{query}" }
    assert_select "ul>li#orgnumber", { text: "Orgnumber:#{expected_orgnumber}" }
  end

end
