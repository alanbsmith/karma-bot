require 'test_helper'

class RegularExpressionsTest < ActiveSupport::TestCase
  test "UPDATE_KARMA_BY_NAME matches a ++ with an @" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("@alan ++")
  end

  test "UPDATE_KARMA_BY_NAME matches an ++ without an @" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("alan ++")
  end

  test "UPDATE_KARMA_BY_NAME matches a -- with an @" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("@alan --")
  end

  test "UPDATE_KARMA_BY_NAME matches an -- without an @" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("alan --")
  end

  test "UPDATE_KARMA_BY_NAME matches when there is a hyphen in the user name" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("the-alan --")
    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("the-alan ++")
  end

  test "UPDATE_KARMA_BY_NAME matches when there is an underscore in the user name" do

    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("the_alan --")
    assert_not_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("the_alan ++")
  end

  test "UPDATE_KARMA_BY_NAME does not match unless the string starts with something like a username" do
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("Blah blah blah --")
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("Blah blah blah ++")
  end

  test "UPDATE_KARMA_BY_NAME does not match when the string doesn't end with the ++ or -- operator" do
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("stop -- ")
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("stop ++ ")
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("stop +++ ")
    assert_nil RegularExpressions::UPDATE_KARMA_BY_NAME.match("stop --- ")
  end
end
