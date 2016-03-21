--[[ Constants DO NOT CHANGE ]]
--$$ version identicaly as stated in info.json file, but TYPE is float
MOD_VERSION = 0.24

--[[ Constants YOU CAN CHANGE !!multiplayer desync warning: every player needs an exact copy of the mods including their config files!! ]]
--$$ disable this mod entirely
MOD_ENABLED = true

--$$ a value of 120 gives a clock update every 2 seconds; 100=1.66 seconds; 60=1 second; 30=0.5seconds
MOD_UPDATE_INTERVAL = 30 --$$ value[10,3600]

--$$ minimal frame width for the thunderBox/settings-window ( wide-hd-screen vs old-stuff-compat )
DEFAULT_THUNDERBOX_WIDTH = 360 --$$ value[200,800]

--$$ are the buttons hidden by default yes/no : true/false
DEFAULT_ACTION_PANEL_MINIMIZED = true

--$$ show player settings by default or global settings
SHOW_PLAYER_SETTINGS = true

--$$ show clock
SHOW_CLOCK_PANEL = true

--$$ show speed+ button
SHOW_SPEED_BUTTON = true

--$$ show settings+ button
SHOW_SETTINGS_BUTTON = true

--$$ remove elements (like "trains+") if they are in the top left corner, aka created befor the superGui
	--$$ ! needs fix in TheFatController Mod ! and prolly a lot of other mods too
	--$$ on Error at line #83 in control.lua of the FatController Mod,
	--$$ change line 30+- from: 	if fatControllerInit == false then
	--$$ change line 30+- to: 	if fatControllerInit == false or not game.players[1].gui.top.fatControllerButtons then
REMOVE_ELEMENTS_LEFT_OF_SUPER_TOP_GUI = false

--$$ remove all Mod-Gui-controlls on Save (actualy before the actual file-saving realy starts)
	--$$ gives a clean save-game-image/screenshot, though feels irritating if combined with a healthy/fast autosave
	--$$ could maybe fix mp desync issues on saving gui-data (dunno rly, had no need of this, yet;)
REMOVE_GUI_ON_SAVE = false

--$$ show developer Buttons and print things usefull for testing stuff in this mod
DEVELOPER_MODE = false

--$$ slow gui update: For developers. Can prevent gui-update-bugs repeating to fast for debugging
SLOW_GUI_UPDATE_MODE = false

--$$ safe multiplayer --> only player 1 gets speed changing options and thunder+
SAFE_MULTIPLAYER_MODE = true


