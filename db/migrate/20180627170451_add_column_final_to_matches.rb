class AddColumnFinalToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :final, :boolean, default: false
  end
end
