class AddPublicIdToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :public_id, :uuid, default: 'uuid_generate_v4()'
    add_column :teams, :image, :string
    add_column :teams, :flag, :string
  end
end
