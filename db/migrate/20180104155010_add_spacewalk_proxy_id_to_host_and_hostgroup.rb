class AddSpacewalkProxyIdToHostAndHostgroup < ActiveRecord::Migration
  def change
    add_column :hosts, :spacewalk_proxy_id, :integer, index: true
    add_column :hostgroups, :spacewalk_proxy_id, :integer, index: true
  end
end
