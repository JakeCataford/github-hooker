require 'require_all'
require_rel './test_helper'
class Test < MiniTest::Unit::TestCase
  include TestHelper
  def test_issue_hook_triggers_issue_action
    send_issue('issue_opened')
    assert_action_called("Add 'untriaged' label to issues with none")
  end

  def test_bad_event
    send_payload('issue_opened', 'qwijibo')
    assert_no_actions_triggered
  end
end
