class Menu
  MENU_Z_INDEX = 1

  MENU_OPTIONS = [[:play, "Play"], [:about, "About"]]

  def initialize(window)
    @logo = Sprites::MENU
    @font = Gosu::Font.new 20
    @selected_item_index = 0
    @window = window
  end

  def button_down(button)
    case button
      when Gosu::KbW then
        move_selection -1
      when Gosu::KbS then
        move_selection 1
      when Gosu::KbReturn then
        if MENU_OPTIONS[@selected_item_index][0] == :play then
          @window.state = Game.new
          # TODO implement about page.
        end
    end
  end

  def draw
    @logo.draw 0, 0, MENU_Z_INDEX

    i = 0
    MENU_OPTIONS.each do |option|
      @font.draw option[1], 300, i * 50 + 350, MENU_Z_INDEX, 1, 1, 0xff_ff00ff
      if @selected_item_index == i then
        Sprites::PLAYER.draw 250, i * 50 + 350, MENU_Z_INDEX, 0.5, 0.5
      end
      i += 1
    end
  end

  private
  def move_selection(delta)
    @selected_item_index += delta
    if @selected_item_index >= MENU_OPTIONS.count then
      @selected_item_index = 0
    elsif @selected_item_index < 0 then
      @selected_item_index = MENU_OPTIONS.count - 1
    end
  end

end
