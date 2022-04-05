'Include "gui.bas"
'Include "strings.bas"

Function Editor_NewStage_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	newStage_window = Gui_WindowOpen("New Stage", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(newStage_window)
	
	newStage_main_panel = Gui_CreatePanel(300, 400)
	
	newStage_stageName_label = Gui_CreateLabel("Stage Name", GUI_FONT_W*11, GUI_FONT_H+1)
	newStage_stageName_field = Gui_CreateTextField(GUI_FONT_W*16, GUI_FONT_H+1)
	
	newStage_stageWidth_label = Gui_CreateLabel("Width In Tiles", GUI_FONT_W*15, GUI_FONT_H+1)
	newStage_stageWidth_field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	
	newStage_stageHeight_label = Gui_CreateLabel("Height In Tiles", GUI_FONT_W*15, GUI_FONT_H+1)
	newStage_stageHeight_field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	
	newStage_tileWidth_label = Gui_CreateLabel("Tile Width", GUI_FONT_W*15, GUI_FONT_H+1)
	newStage_tileWidth_field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	
	newStage_tileHeight_label = Gui_CreateLabel("Tile Height", GUI_FONT_W*15, GUI_FONT_H+1)
	newStage_tileHeight_field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	
	newStage_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	newStage_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageName_label, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageName_field, GUI_FONT_W*12, GUI_FONT_H)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageWidth_label, GUI_FONT_W, GUI_FONT_H*4)
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageWidth_field, GUI_FONT_W*15, GUI_FONT_H*4)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageHeight_label, GUI_FONT_W, GUI_FONT_H*5+4)
	Gui_Panel_AddObject(newStage_main_panel, newStage_stageHeight_field, GUI_FONT_W*15, GUI_FONT_H*5+4)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_tileWidth_label, GUI_FONT_W, GUI_FONT_H*6+8)
	Gui_Panel_AddObject(newStage_main_panel, newStage_tileWidth_field, GUI_FONT_W*15, GUI_FONT_H*6+8)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_tileHeight_label, GUI_FONT_W, GUI_FONT_H*7+12)
	Gui_Panel_AddObject(newStage_main_panel, newStage_tileHeight_field, GUI_FONT_W*15, GUI_FONT_H*7+12)
	
	Gui_Panel_AddObject(newStage_main_panel, newStage_cancel_button, GUI_FONT_W*6, GUI_FONT_H*12)
	Gui_Panel_AddObject(newStage_main_panel, newStage_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*12)
	
	Gui_Window_AddPanel(newStage_window, newStage_main_panel, 0, 0)
	
	Gui_TextField_SetValue(newStage_stageName_field, "Untitled")
	Gui_TextField_SetValue(newStage_stageWidth_field, "100")
	Gui_TextField_SetValue(newStage_stageHeight_field, "100")
	Gui_TextField_SetValue(newStage_tileWidth_field, "32")
	Gui_TextField_SetValue(newStage_tileHeight_field, "32")
	
	While True
		
		If Gui_Button_Clicked(newStage_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_TextField_GetValue$(newStage_stageName_field))
			WriteLine(f, Gui_TextField_GetValue$(newStage_stageWidth_field))
			WriteLine(f, Gui_TextField_GetValue$(newStage_stageHeight_field))
			WriteLine(f, Gui_TextField_GetValue$(newStage_tileWidth_field))
			WriteLine(f, Gui_TextField_GetValue$(newStage_tileHeight_field))
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(newStage_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(newStage_window)
	'Wait(200)
End Function

Function Editor_LoadStage_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	loadStage_window = Gui_WindowOpen("Load Stage", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(loadStage_window)
	
	loadStage_main_panel = Gui_CreatePanel(300, 400)
	
	loadStage_stageList_ListBox = Gui_CreateListBox(GUI_FONT_W*32, GUI_FONT_H*25)
	
	loadStage_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	loadStage_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(loadStage_main_panel, loadStage_stageList_ListBox, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(loadStage_main_panel, loadStage_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(loadStage_main_panel, loadStage_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(loadStage_window, loadStage_main_panel, 0, 0)
	
	c_dir$ = Dir$
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\stage\\") Then
			MakeDir(c_dir$ + "\\stage\\")
		End If
		ChangeDir(c_dir$ + "\\stage\\")
	Else
		If Not DirExists(c_dir$ + "/stage/") Then
			MakeDir(c_dir$ + "/stage/")
		End If
		ChangeDir(c_dir$ + "/stage/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "stage" Then
			Gui_ListBox_AddItem(loadStage_stageList_ListBox, f_name$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(loadStage_stageList_ListBox)
	
	ChangeDir$(c_dir$)
	
	While True
		If Gui_Button_Clicked(loadStage_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadStage_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_ListBox_GetValue$( loadStage_stageList_ListBox, Gui_ListBox_GetSelectedItem( loadStage_stageList_ListBox ) ) + ".stage")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(loadStage_window)
	'Wait(200)
End Function

Function Editor_SaveStage_Window(s_name$)
	If NumWindows > 1 Then
		Return 0
	End If
	
	saveStage_window = Gui_WindowOpen("Save Stage", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(saveStage_window)
	
	saveStage_main_panel = Gui_CreatePanel(300, 400)
	
	saveStage_stageName_label = Gui_CreateLabel("Stage Name", GUI_FONT_W*11, GUI_FONT_H+1)
	saveStage_stageName_field = Gui_CreateTextField(GUI_FONT_W*16, GUI_FONT_H+1)
	
	saveStage_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	saveStage_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(saveStage_main_panel, saveStage_stageName_label, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(saveStage_main_panel, saveStage_stageName_field, GUI_FONT_W*12, GUI_FONT_H)
	
	Gui_Panel_AddObject(saveStage_main_panel, saveStage_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(saveStage_main_panel, saveStage_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_TextField_SetValue(saveStage_stageName_field, s_name$)
	
	Gui_Window_AddPanel(saveStage_window, saveStage_main_panel, 0, 0)
	
	While True
		If Gui_Button_Clicked(saveStage_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(saveStage_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_TextField_GetValue$(saveStage_stageName_field) + ".stage")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(saveStage_window)
End Function

'Editor_LoadStage_Window()
