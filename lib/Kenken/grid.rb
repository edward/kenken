module Kenken
  class Grid < Gosu::TextInput
    ACTIVE_COLOR = 0xcc666666

    attr_reader :x, :y

    lastNum = ""

    def initialize(window, font, x, y)
      super()

      @window, @font, @x, @y = window, font,x, y

      self.text = 1 + rand(6)
    end

    def correct_number?(str)
      str[/[1-6]/]
      str.length == 1
    end

    def draw
      @window.draw_quad(x, y, ACTIVE_COLOR,
                        x + 50, y , ACTIVE_COLOR,
                        x, y + 50, ACTIVE_COLOR,
                        x + 50, y + 50 , ACTIVE_COLOR, 0)

      if correct_number?(self.text)
        @font.draw(self.text,x,y,0)
      else
        @font.draw("-", x, y, 0)
        self.text = self.text.chop
      end
    end

    def under_point?(mouse_x, mouse_y)
      mouse_x > x && mouse_x < x + 50 &&
      mouse_y > y && mouse_y < y + 50
    end

    def change_text(text)
      self.text = text
    end
  end


  class GameWindow < Gosu::Window
    ACTIVE_COLOR = 0xccff6666

    def initialize
      super 640, 480, false
      self.caption = "KenKen"

      font = Gosu::Font.new(self, Gosu::default_font_name, 20)

      @cursor = Gosu::Image.new(self, "media/Cursor.png", false)
      #@box1 = Grid.new(self, font, 50, 50)
      #@box2 = Grid.new(self, font, 110, 50)
      #@box3 = Grid.new(self, font, 170, 50)
      #@box4 = Grid.new(self, font, 50, 110)
      #@box5 = Grid.new(self, font, 110, 110)
      #@box6 = Grid.new(self, font, 170, 110)
      @grid = [Grid.new(self, font, 50, 50), Grid.new(self, font, 50, 100), Grid.new(self, font, 50, 150),
               Grid.new(self, font, 100, 50), Grid.new(self, font, 100, 100), Grid.new(self, font, 100, 150),
               Grid.new(self, font, 150, 50), Grid.new(self, font, 150, 100), Grid.new(self, font, 150, 150)]
      #@column1 = Array.new(3) { Array.new(3){Grid.new(self, font, 50, 50)}}
      #@column2 = Array.new(3) { |index| Grid.new(self, font, 110, 50 + index * 50)}
      #@column3 = Array.new(3) { |index| Grid.new(self, font, 170, 50 + index * 50)}
    end

    def update
    end

    def draw
      @cursor.draw(mouse_x, mouse_y, 1)
      #@box1.draw
      #@box2.draw
      #@box3.draw
      #@box4.draw
      #@box5.draw
      #@box6.draw
      @grid.each {|c| c.draw}

      #@window.draw_line(0,0,ACTIVE_COLOR,mouse_x, mouse_y, ACTIVE_COLOR,0)
    end

    def button_down(id)
      if id == Gosu::MsLeft
        self.text_input = @grid.find { |tf| tf.under_point?(mouse_x, mouse_y) }
      elsif id == Gosu::KbEscape
        if self.text_input
          self.text_input = nil
        else
          close
        end
      end
    end
  end
end