'Include "gui.bas"
'Include "strings.bas"

Function Editor_AddShape_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	addShape_window = Gui_WindowOpen("Add Shape", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 300, 400)
	Window(addShape_window)
	
	addShape_main_panel = Gui_CreatePanel(300, 400)
	
	addShape_type_label = Gui_CreateLabel("Type", GUI_FONT_W*7, GUI_FONT_H+1)
	addShape_type_selection = Gui_CreateDropDown(GUI_FONT_W*16, GUI_FONT_H+1)
	
	addShape_posX_label = Gui_CreateLabel("Pos X", GUI_FONT_W*7, GUI_FONT_H+1)
	addShape_posX_field = Gui_CreateTextField(GUI_FONT_W*11, GUI_FONT_H+1)
	
	addShape_posY_label = Gui_CreateLabel("Pos X", GUI_FONT_W*7, GUI_FONT_H+1)
	addShape_posY_field = Gui_CreateTextField(GUI_FONT_W*11, GUI_FONT_H+1)
	
	addShape_par1_label = Gui_CreateLabel("Param 1", GUI_FONT_W*7, GUI_FONT_H+1)
	addShape_par1_field = Gui_CreateTextField(GUI_FONT_W*11, GUI_FONT_H+1)
	
	addShape_par2_label = Gui_CreateLabel("Param 2", GUI_FONT_W*7, GUI_FONT_H+1)
	addShape_par2_field = Gui_CreateTextField(GUI_FONT_W*11, GUI_FONT_H+1)
	
	addShape_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	addShape_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_type_label, GUI_FONT_W, GUI_FONT_H)
	Gui_Panel_AddObject(addShape_main_panel, addShape_type_selection, GUI_FONT_W*8, GUI_FONT_H)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_posX_label, GUI_FONT_W, GUI_FONT_H*3)
	Gui_Panel_AddObject(addShape_main_panel, addShape_posX_field, GUI_FONT_W*8, GUI_FONT_H*3)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_posY_label, GUI_FONT_W, GUI_FONT_H*4+4)
	Gui_Panel_AddObject(addShape_main_panel, addShape_posY_field, GUI_FONT_W*8, GUI_FONT_H*4+4)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_par1_label, GUI_FONT_W, GUI_FONT_H*5+8)
	Gui_Panel_AddObject(addShape_main_panel, addShape_par1_field, GUI_FONT_W*8, GUI_FONT_H*5+8)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_par2_label, GUI_FONT_W, GUI_FONT_H*6+12)
	Gui_Panel_AddObject(addShape_main_panel, addShape_par2_field, GUI_FONT_W*8, GUI_FONT_H*6+12)
	
	Gui_Panel_AddObject(addShape_main_panel, addShape_cancel_button, GUI_FONT_W*6, GUI_FONT_H*27)
	Gui_Panel_AddObject(addShape_main_panel, addShape_ok_button, GUI_FONT_W*15+2, GUI_FONT_H*27)
	
	Gui_DropDown_AddItem(addShape_type_selection, "Rectangle")
	Gui_DropDown_AddItem(addShape_type_selection, "Line")
	
	Dim DropDown_Value$[2]
	DropDown_Value$[0] = "RECT"
	DropDown_Value$[1] = "LINE"
	
	Gui_Window_AddPanel(addShape_window, addShape_main_panel, 0, 0)
	
	While True
		If Gui_Button_Clicked(addShape_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL\n")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(addShape_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, DropDown_Value$[Gui_DropDown_GetSelectedItem(addShape_type_selection)])
			WriteLine(f, Gui_TextField_GetValue$(addShape_posX_field))
			WriteLine(f, Gui_TextField_GetValue$(addShape_posY_field))
			WriteLine(f, Gui_TextField_GetValue$(addShape_par1_field))
			WriteLine(f, Gui_TextField_GetValue$(addShape_par2_field))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(addShape_window)
End Function

'Editor_AddShape_Window
