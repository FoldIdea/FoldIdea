require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test "pretty_print url convert" do
    assert_equal 'here is my url <a href="http://foldit.co" rel="nofollow" target="_blank">http://foldit.co</a>', pretty_print('here is my url http://foldit.co')
    assert_equal 'here is my url <a href="http://foldit.co" rel="nofollow" target="_blank">http://foldit.co</a> over here', pretty_print('here is my url http://foldit.co over here')
    assert_equal '<a href="http://foldit.co" rel="nofollow" target="_blank">http://foldit.co</a> is my url', pretty_print('http://foldit.co is my url')
  end

  test "pretty_print email convert" do
    assert_equal 'here is my email <a href="mailto:user@foldit.co" rel="nofollow" target="_blank">user@foldit.co</a>', pretty_print('here is my email user@foldit.co')
    assert_equal 'here is my email <a href="mailto:user@foldit.co" rel="nofollow" target="_blank">user@foldit.co</a> over here', pretty_print('here is my email user@foldit.co over here')
    assert_equal '<a href="mailto:user@foldit.co" rel="nofollow" target="_blank">user@foldit.co</a> is my email', pretty_print('user@foldit.co is my email')
  end

  test "pretty_print newlines" do
    assert_equal 'line 1<br/>line 2', pretty_print("line 1\nline 2")
  end

  test "pretty_print leading spaces" do
    assert_equal 'line 1<br/>&nbsp;&nbsp;&nbsp;* line 2', pretty_print("line 1\n   * line 2")
    assert_equal 'line 1<br/>&nbsp;&nbsp;&nbsp;*   line 2', pretty_print("line 1\n   *   line 2")
    assert_equal 'line 1<br/>&nbsp;line 2', pretty_print("line 1\n line 2")
  end
end
