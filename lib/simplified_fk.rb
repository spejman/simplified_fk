module SimplifiedFk

  def add_foreign_key(from_table, from_column, to_table)
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    constraint_name = "fk_#{from_table}_#{from_column}"
    case config['adapter']
    when 'mysql', 'postgresql'
      execute "ALTER TABLE #{from_table} ADD CONSTRAINT #{constraint_name} FOREIGN KEY (#{from_column}) REFERENCES #{to_table} (id);"
    else
      puts "   [NOTE] add_foreign_key is not available on this adapter."
    end
  end

  def remove_foreign_key(from_table, from_column)
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    constraint_name = "fk_#{from_table}_#{from_column}"
    case config['adapter']
    when 'mysql'
      execute "ALTER TABLE #{from_table} DROP FOREIGN KEY #{constraint_name};"
    when 'postgresql'
      execute "ALTER TABLE #{from_table} DROP CONSTRAINT #{constraint_name};"
    else
      puts "   [NOTE] remove_foreign_key is not available on this adapter."
    end
  end

end