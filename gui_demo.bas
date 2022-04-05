Include "gui.bas" 'include the gui library

win = Gui_WindowOpen("Test Gui", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 640, 480) 'open a window

example_button = Gui_CreateButton("Test Button", 100, 20) 'Create a button
example_checkbox = Gui_CreateCheckBox(16,16) 'Create a Checkbox

example_panel = Gui_CreatePanel(300, 300) 'Create a panel

Gui_Panel_AddObject(example_panel, example_checkbox, 20, 20) 'Add checkbox to panel at (x = 20, y = 20)

Gui_Panel_AddObject(example_panel, example_button, 20, 100) 'Add button to panel at (x = 20, y = 100)

Gui_Window_AddPanel(win, example_panel, 150, 50) 'Add panel to window at (x = 150, y = 50)

While Not Key(K_Q)
	'Check for Events
	If Gui_Button_Clicked(example_button) Then
		Exit While
	End If
	
	'Update events and draw gui
	Gui_Update() 'update must be called at the end of the main loop
Wend

Gui_WindowClose(win) 'closes the window
