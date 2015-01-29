require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
 test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
  end
end

# assert_select "div"	<div>foobar</div>
# assert_select "div", "foobar"	<div>foobar</div>
# assert_select "div.nav"	<div class="nav">foobar</div>
# assert_select "div#profile"	<div id="profile">foobar</div>
# assert_select "div[name=yo]"	<div name="yo">hey</div>
# assert_select "a[href=?]", ’/’, count: 1	<a href="/">foo</a>
# assert_select "a[href=?]", ’/’, text: "foo"