require 'rack'

class PageServer
  def self.serve!
    handler = Rack::Handler::WEBrick
    
    app = Rack::Builder.new do
      use Rack::CommonLogger
      use Rack::ShowExceptions
      use Rack::Lint
      use Adsf::Rack::IndexFileFinder,
        :root            => options[:root],
        :index_filenames => options[:index_filenames]
      run Rack::File.new(options[:root])
    end.to_app

    %w( INT TERM ).each do |s|
      Signal.trap(s) { handler.shutdown }
    end

    handler.run(app, :Port => options[:port])
  end
end