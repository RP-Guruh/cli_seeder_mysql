require_relative 'connection.rb'
require 'progress_bar'
require "tty-prompt"
require "tty-box"

class Main

    def initialize
        @connection = Connection.new
        @connection.connect
        @database_connection = @connection.db
   
    end

    def table_exists?(table_name)
        return false if @database_connection.nil?
    
        result = @database_connection.query("SHOW TABLES LIKE '#{table_name}'")
        result.count > 0
    end

    def table_list
        @tables = []
        return false if @database_connection.nil?
        result = @database_connection.query("SHOW TABLES")
        result.each do |i|
            @tables << i.values.first
        end
        return @tables
    end

    def analyzed_table
        result = @database_connection.query("DESC users")
      
       
        result.each do |row|
          puts "Field: #{row['Field']}"
          puts "Type: #{row['Type']}"
          puts "Null: #{row['Null']}"
          puts "Key: #{row['Key']}"
          puts "Default: #{row['Default']}"
          puts "Extra: #{row['Extra']}"
          puts "------------------------"
        end
      end
      
end

# Main execution
puts "
\t███████╗███████╗███████╗██████╗ ███████╗██████╗ 
\t██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗
\t███████╗█████╗  █████╗  ██║  ██║█████╗  ██████╔╝
\t╚════██║██╔══╝  ██╔══╝  ██║  ██║██╔══╝  ██╔══██╗
\t███████║███████╗███████╗██████╔╝███████╗██║  ██║
\t╚══════╝╚══════╝╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝   
"

main = Main.new
prompt = TTY::Prompt.new


# bar = ProgressBar.new
# main.table_list

listOfTable = main.table_list


tableChoice = prompt.multi_select("\n\tSelect table, you can choose multiple table ?", listOfTable)
box = TTY::Box.success(tableChoice.join(","))

puts box

main.analyzed_table
