class RenameFolloerIdColumnToRelationships < ActiveRecord::Migration
  def change
  	rename_column :relationships, :folloer_id, :follower_id
  end
end
