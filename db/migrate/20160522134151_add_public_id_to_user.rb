class AddPublicIdToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :public_id, :uuid, default: 'uuid_generate_v4()'
  end
end
