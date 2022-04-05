'Include "gui.bas"
'Include "engine.bas"
'Include "dlg.bas"

Function Editor_NewActor_Window()
	If NumWindows > 1 Then
		Return 0
	End If
	
	newActor_window = Gui_WindowOpen("New Actor", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 600, 400)
	Window(newActor_window)
	
	newActor_main_panel = Gui_CreatePanel(600, 400)
	
	newActor_spriteList_label = Gui_CreateLabel("Sprites", GUI_FONT_W*8, GUI_FONT_H+1)
	newActor_spriteList_listBox = Gui_CreateListBox(200, 160)
	newActor_animationList_label = Gui_CreateLabel("Animations", GUI_FONT_W*11, GUI_FONT_H+1)
	newActor_animationList_listBox = Gui_CreateListBox(200, 160)
	
	newActor_actorName_label = Gui_CreateLabel("Actor Name", GUI_FONT_W*11, GUI_FONT_H+1)
	newActor_actorName_field = Gui_CreateTextField(200, GUI_FONT_H+1)
	
	newActor_spriteName_label = Gui_CreateLabel("Sprite Name", GUI_FONT_W*12, GUI_FONT_H+1)
	newActor_spriteName_field = Gui_CreateTextField(200, GUI_FONT_H+1)
	newActor_spriteAnim_label = Gui_CreateLabel("Animation", GUI_FONT_W*12, GUI_FONT_H+1)
	newActor_spriteAnim_field = Gui_CreateTextField(200, GUI_FONT_H+1)
	
	newActor_cancel_button = Gui_CreateButton("Cancel", GUI_FONT_W*8, GUI_FONT_H+4)
	newActor_ok_button = Gui_CreateButton("OK", GUI_FONT_W*8, GUI_FONT_H+4)
	
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteList_label, 20, 20 - GUI_FONT_H - 2)
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteList_listBox, 20, 20)
	Gui_Panel_AddObject(newActor_main_panel, newActor_animationList_label, 20, 200 - GUI_FONT_H - 2)
	Gui_Panel_AddObject(newActor_main_panel, newActor_animationList_listBox, 20, 200)
	Gui_Panel_AddObject(newActor_main_panel, newActor_actorName_label, 260, 20)
	Gui_Panel_AddObject(newActor_main_panel, newActor_actorName_field, 260 + GUI_FONT_W*11, 20)
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteName_label, 260, 100)
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteName_field, 260 + GUI_FONT_W*11, 100)
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteAnim_label, 260, 100 + GUI_FONT_H+8)
	Gui_Panel_AddObject(newActor_main_panel, newActor_spriteAnim_field, 260 + GUI_FONT_W*11, 100 + GUI_FONT_H+8)
	Gui_Panel_AddObject(newActor_main_panel, newActor_cancel_button, 300 - GUI_FONT_W*8, 400 - GUI_FONT_H*2)
	Gui_Panel_AddObject(newActor_main_panel, newActor_ok_button, 300 + GUI_FONT_W, 400 - GUI_FONT_H*2)
	
	Gui_Window_AddPanel(newActor_window, newActor_main_panel, 0, 0)
	
	Gui_TextField_SetValue(newActor_actorName_field, "NewActor")
	
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	spr_num = Val(Dlg_data$[0])
	
	Dim spr_name$[spr_num]
	Dim spr_anim$[spr_num, MAX_SPRITE_ANIMATIONS]
	Dim spr_anim_count[spr_num]
	
	i = 1
	If spr_num > 0 Then
		Gui_TextField_SetValue(newActor_spriteName_field, Dlg_data$[i])
		For spr = 0 to spr_num-1
			spr_name$[spr] = Dlg_data$[i]
			Gui_ListBox_AddItem(newActor_spriteList_listBox, spr_name$[spr])
			num_anim = Val(Dlg_data$[i+1])
			spr_anim_count[spr] = num_anim
			i = i + 2
			If (num_anim > 0) Then
				If spr = 0 Then
					Gui_TextField_SetValue(newActor_spriteAnim_field, Dlg_data$[i])
				End If
				For anim = 0 to num_anim-1
					spr_anim$[spr, anim] = Dlg_data$[i]
					i = i + 1
					If spr = 0 Then
						Gui_ListBox_AddItem(newActor_animationList_listBox, spr_anim$[spr, anim])
					End If
				Next
			End If
		Next
	End If
	
	Gui_ListBox_SetSelectedItem(newActor_spriteList_listBox, 0)
	Gui_ListBox_Update(newActor_spriteList_listBox)
	
	Gui_ListBox_SetSelectedItem(newActor_animationList_listBox, 0)
	Gui_ListBox_Update(newActor_animationList_listBox)
	
	current_sprite = 0
	current_anim = 0
	selected_sprite = 0
	selected_anim = 0
	
	While True
		selected_sprite = Gui_ListBox_GetSelectedItem(newActor_spriteList_listBox)
		selected_anim = Gui_ListBox_GetSelectedItem(newActor_animationList_listBox)
		
		If current_sprite <> selected_sprite And (current_sprite >= 0 And current_sprite < spr_num) Then
			current_sprite = selected_sprite
			Gui_TextField_SetValue(newActor_spriteName_field, spr_name$[current_sprite])
			Gui_ListBox_Clear(newActor_animationList_listBox)
			If spr_anim_count[current_sprite] > 0 Then
				Gui_TextField_SetValue(newActor_spriteAnim_field, spr_anim$[current_sprite, 0])
				For anim = 0 to spr_anim_count[current_sprite]-1
					Gui_ListBox_AddItem(newActor_animationList_listBox, spr_anim$[current_sprite, anim])
				Next
			Else
				Gui_TextField_SetValue(newActor_spriteAnim_field, " ")
			End If
			Gui_ListBox_SetSelectedItem(newActor_animationList_listBox, 0)
			Gui_ListBox_Update(newActor_animationList_listBox)
		ElseIf current_anim <> selected_anim Then
			current_anim = selected_anim
			If spr_anim$[current_sprite, current_anim] <> "" Then
				Gui_TextField_SetValue(newActor_spriteAnim_field, spr_anim$[current_sprite, current_anim])
			Else
				Gui_TextField_SetValue(newActor_spriteAnim_field, spr_anim$[current_sprite, current_anim])
			End If
		End If
		
		If Gui_Button_Clicked(newActor_cancel_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, "#NULL")
			FileClose(f)
			Exit While
		ElseIf Gui_Button_Clicked(newActor_ok_button) Then
			f = FreeFile
			FileOpen(f, "dlg_data.nb", TEXT_OUTPUT_PLUS)
			WriteLine(f, Gui_TextField_GetValue$(newActor_actorName_field))
			WriteLine(f, Gui_TextField_GetValue$(newActor_spriteName_field))
			WriteLine(f, Gui_TextField_GetValue$(newActor_spriteAnim_field))
			FileClose(f)
			Exit While
		End If
		Gui_Update
	Wend
	
	Gui_WindowClose(newActor_window)
End Function

'Editor_NewActor_Window
