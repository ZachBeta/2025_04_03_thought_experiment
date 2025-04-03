require "test_helper"

class TutorialProgressTest < ActiveSupport::TestCase
  def setup
    @progress = TutorialProgress.new(
      current_stage: "welcome",
      session_id: "test-session-123"
    )
  end

  test "should be valid" do
    @progress.valid?
    assert @progress.valid?
  end

  test "should require valid stage" do
    @progress.current_stage = "invalid"
    assert_not @progress.valid?

    TutorialProgress::STAGES.each do |stage|
      @progress.current_stage = stage
      assert @progress.valid?
    end
  end

  test "should require unique session_id" do
    @progress.save!
    duplicate = TutorialProgress.new(
      current_stage: "welcome",
      session_id: "test-session-123"
    )
    assert_not duplicate.valid?
  end

  test "should mark steps as complete" do
    @progress.save!
    @progress.mark_step_complete("intro")
    
    assert_includes @progress.completed_steps["welcome"], "intro"
  end

  test "should check stage completion" do
    @progress.save!
    assert_not @progress.current_stage_complete?

    required_steps = TutorialProgress.required_steps_for("welcome")
    required_steps.times { |i| @progress.mark_step_complete("step_#{i}") }
    
    assert @progress.current_stage_complete?
  end

  test "should advance stage" do
    @progress.save!
    initial_stage = @progress.current_stage
    @progress.advance_stage!
    
    assert_equal TutorialProgress::STAGES[1], @progress.current_stage
    assert_not_equal initial_stage, @progress.current_stage
  end

  test "should not advance beyond final stage" do
    @progress.current_stage = TutorialProgress::STAGES.last
    @progress.save!
    
    assert_not @progress.advance_stage!
    assert_equal TutorialProgress::STAGES.last, @progress.current_stage
  end

  test "should calculate progress percentage" do
    @progress.save!
    assert_equal 7, @progress.progress_percentage # First stage, no completion

    @progress.mark_step_complete("step1")
    @progress.mark_step_complete("step2")
    assert_equal 14, @progress.progress_percentage # First stage complete

    @progress.advance_stage!
    assert_equal 21, @progress.progress_percentage # Second stage, no completion
  end

  test "should find or create session" do
    session = TutorialProgress.find_or_create_session("new-session-123")
    assert_not_nil session
    assert_equal "welcome", session.current_stage
    assert_equal({}, session.completed_steps)

    same_session = TutorialProgress.find_or_create_session("new-session-123")
    assert_equal session, same_session
  end
end
