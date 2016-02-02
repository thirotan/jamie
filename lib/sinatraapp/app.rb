require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/formkeeper'
require 'sinatra/flash'


require 'slim'
require 'redcarpet'

require 'mysql2'
require 'mysql2-cs-bind'

require 'digest/sha1'


module SinatraApp
  class Application < Sinatra::Base
    register Sinatra::FormKeeper
    register Sinatra::Flash
    configure do
      set :bind, '0.0.0.0'
      set :public_folder, File.dirname(__FILE__) + '/../../public'
      set :root, File.dirname(__FILE__) + '/../../'
      enable :sessions
    end

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
      def br(str) 
        data = h str
        data.gsub(/\r\n|\r|\n/, "<br />")
      end

      # すべてのentryを取得する
      def get_entry_list
        db.xquery('SELECT * FROM entries ORDER BY created_at DESC')
      end

      def get_time(time)
        time.strftime("%Y/%m/%d %H:%M:%S")
      end

      def get_markdown(body)
        markdown.render(body)
      end
 
    end
 
    def markdown
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end

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


    # 投稿を保存する
    def add_entry(name, body, entry_id, date)
      db.xquery('INSERT INTO  entries(entry_id, name, body, created_at, updated_at) VALUES (?, ?, ?, ?, ?)', entry_id, name, body, date, date )
    end

   
    # 個別に1つのentryを取得する
    def get_entry(entry_id)
      db.xquery('SELECT * FROM entries WHERE entry_id = ?', entry_id)
    end

    before do
      flash[:error] = nil
    end
    
    get '/' do
      slim :index
    end

    post '/add' do
      form do
        filters :strip
        field :name, :default => '名無しさん', :length => 0..30
        field :body, :present => true, :length => 1..1000
      end
      if form.failed?
        flash[:error] = "本文に何も書いてないです"
        redirect '/'
      else
        created_at = Time.now
        entry_id = Digest::SHA1.hexdigest("#{created_at}#{body}");
        add_entry(form[:name], form[:body], entry_id, created_at)
        redirect '/'
      end
    end

    get '/entry/:id' do
      entry_list = get_entry(params[:id])
      @entry = entry_list.first[:body]
      slim :entry 
    end 

    get '/entry/:id/raw' do
      entry_list = get_entry(params[:id])
      @entry = entry_list.first[:body]
      slim :raw_entry 
    end 
 
    get '/entry/:id/markdown' do
      entry_list = get_entry(params[:id])
      @entry = get_markdown(entry_list.first[:body])
      slim :markdown_entry
    end 

  end
end
