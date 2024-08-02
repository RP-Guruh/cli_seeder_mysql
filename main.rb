require_relative 'connection.rb'
require 'progress_bar'
require "tty-prompt"

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
        tables = []
        return false if @database_connection.nil?
        result = @database_connection.query("SHOW TABLES")
        result.each do |i|
            tables << i.values.first
        end
        puts tables
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

bar = ProgressBar.new
main.table_list

prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))

choices = %w(vodka beer wine whisky bourbon)
prompt.multi_select("Select drinks?", choices)

print "\n# Please type your table: "
table_name = gets.chomp


#bar.increment until bar.finished?  # Simulates progress bar completion

if main.table_exists?(table_name)
  puts "Table '#{table_name}' exists."
else
  puts "Table '#{table_name}' does not exist."
end