require 'colorizr'

class Contestant
    attr_reader :name
    @@possible_colors = ["red", "yellow", "blue", "pink", "light_blue"]

    def initialize(name)
        @name = name
        @color_val = @@possible_colors.sample
    end

    def to_s
        @name
    end

    def to_s_with_color
        to_s.send(@color_val)
    end
end