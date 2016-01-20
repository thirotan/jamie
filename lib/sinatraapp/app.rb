require 'sinatra/base'
require 'sinatra/contrib'
require 'slim'

require 'mysql2'
require 'mysql2-cs-bind'

require 'digest/sha1'

module SinatraApp
  class Application < Sinatra::Base
    configure do
      set :bind, '0.0.0.0'
      set :public_folder, File.dirname(__FILE__) + '/../../public'
      set :root, File.dirname(__FILE__) + '/../../'
    end

    helpers do
      def db
        return Thread.current[:like_gist_db] if Thread.current[:like_gist_db]
        config ||= YAML.load_file(settings.root+"config.yaml")
        client = Mysql2::Client.new(
          host: config['DB']['HOSTNAME'],
          port: config['DB']['PORT'],
          username: config['DB']['USERNAME'],
          password: config['DB']['PASSWORD'],
          database: config['DB']['DBNAME'],
          reconnect: true
        )
        client.query_options.merge!(symbolize_keys: true)
        Thread.current[:like_gist_db] = client
        client
      end
    end

    # すべてのentryを取得する
    def get_entry_list
      db.xquery('select * from entries')
    end

    # 投稿を保存する
    def add_entry(name, body, entry_id, date)
      db.xquery('insert into entries(entry_id, name, body, created_at, updated_at) values (?, ?, ?, ?, ?)', entry_id, name, body, date, date )
    end

    # 投稿されたentryを更新する
    def edit_entry(name, body, entry_id, date)
      db.xquery('update entries set name = ?, body = ?, updated_at = ? where entry_id = ?)', name, body, date, entry_id )
    end
   
    # 個別に1つのentryを取得する
    def get_entry(entry_id)
      db.xquery('select * from entries where entry_id = ?', entry_id)
    end
    
    get '/' do
      @entry_list = get_entry_list
      slim :index
    end

    post '/add' do
      name = params[:name]
      body = params[:body]
      created_at = Time.now
      entry_id = Digest::SHA1.hexdigest("#{created_at}#{body}");
      add_entry(name, body, entry_id, created_at)
      @entry_list = get_entry_list
      slim :index
    end

    get '/entry/:id' do
      @entry_list = get_entry(params[:id])
      slim :entry 
    end 

    get '/entry/:id/raw' do
      @entry_list = get_entry(params[:id])
      slim :raw_entry 
    end 
 
    get '/entry/:id/edit' do
      @entry_list = get_entry(params[:id])
      slim :edit 
    end

    put '/entry/:id/edit' do
      name = params[:name]
      body = params[:body]
      entry_id = params[:id]
      updated_at = Time.now
      edit_entry(name, body, entry_id, updated_at)

      @entry_list = get_entry(params[:id])
      slim :entry 
    end
  end
end
