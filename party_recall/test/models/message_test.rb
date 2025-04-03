require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = Message.new(
      content: "Hello, world!",
      message_type: "user",
      active: true
    )
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "should require content" do
    @message.content = nil
    assert_not @message.valid?
  end

  test "should require valid message type" do
    @message.message_type = "invalid"
    assert_not @message.valid?

    Message::VALID_MESSAGE_TYPES.each do |type|
      @message.message_type = type
      assert @message.valid?
    end
  end

  test "should automatically count tokens" do
    @message.content = "This has five tokens here"
    @message.valid?
    assert_equal 5, @message.token_count
  end

  test "should require non-negative position" do
    @message.position = -1
    assert_not @message.valid?
  end

  test "should automatically set position on create" do
    Message.delete_all
    msg1 = Message.create!(content: "First", message_type: "user")
    msg2 = Message.create!(content: "Second", message_type: "user")
    
    assert_equal 1, msg1.position
    assert_equal 2, msg2.position
  end

  test "scopes should work correctly" do
    Message.delete_all
    active_msg = Message.create!(content: "Active", message_type: "user", active: true)
    inactive_msg = Message.create!(content: "Inactive", message_type: "user", active: false)

    assert_includes Message.active, active_msg
    assert_not_includes Message.active, inactive_msg
    assert_includes Message.inactive, inactive_msg
    assert_not_includes Message.inactive, active_msg
  end
end
