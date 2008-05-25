require 'simplified_fk'

case ActiveRecord::Base.configurations[RAILS_ENV || 'development']['adapter']
  when 'mysql':      ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, SimplifiedFk)
  when 'postgresql': ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, SimplifiedFk)
  when 'sqlite3':    ActiveRecord::ConnectionAdapters::SQLite3Adapter.send(:include, SimplifiedFk)
end