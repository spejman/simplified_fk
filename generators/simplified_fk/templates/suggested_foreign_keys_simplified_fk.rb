class SuggestedForeignKeysSimplifiedFk < ActiveRecord::Migration

  def self.up
    <% possible_fks.each do |possible_fk| -%> 
    add_foreign_key <%= possible_fk * ", " %>
    <% end -%> 
  end

  def self.down
    <% possible_fks.each do |possible_fk| -%> 
    remove_foreign_key <%= ":#{possible_fk[0]}, :#{possible_fk[2]}" %>
    <% end -%> 
  end

end