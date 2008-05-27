module SimplifiedFk
  def self.suggest_fks
    possible_fks = []
    ActiveRecord::Base.connection.tables.each do |table_name|
      table_name.classify.constantize.reflections.each do |assoc_name, a_type|
        assoc_type = a_type.macro
        possible_fks << [table_name.to_s, :"#{assoc_name.singularize}_id", assoc_name.to_s] if assoc_type == :belongs_to
      end
    end
    possible_fks
  end
end