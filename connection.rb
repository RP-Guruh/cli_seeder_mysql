require 'mysql2'
require 'dotenv'
require 'progress_bar'

class Connection

    attr_accessor :db, :host, :port, :user, :password, :database

    def initialize
        Dotenv.load
        @host = ENV['DB_HOST']
        @port = ENV['DB_PORT']
        @user = ENV['DB_USER']
        @password = ENV['DB_PASSWORD']
        @database = ENV['DB_DATABASE']

    end

    def connect
        begin
            bar = ProgressBar.new

            puts "# Begin connection to your database"
            100.times do
                sleep 0.01
                bar.increment!
            end
            @db = Mysql2::Client.new(host: @host, port: @port, username: @user, password: @password, database: @database)

            puts "Result => Connection successfull"
        rescue Mysql2::Error => e
             puts "Error connecting to the database: #{e.message}"
        end
    end
end