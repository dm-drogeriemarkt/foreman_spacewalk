require 'test_plugin_helper'

module ForemanSpacewalk
  class HostsControllerTest < ActionController::TestCase
    setup do
      User.current = users(:admin)
    end

    let(:host) { FactoryBot.create(:host, :managed) }

    describe 'changing the spacewalk proxy of multiple hosts' do
      let(:hosts) { FactoryBot.create_list(:host, 2, :with_spacewalk) }
      let(:spacewalk_proxy) do
        FactoryBot.create(
          :smart_proxy,
          :spacewalk,
          organizations: [
            hosts.first.organization
          ],
          locations: [
            hosts.first.location
          ]
        )
      end
      before do
        @request.env['HTTP_REFERER'] = hosts_path
      end

      test 'show a host selection' do
        host_ids = hosts.map(&:id)
        post :select_multiple_spacewalk_proxy,
             params: { host_ids: host_ids },
             session: set_session_user,
             xhr: true
        assert_response :success
        hosts.each do |host|
          assert response.body =~ /#{host.name}/m
        end
      end

      test 'should change the proxy' do
        hosts.each do |host|
          refute_equal spacewalk_proxy, host.spacewalk_proxy
        end

        params = {
          host_ids: hosts.map(&:id),
          proxy: { proxy_id: spacewalk_proxy.id }
        }

        post :update_multiple_spacewalk_proxy, params: params, session: set_session_user

        assert_response :found
        assert_redirected_to hosts_path
        assert_nil flash['error']
        assert_equal "The Spacewalk proxy of the selected hosts was set to #{spacewalk_proxy.name}", flash['success']

        hosts.each do |host|
          as_admin do
            assert_equal spacewalk_proxy, host.reload.spacewalk_proxy
          end
        end
      end
    end
  end
end
