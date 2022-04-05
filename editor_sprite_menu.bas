'Include "gui.bas"
'Include "strings.bas"

Function Editor_NewSprite_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	newSprite_window = Gui_WindowOpen("New Sprite", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(newSprite_window)
	
	newSprite_main_panel = Gui_CreatePanel(300, 400)
	
	newSprite_spriteList_listBox = Gui_CreateListBox(240, 240)
	
	newSprite_frameWidth_label = Gui_CreateLabel("Frame Width", GUI_FONT_W*11, GUI_FONT_H+1)
	newSprite_frameWidth_field = Gui_CreateTextField(GUI_FONT_W*16, GUI_FONT_H+1)
	
	newSprite_frameHeight_label = Gui_CreateLabel("Frame Height", GUI_FONT_W*11, GUI_FONT_H+1)
	newSprite_frameHeight_field = Gui_CreateTextField(GUI_FONT_W*16, GUI_FONT_H+1)
	
	newSprite_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	newSprite_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_spriteList_listBox, 20, 20)
	
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_frameWidth_label, GUI_FONT_W, 260 + GUI_FONT_H*2 + 4)
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_frameWidth_field, GUI_FONT_W*12, 260 + GUI_FONT_H*2 + 4)
	
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_frameHeight_label, GUI_FONT_W, 260 + GUI_FONT_H*3 + 8)
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_frameHeight_field, GUI_FONT_W*12, 260 + GUI_FONT_H*3 + 8)
	
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(newSprite_main_panel, newSprite_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(newSprite_window, newSprite_main_panel, 0, 0)
	
	Gui_TextField_SetValue(newSprite_frameWidth_field, "32")
	Gui_TextField_SetValue(newSprite_frameHeight_field, "32")
	
	c_dir$ = Dir$
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\sprite\\") Then
			MakeDir(c_dir$ + "\\sprite\\")
		End If
		ChangeDir(c_dir$ + "\\sprite\\")
	Else
		If Not DirExists(c_dir$ + "/sprite/") Then
			MakeDir(c_dir$ + "/sprite/")
		End If
		ChangeDir(c_dir$ + "/sprite/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "png" Or ext$ = "bmp" Then
			Gui_ListBox_AddItem(newSprite_spriteList_listBox, f_name$ + "." + ext$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(newSprite_spriteList_listBox)
	
	ChangeDir$(c_dir$)
	
	While True
		If Gui_Button_Clicked(newSprite_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(newSprite_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_ListBox_GetValue$(newSprite_spriteList_listBox, Gui_ListBox_GetSelectedItem(newSprite_spriteList_listBox)))
			WriteLine(f, Gui_TextField_GetValue$(newSprite_frameWidth_field))
			WriteLine(f, Gui_TextField_GetValue$(newSprite_frameHeight_field))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(newSprite_window)
	'Wait(200)
End Function

Function Editor_LoadSprite_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	loadSprite_window = Gui_WindowOpen("Load Sprite", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(loadSprite_window)
	
	loadSprite_main_panel = Gui_CreatePanel(300, 400)
	
	loadSprite_spriteList_ListBox = Gui_CreateListBox(GUI_FONT_W*32, GUI_FONT_H*25)
	
	loadSprite_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	loadSprite_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_spriteList_ListBox, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(loadSprite_window, loadSprite_main_panel, 0, 0)
	
	c_dir$ = Dir$
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\sprite\\") Then
			MakeDir(c_dir$ + "\\sprite\\")
		End If
		ChangeDir(c_dir$ + "\\sprite\\")
	Else
		If Not DirExists(c_dir$ + "/sprite/") Then
			MakeDir(c_dir$ + "/sprite/")
		End If
		ChangeDir(c_dir$ + "/sprite/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "sprite" Then
			Gui_ListBox_AddItem(loadSprite_spriteList_ListBox, f_name$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(loadSprite_spriteList_ListBox)
	
	ChangeDir$(c_dir$)
	
	While True
		If Gui_Button_Clicked(loadSprite_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadSprite_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_ListBox_GetValue$( loadSprite_spriteList_ListBox, Gui_ListBox_GetSelectedItem( loadSprite_spriteList_ListBox ) ))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(loadSprite_window)
	'Wait(200)
End Function

Function Editor_SpriteIsAlreadyLoaded()
	If NumWindows > 1 Then
		Return 0
	End If
	
	s_window = Gui_WindowOpen("Load Sprite", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 500, 400)
	Window(s_window)
	
	p = Gui_CreatePanel(500, 400)
	
	Dim Msg$[2]
	Msg$[0] = "Sprite is Already Loaded."
	Msg$[1] = "Do you want to reload it?"
	
	For i = 0 to ArraySize(Msg$, 1)-1
		msg_label = Gui_CreateLabel(Msg$[i], Length(Msg$[i])*GUI_FONT_W+2, GUI_FONT_H+2)
		Gui_Panel_AddObject(p, msg_label, GUI_FONT_W*6, GUI_FONT_H*6 + (i*GUI_FONT_H) + (i*4))
	Next
	
	ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+2)
	cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+2)
	
	Gui_Panel_AddObject(p, cancel_button, GUI_FONT_W*6, 280)
	Gui_Panel_AddObject(p, ok_button, GUI_FONT_W*15+2, 280)
	
	Gui_Window_AddPanel(s_window, p, 0, 0)
	
	While True
		If Gui_Button_Clicked(cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "OK")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(s_window)
End Function

Function Editor_SpriteAlreadyExists()
	If NumWindows > 1 Then
		Return 0
	End If
	
	s_window = Gui_WindowOpen("New Sprite", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 500, 400)
	Window(s_window)
	
	p = Gui_CreatePanel(500, 400)
	
	Dim Msg$[3]
	Msg$[0] = "Sprite already exists."
	Msg$[1] = "Making a new sprite from this image will overwrite the original."
	Msg$[2] = "Do you want to overwrite this sprite?"
	
	For i = 0 to ArraySize(Msg$, 1)-1
		msg_label = Gui_CreateLabel(Msg$[i], Length(Msg$[i])*GUI_FONT_W+2, GUI_FONT_H+2)
		Gui_Panel_AddObject(p, msg_label, GUI_FONT_W*2, GUI_FONT_H*6 + (i*GUI_FONT_H) + (i*4))
	Next
	
	ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+2)
	cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+2)
	
	Gui_Panel_AddObject(p, cancel_button, GUI_FONT_W*6, 280)
	Gui_Panel_AddObject(p, ok_button, GUI_FONT_W*15+2, 280)
	
	Gui_Window_AddPanel(s_window, p, 0, 0)
	
	While True
		If Gui_Button_Clicked(cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "OK")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(s_window)
End Function


Function Editor_SpriteShouldBackUp()
	If NumWindows > 1 Then
		Return 0
	End If
	
	s_window = Gui_WindowOpen("New Sprite", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 500, 400)
	Window(s_window)
	
	p = Gui_CreatePanel(500, 400)
	
	Dim Msg$[2]
	Msg$[0] = "Sprite was not added to the Stage Database."
	Msg$[1] = "Do you want to save this sprite before Opening a new one?"
	
	For i = 0 to ArraySize(Msg$, 1)-1
		msg_label = Gui_CreateLabel(Msg$[i], Length(Msg$[i])*GUI_FONT_W+2, GUI_FONT_H+2)
		Gui_Panel_AddObject(p, msg_label, GUI_FONT_W*2, GUI_FONT_H*6 + (i*GUI_FONT_H) + (i*4))
	Next
	
	ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+2)
	cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+2)
	
	Gui_Panel_AddObject(p, cancel_button, GUI_FONT_W*6, 280)
	Gui_Panel_AddObject(p, ok_button, GUI_FONT_W*15+2, 280)
	
	Gui_Window_AddPanel(s_window, p, 0, 0)
	
	While True
		If Gui_Button_Clicked(cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "OK")
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(s_window)
End Function

Function Editor_LoadMultipleSprites_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	loadSprite_window = Gui_WindowOpen("Add Sprites to Stage", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 500, 500)
	Window(loadSprite_window)
	
	loadSprite_main_panel = Gui_CreatePanel(500, 500)
	
	loadSprite_spriteList_ListBox = Gui_CreateListBox(200, 400)
	loadSprite_spriteListToLoad_ListBox = Gui_CreateListBox(200, 400)
	
	
	loadSprite_add_button = Gui_CreateButton(">>>", GUI_FONT_W*4, GUI_FONT_H+2)
	loadSprite_remove_button = Gui_CreateButton("<<<", GUI_FONT_W*4, GUI_FONT_H+2)
	
	loadSprite_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	loadSprite_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_spriteList_ListBox, GUI_FONT_W*2, GUI_FONT_H*3)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_spriteListToLoad_ListBox, GUI_FONT_W*2 + 270, GUI_FONT_H*3)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_add_button, GUI_FONT_W*2 + 220, 180)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_remove_button, GUI_FONT_W*2 + 220, 180 + GUI_FONT_H+4)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_cancel_button, 250 - GUI_FONT_W*10, 470)
	Gui_Panel_AddObject(loadSprite_main_panel, loadSprite_ok_button, 250 + GUI_FONT_W, 470)
	
	Gui_Window_AddPanel(loadSprite_window, loadSprite_main_panel, 0, 0)
	
	c_dir$ = Dir$
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\sprite\\") Then
			MakeDir(c_dir$ + "\\sprite\\")
		End If
		ChangeDir(c_dir$ + "\\sprite\\")
	Else
		If Not DirExists(c_dir$ + "/sprite/") Then
			MakeDir(c_dir$ + "/sprite/")
		End If
		ChangeDir(c_dir$ + "/sprite/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "sprite" Then
			Gui_ListBox_AddItem(loadSprite_spriteList_ListBox, f_name$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(loadSprite_spriteList_ListBox)
	
	ChangeDir$(c_dir$)
	
	s_count = 0
	
	While True
		If Gui_Button_Clicked(loadSprite_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadSprite_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			If s_count > 0 Then
				For i = 0 to s_count-1
					s_value$ = Gui_ListBox_GetValue$(loadSprite_spriteListToLoad_ListBox, i)
					WriteLine(f, s_value$)
				Next
			End If
			WriteLine(f, "")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadSprite_add_button) Then
			selected = Gui_ListBox_GetSelectedItem(loadSprite_spriteList_ListBox)
			s_value$ = Gui_ListBox_GetValue$(loadSprite_spriteList_ListBox, selected)
			s_exists = False
			If s_count > 0 Then
				For i = 0 to s_count-1
					If Gui_ListBox_GetValue$(loadSprite_spriteListToLoad_ListBox, i) = s_value$ Then
						s_exists = True
						Exit For
					End If
				Next
			End If
			If Not s_exists Then
				Gui_ListBox_AddItem(loadSprite_spriteListToLoad_ListBox, s_value$)
				Gui_ListBox_Update(loadSprite_spriteListToLoad_ListBox)
				s_count = s_count + 1
			End If
		ElseIf Gui_Button_Clicked(loadSprite_remove_button) Then
			selected = Gui_ListBox_GetSelectedItem(loadSprite_spriteListToLoad_ListBox)
			If s_count > 0 Then
				Gui_ListBox_RemoveItem(loadSprite_spriteListToLoad_ListBox, selected)
				Gui_ListBox_Update(loadSprite_spriteListToLoad_ListBox)
				s_count = s_count - 1
			End If
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(loadSprite_window)
	'Wait(200)
End Function

'Editor_LoadMultipleSprites_Window
