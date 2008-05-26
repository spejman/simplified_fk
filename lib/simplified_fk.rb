module SimplifiedFk

  def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"
    case $adapter
    when 'mysql', 'postgresql'
      execute "ALTER TABLE #{from_table} ADD CONSTRAINT #{constraint_name} FOREIGN KEY (#{from_column}) REFERENCES #{to_table} (id);"
    else
      puts "   [NOTE] add_foreign_key is not available on this adapter."
    end
  end

  def remove_foreign_key(from_table, from_column)
    constraint_name = "fk_#{from_table}_#{from_column}"
    case $adapter
    when 'mysql'
      execute "ALTER TABLE #{from_table} DROP FOREIGN KEY #{constraint_name};"
    when 'postgresql'
      execute "ALTER TABLE #{from_table} DROP CONSTRAINT #{constraint_name};"
    else
      puts "   [NOTE] remove_foreign_key is not available on this adapter."
    end
  end

end

$adapter = ActiveRecord::Base.configurations[RAILS_ENV || 'development']['adapter']

case $adapter
  when 'mysql':      ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, SimplifiedFk)
  when 'postgresql': ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, SimplifiedFk)
  when 'sqlite3':    ActiveRecord::ConnectionAdapters::SQLite3Adapter.send(:include, SimplifiedFk)
end