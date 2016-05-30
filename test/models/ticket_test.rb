require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @user = users(:default)
    # This code is not idiomatically correct.
    @ticket = tickets(:default)
  end

  test "should be valid" do
    assert @ticket.valid?
  end

  test "user id should be present" do
    @ticket.user_id = nil
    assert_not @ticket.valid?
  end

  test "content should be present" do
    @ticket.content = "   "
    assert_not @ticket.valid?
  end

  test "order should be most recent first" do
    assert_equal tickets(:most_recent), Ticket.first
  end

end
