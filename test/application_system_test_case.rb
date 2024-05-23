require 'test_helper'

# == Class: ApplicationSystemTestCase
#
# This is a system test case class that inherits from ActionDispatch::SystemTestCase.
# It sets how system tests will be driven, in this case by selenium, using Chrome as browser,
# and having a screen size equal to 1400px by 1400px.
#
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
