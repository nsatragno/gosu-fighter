class Menu
  MENU_Z_INDEX = 1

  MENU_OPTIONS = [[:play, "Play"], [:about, "About"]]

  def initialize
    @logo = Sprites::MENU
    @font = Gosu::Font.new 20
    @selected_item_index = 0
  end

  def update
    if Gosu::button_down? Gosu::KbW then
      @selected_item_index -= 1
    end
    if Gosu::button_down? Gosu::KbS then
      @selected_item_index += 1
    end

    if @selected_item_index >= MENU_OPTIONS.count then
      @selected_item_index = 0
    elsif @selected_item_index < 0 then
      @selected_item_index = MENU_OPTIONS.count - 1
    end

    if Gosu::button_down? Gosu::KbReturn then
      p 'selected', MENU_OPTIONS[@selected_item_index][0]
    end
  end

  def draw
    @logo.draw 0, 0, MENU_Z_INDEX

    i = 0
    MENU_OPTIONS.each do |option|
      @font.draw option[1], 300, i * 50 + 350, MENU_Z_INDEX, 1, 1, 0xff_ff00ff
      i += 1
    end
  end
end
