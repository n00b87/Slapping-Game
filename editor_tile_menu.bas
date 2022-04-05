'Include "gui.bas"
'Include "strings.bas"

Function Editor_LoadTileset_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	loadTileset_window = Gui_WindowOpen("Load Tileset", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(loadTileset_window)
	
	loadTileset_main_panel = Gui_CreatePanel(300, 400)
	
	loadTileset_tsetList_ListBox = Gui_CreateListBox(GUI_FONT_W*32, GUI_FONT_H*25)
	
	loadTileset_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	loadTileset_load_button = Gui_CreateButton("Load", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(loadTileset_main_panel, loadTileset_tsetList_ListBox, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(loadTileset_main_panel, loadTileset_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(loadTileset_main_panel, loadTileset_load_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(loadTileset_window, loadTileset_main_panel, 0, 0)
	
	c_dir$ = Dir$
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\tile\\") Then
			MakeDir(c_dir$ + "\\tile\\")
		End If
		ChangeDir(c_dir$ + "\\tile\\")
	Else
		If Not DirExists(c_dir$ + "/tile/") Then
			MakeDir(c_dir$ + "/tile/")
		End If
		ChangeDir(c_dir$ + "/tile/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "png" Or ext$ = "bmp" Then
			Gui_ListBox_AddItem(loadTileset_tsetList_ListBox, f_name$ + "." + ext$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(loadTileset_tsetList_ListBox)
	
	ChangeDir$(c_dir$)
	
	While True
		If Gui_Button_Clicked(loadTileset_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadTileset_load_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_ListBox_GetValue$( loadTileset_tsetList_ListBox, Gui_ListBox_GetSelectedItem( loadTileset_tsetList_ListBox ) ))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(loadTileset_window)
	'Wait(200)
End Function

'Editor_LoadTileset_Window()
