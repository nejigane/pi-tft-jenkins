require "pi/tft/jenkins/version"
require "rsvg2"
require "sinatra/base"

module Pi
  module Tft
    module Jenkins
      SCREEN_DEVICE = '/dev/fb1'
      SCREEN_WIDTH = 320
      SCREEN_HEIGHT = 240
      
      @@logo = RSVG::Handle.new_from_file(File.join(File.dirname(__FILE__), 'jenkins', 'logo.svg'))
      @@surface = Cairo::ImageSurface.new(Cairo::FORMAT_RGB16_565, SCREEN_WIDTH, SCREEN_HEIGHT)

      def self.update_screen(name, status)
        if status == 'SUCCESS'
          background = [1, 1, 1]
          status_text = [0, 0, 0]
          name_text = [0.4, 0.4, 0.4]
        elsif status.match(/FAIL.*/)
          background = [0.8, 0, 0]
          status_text = [1, 1, 1]
          name_text = [0.4, 0, 0]
        else
          background = [1, 1, 0]
          status_text = [0, 0, 0]
          name_text = [0.4, 0.4, 0]
        end

        context = Cairo::Context.new(@@surface)
        context.select_font_face('DejaVu Sans', 0, Cairo::FontWeight::BOLD)

        context.set_source_rgb(background[0], background[1], background[2])
        context.rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        context.fill

        context.set_source_rgb(status_text[0], status_text[1], status_text[2])
        context.move_to(SCREEN_WIDTH * 0.4 + 10, SCREEN_HEIGHT * 0.5)
        context.font_size = 30
        context.show_text(status)

        context.set_source_rgb(name_text[0], name_text[1], name_text[2])
        context.move_to(SCREEN_WIDTH * 0.4 + 10, SCREEN_HEIGHT * 0.6)
        context.font_size = 18
        context.show_text(name)

        context.translate(20, 50)
        context.scale(0.45, 0.45)
        context.render_rsvg_handle(@@logo)

        open(SCREEN_DEVICE, "w") {|io| io.puts @@surface.data }
      end

      class App < Sinatra::Base
        set :environment, :production
        get '/:status' do
          Pi::Tft::Jenkins.update_screen('Your Jenkins Job', params[:status].upcase)
        end
      end
    end
  end
end
