'Include "gui.bas"
'Include "strings.bas"

Function Editor_Bkg_LoadImage_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	loadBkg_window = Gui_WindowOpen("Load Image", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(loadBkg_window)
	
	loadBkg_main_panel = Gui_CreatePanel(300, 400)
	
	loadBkg_imageList_ListBox = Gui_CreateListBox(GUI_FONT_W*32, GUI_FONT_H*25)
	
	loadBkg_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	loadBkg_load_button = Gui_CreateButton("Load", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(loadBkg_main_panel, loadBkg_imageList_ListBox, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(loadBkg_main_panel, loadBkg_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(loadBkg_main_panel, loadBkg_load_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(loadBkg_window, loadBkg_main_panel, 0, 0)
	
	c_dir$ = Dir$
	
	If OS$ = "WINDOWS" Then
		If Not DirExists(c_dir$ + "\\bkg\\") Then
			MakeDir(c_dir$ + "\\bkg\\")
		End If
		ChangeDir(c_dir$ + "\\bkg\\")
	Else
		If Not DirExists(c_dir$ + "/bkg/") Then
			MakeDir(c_dir$ + "/bkg/")
		End If
		ChangeDir(c_dir$ + "/bkg/")
	End If
	
	f_dir$ = DirFirst$
	'he.me
	While f_dir$ <> ""
		ext_start = FindLastOf(".",f_dir$)+1
		ext$ = Mid$(f_dir$, ext_start, Length(f_dir$) - ext_start)
		f_name$ = Mid$(f_dir$, 0, ext_start-1)
		If ext$ = "png" Or ext$ = "bmp" Then
			Gui_ListBox_AddItem(loadBkg_imageList_ListBox, f_name$ + "." + ext$)
		End If
		f_dir$ = DirNext$
	Wend
	
	Gui_ListBox_Update(loadBkg_imageList_ListBox)
	
	ChangeDir$(c_dir$)
	
	While True
		If Gui_Button_Clicked(loadBkg_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(loadBkg_load_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_ListBox_GetValue$( loadBkg_imageList_ListBox, Gui_ListBox_GetSelectedItem( loadBkg_imageList_ListBox ) ))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(loadBkg_window)
	'Wait(200)
End Function

Function Editor_Bkg_SetColor_Window(r, g, b)
	If NumWindows > 1 Then
		Return 0
	End If
	
	setColor_window = Gui_WindowOpen("Set Color", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(setColor_window)
	
	setColor_main_panel = Gui_CreatePanel(300, 400)
	
	setColor_preview_surface = Gui_CreateSurface(200, 200)
	
	setColor_R_label = Gui_CreateLabel("R", GUI_FONT_W*2, GUI_FONT_H+1)
	setColor_R_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	setColor_G_label = Gui_CreateLabel("G", GUI_FONT_W*2, GUI_FONT_H+1)
	setColor_G_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	setColor_B_label = Gui_CreateLabel("B", GUI_FONT_W*2, GUI_FONT_H+1)
	setColor_B_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	setColor_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	setColor_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(setColor_main_panel, setColor_preview_surface, 50, 30)
	
	Gui_Panel_AddObject(setColor_main_panel, setColor_R_label, 50, 250)
	Gui_Panel_AddObject(setColor_main_panel, setColor_R_field, 50 + GUI_FONT_W*2, 250)
	
	Gui_Panel_AddObject(setColor_main_panel, setColor_G_label, 50, 250 + GUI_FONT_H+4)
	Gui_Panel_AddObject(setColor_main_panel, setColor_G_field, 50 + GUI_FONT_W*2, 250 + GUI_FONT_H+4)
	
	Gui_Panel_AddObject(setColor_main_panel, setColor_B_label, 50, 250 + GUI_FONT_H*2+8)
	Gui_Panel_AddObject(setColor_main_panel, setColor_B_field, 50 + GUI_FONT_W*2, 250 + GUI_FONT_H*2+8)
	
	Gui_Panel_AddObject(setColor_main_panel, setColor_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(setColor_main_panel, setColor_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_Window_AddPanel(setColor_window, setColor_main_panel, 0, 0)
	
	Gui_TextField_SetValue(setColor_R_field, Str$(r))
	Gui_TextField_SetValue(setColor_G_field, Str$(g))
	Gui_TextField_SetValue(setColor_B_field, Str$(b))
	
	
	While True
		If Gui_Button_Clicked(setColor_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(setColor_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Str$(r))
			WriteLine(f, Str$(g))
			WriteLine(f, Str$(b))
			FileClose(f)
			Exit While
		ElseIf Gui_TextField_Return(setColor_R_field) Or Gui_TextField_Return(setColor_G_field) Or Gui_TextField_Return(setColor_B_field) Then
			r_value$ = Gui_TextField_GetValue$(setColor_R_field)
			g_value$ = Gui_TextField_GetValue$(setColor_G_field)
			b_value$ = Gui_TextField_GetValue$(setColor_B_field)
			
			If r_value$ <> "" Then
				r = Int(Val(r_value$))
			Else
				r = 0
			End If
			
			If g_value$ <> "" Then
				g = Int(Val(g_value$))
			Else
				g = 0
			End If
			
			If b_value$ <> "" Then
				b = Int(Val(b_value$))
			Else
				b = 0
			End If
			
			Gui_Surface_SetClearColor(setColor_preview_surface, RGB(r,g,b))
			Gui_Surface_Clear(setColor_preview_surface)
			Gui_Surface_Update(setColor_preview_surface)
			'Gui_Surface_RectFill(setColor_preview_surface, 0, 0, 200, 200)
			
			Gui_TextField_SetValue(setColor_R_field, Str$(r))
			Gui_TextField_SetValue(setColor_G_field, Str$(g))
			Gui_TextField_SetValue(setColor_B_field, Str$(b))
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(setColor_window)
End Function

Function Editor_Bkg_Properties_Window(b_type, b_flag, b_alpha, b_zx, b_zy, b_angle, b_bx, b_by, b_bw, b_bh, h_speed, v_speed)
	If NumWindows > 1 Then
		Return 0
	End If
	
	bkg_properties_window = Gui_WindowOpen("Background Properties", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(bkg_properties_window)
	
	bkg_properties_main_panel = Gui_CreatePanel(300, 400)
	
	bkg_properties_type_label = Gui_CreateLabel("Type", GUI_FONT_W*5, GUI_FONT_H+1)
	bkg_properties_type_selection = Gui_CreateDropDown(GUI_FONT_W*16, GUI_FONT_H+4)
	
	Gui_DropDown_AddItem(bkg_properties_type_selection, "Image")
	Gui_DropDown_AddItem(bkg_properties_type_selection, "Surface")
	
	bkg_properties_flag_label = Gui_CreateLabel("Flag", GUI_FONT_W*5, GUI_FONT_H+1)
	bkg_properties_flag_selection = Gui_CreateDropDown(GUI_FONT_W*16, GUI_FONT_H+4)
	
	Gui_DropDown_AddItem(bkg_properties_flag_selection, "None")
	Gui_DropDown_AddItem(bkg_properties_flag_selection, "Tile")
	Gui_DropDown_AddItem(bkg_properties_flag_selection, "Stretch")
	Gui_DropDown_AddItem(bkg_properties_flag_selection, "Blit")
	Gui_DropDown_AddItem(bkg_properties_flag_selection, "Scroll")
	
	bkg_properties_alpha_label = Gui_CreateLabel("Alpha", GUI_FONT_W*6, GUI_FONT_H+1)
	bkg_properties_alpha_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_hspeed_label = Gui_CreateLabel("H Speed", GUI_FONT_W*8, GUI_FONT_H+1)
	bkg_properties_hspeed_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_vspeed_label = Gui_CreateLabel("V Speed", GUI_FONT_W*8, GUI_FONT_H+1)
	bkg_properties_vspeed_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_zoomX_label = Gui_CreateLabel("Zoom X", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_zoomX_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_zoomY_label = Gui_CreateLabel("Zoom Y", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_zoomY_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_angle_label = Gui_CreateLabel("Angle", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_angle_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_blitX_label = Gui_CreateLabel("Blit X", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_blitX_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_blitY_label = Gui_CreateLabel("Blit Y", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_blitY_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_blitW_label = Gui_CreateLabel("Blit W", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_blitW_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_blitH_label = Gui_CreateLabel("Blit H", GUI_FONT_W*7, GUI_FONT_H+1)
	bkg_properties_blitH_field = Gui_CreateTextField(GUI_FONT_W*8, GUI_FONT_H+1)
	
	bkg_properties_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	bkg_properties_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_type_label, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_type_selection, GUI_FONT_W*5, GUI_FONT_H)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_flag_label, GUI_FONT_W, GUI_FONT_H*3)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_flag_selection, GUI_FONT_W*5, GUI_FONT_H*3)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_hspeed_label, GUI_FONT_W, GUI_FONT_H*6)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_hspeed_field, GUI_FONT_W*8, GUI_FONT_H*6)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_vspeed_label, GUI_FONT_W, GUI_FONT_H*7+4)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_vspeed_field, GUI_FONT_W*8, GUI_FONT_H*7+4)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_alpha_label, GUI_FONT_W, GUI_FONT_H*10)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_alpha_field, GUI_FONT_W*8, GUI_FONT_H*10)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_zoomX_label, GUI_FONT_W, GUI_FONT_H*13)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_zoomX_field, GUI_FONT_W*8, GUI_FONT_H*13)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_zoomY_label, GUI_FONT_W, GUI_FONT_H*14+4)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_zoomY_field, GUI_FONT_W*8, GUI_FONT_H*14+4)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_angle_label, GUI_FONT_W, GUI_FONT_H*17)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_angle_field, GUI_FONT_W*8, GUI_FONT_H*17)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitX_label, GUI_FONT_W, GUI_FONT_H*20)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitX_field, GUI_FONT_W*8, GUI_FONT_H*20)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitY_label, GUI_FONT_W, GUI_FONT_H*21+4)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitY_field, GUI_FONT_W*8, GUI_FONT_H*21+4)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitW_label, GUI_FONT_W, GUI_FONT_H*22+8)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitW_field, GUI_FONT_W*8, GUI_FONT_H*22+8)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitH_label, GUI_FONT_W, GUI_FONT_H*23+12)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_blitH_field, GUI_FONT_W*8, GUI_FONT_H*23+12)
	
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_cancel_button, GUI_FONT_W*6, GUI_FONT_H*29)
	Gui_Panel_AddObject(bkg_properties_main_panel, bkg_properties_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*29)
	
	Gui_Window_AddPanel(bkg_properties_window, bkg_properties_main_panel, 0, 0)
	
	'Set Current Values
	Gui_DropDown_SetSelectedItem(bkg_properties_type_selection, b_type)
	Gui_DropDown_SetSelectedItem(bkg_properties_flag_selection, b_flag)
	Gui_TextField_SetValue(bkg_properties_hspeed_field, Str$(h_speed))
	Gui_TextField_SetValue(bkg_properties_vspeed_field, Str$(v_speed))
	Gui_TextField_SetValue(bkg_properties_alpha_field, Str$(b_alpha))
	Gui_TextField_SetValue(bkg_properties_zoomX_field, Str$(b_zx))
	Gui_TextField_SetValue(bkg_properties_zoomY_field, Str$(b_zy))
	Gui_TextField_SetValue(bkg_properties_angle_field, Str$(b_angle))
	Gui_TextField_SetValue(bkg_properties_blitX_field, Str$(b_bx))
	Gui_TextField_SetValue(bkg_properties_blitY_field, Str$(b_by))
	Gui_TextField_SetValue(bkg_properties_blitW_field, Str$(b_bw))
	Gui_TextField_SetValue(bkg_properties_blitH_field, Str$(b_bh))
	
	While True
		If Gui_Button_Clicked(bkg_properties_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(bkg_properties_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Str$(Gui_DropDown_GetSelectedItem(bkg_properties_type_selection)))
			WriteLine(f, Str$(Gui_DropDown_GetSelectedItem(bkg_properties_flag_selection)))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_alpha_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_zoomX_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_zoomY_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_angle_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_blitX_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_blitY_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_blitW_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_blitH_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_hspeed_field))
			WriteLine(f, Gui_TextField_GetValue$(bkg_properties_vspeed_field))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(bkg_properties_window)
End Function

'Editor_Bkg_Properties_Window(0, 1, 255, 1.25, 1.15, 270, 0, 3, 640, 480, 5, 6)

