require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord
    def self.table_name
        self.to_s.downcase.pluralize
    end

    def self.column_names
        sql="pragma table_info('#{self.table_name}')"

        table_info=DB[:conn].execute(sql)
        column_names=[]

        table_info.map do |x|
        column_names<<x["name"]
        end
        column_names.compact
    end

    def initialize(options={})
    options.each do |property, value|
    self.send("#{property}=", value)
    end
    end

    def table_name_for_insert
        self.class.table_name
    end


  
end