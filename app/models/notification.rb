class Notification < ApplicationRecord
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, ActiveRecord::Type::Text.new, null)
  end
  
  column :message, :string
end