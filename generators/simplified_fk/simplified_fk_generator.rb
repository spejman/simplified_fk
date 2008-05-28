require "suggest_fks"

class SimplifiedFkGenerator < Rails::Generator::Base

  def manifest
    record do |m|            
      m.migration_template "suggested_foreign_keys_simplified_fk.rb", "db/migrate",
        :assigns => { :possible_fks => SimplifiedFk.suggest_fks }
    end
  end
end
