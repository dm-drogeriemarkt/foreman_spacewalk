require 'test_plugin_helper'

class HostTest < ActiveSupport::TestCase
  setup do
    User.current = FactoryBot.build(:user, :admin)
  end

  context 'a host with monitoring orchestration' do
    let(:host) { FactoryBot.create(:host, :managed, :with_spacewalk) }

    test 'should queue spacewalk destroy' do
      host.queue.clear
      host.destroy!
      tasks = host.queue.all.map(&:name)
      assert_includes tasks, "Removing Spacewalk object for #{host}"
      assert_equal 1, tasks.size
    end

    test 'should remove spacewalk object on rebuild' do
      ProxyAPI::Spacewalk.any_instance.expects(:delete_host).with(host.name).returns(true).once
      host.build = true
      assert host.save
    end

    test 'should set downtime on delete with correct hostname' do
      host.queue.clear
      host.stubs(:skip_orchestration?).returns(false) # Enable orchestration
      ProxyAPI::Spacewalk.any_instance.expects(:delete_host).with(host.name).returns(true).once
      assert host.destroy
    end
  end
end
