Function Editor_NewStage_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	newStage_window = Gui_WindowOpen("New Stage", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	
	newStage_main_panel = Gui_CreatePanel(300, 400)
	Gui_Window_AddPanel(newStage_window, newStage_main_panel, 0, 0)
	
	WaitKey
	
	Gui_WindowClose(newStage_window)
End Function
