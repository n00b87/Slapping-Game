Dim spriteAnimation_preview_CurrentFrame
Dim spriteMain_scroll_speed
spriteMain_scroll_speed = 4

Dim spriteAnimation_preview_CurrentTime
Dim spriteAnimation_preview_isPlaying

Dim spriteAnimation_selectedFrame

Dim spriteBound_CurrentPoint

Sub Editor_Preview_PlaySprite(flag)
	If flag Then
		Gui_ImageClip_SetSourceSize(spriteAnimation_previewClip, Sprite_Frame_Width[SpriteMain_Current_Sprite], Sprite_Frame_Height[SpriteMain_Current_Sprite])
		Gui_ImageClip_SetSource(spriteAnimation_previewClip, Sprite_Image[SpriteMain_Current_Sprite])
		spriteAnimation_preview_CurrentTime = timer
		spriteAnimation_preview_isPlaying = True
	End If
	If Not spriteAnimation_preview_isPlaying Or Not Sprite_inUse[SpriteMain_Current_Sprite] Then
		Return
	End If
	t = timer
	anim = SpriteMain_SpriteAnimation_Current_Animation
	If t - spriteAnimation_preview_CurrentTime > Sprite_Animation_Delay[SpriteMain_Current_Sprite] Then
		spriteAnimation_preview_CurrentFrame = spriteAnimation_preview_CurrentFrame + 1
		If spriteAnimation_preview_CurrentFrame >= Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] Then
			spriteAnimation_preview_CurrentFrame = 0
		End If
		spriteAnimation_preview_CurrentTime = t
	End If
	current_frame = spriteAnimation_preview_CurrentFrame
	anim = SpriteMain_SpriteAnimation_Current_Animation
	src_x = Int(Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, current_frame] Mod Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Width[SpriteMain_Current_Sprite]
	src_y = Int(Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, current_frame] / Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Height[SpriteMain_Current_Sprite]
	Gui_ImageClip_SetOffset(spriteAnimation_previewClip, src_x, src_y)
End Sub

Sub Editor_Preview_StopSprite()
	spriteAnimation_preview_isPlaying = False
End Sub

Function Editor_spriteAnimation_ImageSlide_Update()
	'Image Slide
	Gui_ImageSlide_Clear(spriteAnimation_frameSlide)
	If Sprite_inUse[SpriteMain_Current_Sprite] And Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, SpriteMain_SpriteAnimation_Current_Animation] > 0 Then
		anim = SpriteMain_SpriteAnimation_Current_Animation
		If Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] > 0 Then
			For i = 0 to Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim]-1
				Gui_ImageClip_SetSourceSize(spriteAnimation_frameSlide_frame[i], Sprite_Frame_Width[SpriteMain_Current_Sprite], Sprite_Frame_Height[SpriteMain_Current_Sprite])
				off_x = Int(Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, i] Mod Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Width[SpriteMain_Current_Sprite]
				off_y = Int(Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, i] / Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Height[SpriteMain_Current_Sprite]
				Gui_ImageClip_SetOffset(spriteAnimation_frameSlide_frame[i], off_x, off_y)
				Gui_ImageSlide_AddImageClip(spriteAnimation_frameSlide, spriteAnimation_frameSlide_frame[i])
			Next
		End If
	End If
End Function

Sub Editor_spriteAnimation_setSelectedAnimation(anim)
	If Not Sprite_inUse[SpriteMain_Current_Sprite] Or anim < 0 Or anim >= Sprite_NumAnimations[SpriteMain_Current_Sprite] Then
		Return
	End If
	SpriteMain_SpriteAnimation_Current_Animation = anim
	Gui_TextField_SetValue(spriteAnimation_nameField, Sprite_Animation_Name$[SpriteMain_Current_Sprite, anim])
	Gui_TextField_SetValue(spriteAnimation_FPSField, Str$(Sprite_Animation_FPS[SpriteMain_Current_Sprite, anim]))
	spriteAnimation_preview_isPlaying = False
	Editor_spriteAnimation_ImageSlide_Update
End Sub

Sub Editor_spriteAnimation_Update()
	Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
	src_w = 0
	src_h = 0
	
	If Sprite_inUse[SpriteMain_Current_Sprite] Then
		src_w = Sprite_Image_W[SpriteMain_Current_Sprite]
		src_h = Sprite_Image_H[SpriteMain_Current_Sprite]
		If spriteAnimation_spriteSheetSurface_w < src_w Then
			src_w = spriteAnimation_spriteSheetSurface_w
		End If
		If spriteAnimation_spriteSheetSurface_h < src_h Then
			src_h = spriteAnimation_spriteSheetSurface_h
		End If
		If Gui_Surface_MouseOver(spriteAnimation_spriteSheetSurface) Then
			If Key(K_RIGHT) And ( (spriteAnimation_spriteSheetSurface_offset_x+spriteMain_scroll_speed+src_w) < Sprite_Image_W[SpriteMain_Current_Sprite] ) Then
				spriteAnimation_spriteSheetSurface_offset_x = spriteAnimation_spriteSheetSurface_offset_x + spriteMain_scroll_speed
			End If
			If Key(K_LEFT) And ( (spriteAnimation_spriteSheetSurface_offset_x-spriteMain_scroll_speed) >= 0) Then
				spriteAnimation_spriteSheetSurface_offset_x = spriteAnimation_spriteSheetSurface_offset_x - spriteMain_scroll_speed
			End If
			If Key(K_DOWN) And ( (spriteAnimation_spriteSheetSurface_offset_y+spriteMain_scroll_speed+src_h) < Sprite_Image_H[SpriteMain_Current_Sprite] ) Then
				spriteAnimation_spriteSheetSurface_offset_y = spriteAnimation_spriteSheetSurface_offset_y + spriteMain_scroll_speed
			End If
			If Key(K_UP) And ( (spriteAnimation_spriteSheetSurface_offset_y-spriteMain_scroll_speed) >= 0 ) Then
				spriteAnimation_spriteSheetSurface_offset_y = spriteAnimation_spriteSheetSurface_offset_y - spriteMain_scroll_speed
			End If
		End If
		
		'Add, Remove, and Set Buttons
		anim = SpriteMain_SpriteAnimation_Current_Animation
		If anim < Sprite_NumAnimations[SpriteMain_Current_Sprite] Then
			selected_clip = Gui_ImageSlide_GetSelectedClip(spriteAnimation_frameSlide)
			If Gui_Button_Clicked(spriteAnimation_addFrameButton) And Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim]+1 <= MAX_SPRITE_ANIMATION_FRAMES Then
				Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] = Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] + 1
				Editor_spriteAnimation_ImageSlide_Update
				'Print "Sprite Num Frames = ";Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim]
			ElseIf Gui_Button_Clicked(spriteAnimation_removeFrameButton) And Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] > 0 Then
				Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] = Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] - 1
				Editor_spriteAnimation_ImageSlide_Update
			ElseIf Gui_Button_Clicked(spriteAnimation_setFrameButton) And selected_clip >= 0 And selected_clip < Sprite_Animation_NumFrames[SpriteMain_Current_Sprite, anim] Then
				
				Dim mx
				Dim my
				
				Locate(40, 90)
				SetColor(RGB(255,0,0))
				PrintS("SELECT A FRAME")
				
				off_x = spriteAnimation_spriteSheetSurface_offset_x
				off_y = spriteAnimation_spriteSheetSurface_offset_y
				
				
				While Not Gui_Surface_Clicked(spriteAnimation_spriteSheetSurface)
					Gui_Surface_GetMouse(spriteAnimation_spriteSheetSurface, mx, my)
					
					Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
					off_x = spriteAnimation_spriteSheetSurface_offset_x
					off_y = spriteAnimation_spriteSheetSurface_offset_y
					Gui_Surface_DrawImage_Blit(spriteAnimation_spriteSheetSurface, Sprite_Image[SpriteMain_Current_Sprite], 0, 0, off_x, off_y, src_w, src_h)
					Gui_Surface_SetColor(spriteAnimation_spriteSheetSurface, tileSelect_selectedTile_color)
					
					frame_x = Int(mx / Sprite_Frame_Width[SpriteMain_Current_Sprite]) * Sprite_Frame_Width[SpriteMain_Current_Sprite] - (off_x Mod Sprite_Frame_Width[SpriteMain_Current_Sprite])
					frame_y = Int(my / Sprite_Frame_Height[SpriteMain_Current_Sprite]) * Sprite_Frame_Height[SpriteMain_Current_Sprite] - (off_y Mod Sprite_Frame_Height[SpriteMain_Current_Sprite])
					
					Gui_Surface_Rect(spriteAnimation_spriteSheetSurface, frame_x, frame_y, Sprite_Frame_Width[SpriteMain_Current_Sprite], Sprite_Frame_Height[SpriteMain_Current_Sprite])
					
					Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
					
					Gui_Update
				Wend
				
				Cls
				
				off_x = spriteAnimation_spriteSheetSurface_offset_x
				off_y = spriteAnimation_spriteSheetSurface_offset_y
				
				index = Int( (off_y + my) / Sprite_Frame_Height[SpriteMain_Current_Sprite] ) * Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite] + Int( (off_x + mx) / Sprite_Frame_Width[SpriteMain_Current_Sprite])
				anim = SpriteMain_SpriteAnimation_Current_Animation
				
				If index < Sprite_NumFrames[SpriteMain_Current_Sprite] Then
					Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, selected_clip] = index
				Else
					Sprite_Animation_Frame[SpriteMain_Current_Sprite, anim, selected_clip] = spriteAnimation_selectedFrame
				End If
				Editor_spriteAnimation_ImageSlide_Update
			End If
			
			'TextFields and Buttons
			If Gui_TextField_Return(spriteAnimation_FPSField) Then
				If Gui_TextField_GetValue$(spriteAnimation_FPSField) = "" Then
					Gui_TextField_SetValue(tileMain_tileFPSField, "0")
				End If
				anim = SpriteMain_SpriteAnimation_Current_Animation
				Sprite_Animation_FPS[SpriteMain_Current_Sprite, anim] = Val(Gui_TextField_GetValue$(spriteAnimation_FPSField))
				Sprite_Animation_Delay[SpriteMain_Current_Sprite] = 1000 / Sprite_Animation_FPS[SpriteMain_Current_Sprite, anim]
			ElseIf Gui_TextField_Return(spriteAnimation_nameField) Then
				If Gui_TextField_GetValue$(spriteAnimation_nameField) = "" Then
					Gui_TextField_SetValue(spriteAnimation_nameField, Sprite_Animation_Name$[SpriteMain_Current_Sprite, SpriteMain_SpriteAnimation_Current_Animation])
				End If
				Sprite_Animation_Name$[SpriteMain_Current_Sprite, SpriteMain_SpriteAnimation_Current_Animation] = Gui_TextField_GetValue$(spriteAnimation_nameField)
				Gui_ListBox_SetValue(spriteAnimation_animationListBox, SpriteMain_SpriteAnimation_Current_Animation, Sprite_Animation_Name$[SpriteMain_Current_Sprite, SpriteMain_SpriteAnimation_Current_Animation])
				Gui_ListBox_Update(spriteAnimation_animationListBox)
			ElseIf Gui_Button_Clicked(spriteAnimation_previewPlayButton) Then
				'start playing animation
				Editor_Preview_PlaySprite(True)
			ElseIf Gui_Button_Clicked(spriteAnimation_previewStopButton) Then
				'stop playing animation
				Editor_Preview_StopSprite
			End If
		End If
		
		If Gui_Button_Clicked(spriteAnimation_newAnimationButton) Then
			a = Sprite_CreateAnimation(SpriteMain_Current_Sprite, "Animimation" + Str$(Sprite_NumAnimations[SpriteMain_Current_Sprite]))
			Gui_ListBox_AddItem(spriteAnimation_animationListBox, Sprite_Animation_Name$[SpriteMain_Current_Sprite, a])
			Gui_ListBox_SetSelectedItem(spriteAnimation_animationListBox, a)
			Gui_ListBox_Update(spriteAnimation_animationListBox)
			Gui_TextField_SetValue(spriteAnimation_nameField, Sprite_Animation_Name$[SpriteMain_Current_Sprite, a])
			Gui_TextField_SetValue(spriteAnimation_FPSField, Str$(Sprite_Animation_FPS[SpriteMain_Current_Sprite, a]))
		ElseIf Gui_Button_Clicked(spriteAnimation_removeAnimationButton) Then
			Sprite_RemoveAnimation(SpriteMain_Current_Sprite, SpriteMain_SpriteAnimation_Current_Animation)
			Gui_ListBox_RemoveItem(spriteAnimation_animationListBox, SpriteMain_SpriteAnimation_Current_Animation)
			If SpriteMain_SpriteAnimation_Current_Animation >= Sprite_NumAnimations[SpriteMain_Current_Sprite] Then
				SpriteMain_SpriteAnimation_Current_Animation = SpriteMain_SpriteAnimation_Current_Animation - 1
			End If
			Gui_ListBox_SetSelectedItem(spriteAnimation_animationListBox, SpriteMain_SpriteAnimation_Current_Animation)
			Gui_ListBox_Update(spriteAnimation_animationListBox)
			Editor_spriteAnimation_setSelectedAnimation(SpriteMain_SpriteAnimation_Current_Animation)
		End If
		
		off_x = spriteAnimation_spriteSheetSurface_offset_x
		off_y = spriteAnimation_spriteSheetSurface_offset_y
		'print "src = ";src_w;", ";src_h
		'Print "tileset: ";tileMain_tileSheet_offset_x;", ";tileMain_tileSheet_offset_y;", ";src_w;", ";src_h
		Gui_Surface_DrawImage_Blit(spriteAnimation_spriteSheetSurface, Sprite_Image[SpriteMain_Current_Sprite], 0, 0, off_x, off_y, src_w, src_h)
		Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
		Editor_Preview_PlaySprite(0)
	End If
End Sub

Sub Editor_spriteBounds_Update()
	Gui_Surface_Clear(spriteBounds_spriteSheetSurface)
	src_w = 0
	src_h = 0
	Dim mx
	Dim my
	Gui_Surface_GetMouse(spriteBounds_spriteSheetSurface, mx, my)
	If Sprite_inUse[SpriteMain_Current_Sprite] Then
		
		If (Key(K_LCTRL) Or Key(K_RCTRL)) And Key(K_A) Then
			For i = 0 to Sprite_NumFrames[SpriteMain_Current_Sprite] - 1
				Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, i] = Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
				Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, i] = Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
				Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, i, 0] = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0]
				Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, i, 1] = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1]
			Next
		ElseIf (Key(K_LCTRL) Or Key(K_RCTRL)) And Key(K_F) Then
			For i = spriteBounds_selectedFrame to Sprite_NumFrames[SpriteMain_Current_Sprite] - 1
				Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, i] = Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
				Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, i] = Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
				Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, i, 0] = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0]
				Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, i, 1] = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1]
			Next
		End If
		
		selected_shape = Gui_DropDown_GetSelectedItem(spriteBounds_shapeSelection)
		Select Case selected_shape
		Case spriteBounds_shape_rect
			Sprite_Frame_Bound_Shape[SpriteMain_Current_Sprite] = SHAPE_TYPE_RECT
		Case spriteBounds_shape_circle
			Sprite_Frame_Bound_Shape[SpriteMain_Current_Sprite] = SHAPE_TYPE_CIRCLE
		End Select
		
		If Gui_TextField_Return(spriteBounds_boundXField) Then
			tf_value$ = Gui_TextField_GetValue$(spriteBounds_boundXField)
			Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame] = Int( Val(tf_value$) )
		ElseIf Gui_TextField_Return(spriteBounds_boundYField) Then
			tf_value$ = Gui_TextField_GetValue$(spriteBounds_boundYField)
			Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame] = Int( Val(tf_value$) )
		ElseIf Gui_TextField_Return(spriteBounds_param1Field) Then
			tf_value$ = Gui_TextField_GetValue$(spriteBounds_param1Field)
			Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0] = Int( Val(tf_value$) )
		ElseIf Gui_TextField_Return(spriteBounds_param2Field) Then
			tf_value$ = Gui_TextField_GetValue$(spriteBounds_param2Field)
			Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1] = Int( Val(tf_value$) )
		End If
		
		If spriteBounds_spriteSheetSurface_view = SPRITEBOUND_VIEW_SHEET Then
			src_w = Sprite_Image_W[SpriteMain_Current_Sprite]
			src_h = Sprite_Image_H[SpriteMain_Current_Sprite]
			If spriteBounds_spriteSheetSurface_w < src_w Then
				src_w = spriteBounds_spriteSheetSurface_w
			End If
			If spriteBounds_spriteSheetSurface_h < src_h Then
				src_h = spriteBounds_spriteSheetSurface_h
			End If
			If Gui_Surface_MouseOver(spriteBounds_spriteSheetSurface) Then
				If Key(K_RIGHT) And ( (spriteBounds_spriteSheetSurface_offset_x+spriteMain_scroll_speed+src_w) < Sprite_Image_W[SpriteMain_Current_Sprite] ) Then
					spriteBounds_spriteSheetSurface_offset_x = spriteBounds_spriteSheetSurface_offset_x + spriteMain_scroll_speed
				End If
				If Key(K_LEFT) And ( (spriteBounds_spriteSheetSurface_offset_x-spriteMain_scroll_speed) >= 0) Then
					spriteBounds_spriteSheetSurface_offset_x = spriteBounds_spriteSheetSurface_offset_x - spriteMain_scroll_speed
				End If
				If Key(K_DOWN) And ( (spriteBounds_spriteSheetSurface_offset_y+spriteMain_scroll_speed+src_h) < Sprite_Image_H[SpriteMain_Current_Sprite] ) Then
					spriteBounds_spriteSheetSurface_offset_y = spriteBounds_spriteSheetSurface_offset_y + spriteMain_scroll_speed
				End If
				If Key(K_UP) And ( (spriteBounds_spriteSheetSurface_offset_y-spriteMain_scroll_speed) >= 0 ) Then
					spriteBounds_spriteSheetSurface_offset_y = spriteBounds_spriteSheetSurface_offset_y - spriteMain_scroll_speed
				End If
			End If
			
			If Gui_Button_Clicked(spriteBounds_frameViewButton) Then
				spriteBounds_spriteSheetSurface_view = SPRITEBOUND_VIEW_FRAME
			End If
			
			off_x = spriteBounds_spriteSheetSurface_offset_x
			off_y = spriteBounds_spriteSheetSurface_offset_y
			
			s_index = Int( (off_y + my) / Sprite_Frame_Height[SpriteMain_Current_Sprite] ) * Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite] + Int( (off_x + mx) / Sprite_Frame_Width[SpriteMain_Current_Sprite])
			
			'Print Sprite_NumFrames[SpriteMain_Current_Sprite]
			'Print "s = ";s_index
			
			If Gui_Surface_Clicked(spriteBounds_spriteSheetSurface) And s_index < Sprite_NumFrames[SpriteMain_Current_Sprite] Then
				spriteBounds_selectedFrame = s_index
				Gui_TextField_SetValue(spriteBounds_indexField, Str$(s_index))
				Gui_TextField_SetValue(spriteBounds_boundXField, Str$(Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, s_index]))
				Gui_TextField_SetValue(spriteBounds_boundYField, Str$(Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, s_index]))
				Gui_TextField_SetValue(spriteBounds_param1Field, Str$(Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, s_index, 0]))
				Gui_TextField_SetValue(spriteBounds_param2Field, Str$(Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, s_index, 1]))
				Select Case Sprite_Frame_Bound_Shape[SpriteMain_Current_Sprite]
				Case SHAPE_TYPE_CIRCLE
					Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, spriteBounds_shape_circle)
				Case SHAPE_TYPE_RECT
					Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, spriteBounds_shape_rect)
				End Select
				Gui_DropDown_Update(spriteBounds_shapeSelection)
			End If
			
			'print "src = ";src_w;", ";src_h
			'Print "tileset: ";tileMain_tileSheet_offset_x;", ";tileMain_tileSheet_offset_y;", ";src_w;", ";src_h
			Gui_Surface_DrawImage_Blit(spriteBounds_spriteSheetSurface, Sprite_Image[SpriteMain_Current_Sprite], 0, 0, off_x, off_y, src_w, src_h)
			
			If s_index < Sprite_NumFrames[SpriteMain_Current_Sprite] Then
				frame_x = Int((off_x + mx) / Sprite_Frame_Width[SpriteMain_Current_Sprite]) * Sprite_Frame_Width[SpriteMain_Current_Sprite] '- (off_x Mod Sprite_Frame_Width[SpriteMain_Current_Sprite])
				frame_y = Int((off_y + my) / Sprite_Frame_Height[SpriteMain_Current_Sprite]) * Sprite_Frame_Height[SpriteMain_Current_Sprite] '- (off_y Mod Sprite_Frame_Height[SpriteMain_Current_Sprite])
				Gui_Surface_SetColor(spriteBounds_spriteSheetSurface, tileSelect_selectedTile_color)
				Gui_Surface_Rect(spriteBounds_spriteSheetSurface, frame_x-off_x, frame_y-off_y, Sprite_Frame_Width[SpriteMain_Current_Sprite], Sprite_Frame_Height[SpriteMain_Current_Sprite])
			End If
			
			Gui_Surface_Update(spriteBounds_spriteSheetSurface)
		Else
			src_w = Sprite_Frame_Width[SpriteMain_Current_Sprite]
			src_h = Sprite_Frame_Height[SpriteMain_Current_Sprite]
			
			frame_x = Int(spriteBounds_selectedFrame Mod Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Width[SpriteMain_Current_Sprite]
			frame_y = Int(spriteBounds_selectedFrame / Sprite_Image_WidthInFrames[SpriteMain_Current_Sprite]) * Sprite_Frame_Height[SpriteMain_Current_Sprite]
			frame_w = Sprite_Frame_Width[SpriteMain_Current_Sprite]
			frame_h = Sprite_Frame_Height[SpriteMain_Current_Sprite]
			
			Dim z
			
			Dim frameView_offset_x
			Dim frameView_offset_y
			
			If frame_w > frame_h Then
				z = Int(spriteBounds_spriteSheetSurface_w / frame_w)
				frameView_offset_x = 0
				frameView_offset_y = Int(spriteBounds_spriteSheetSurface_h/2) - Int( (frame_h*z) /2)
			Else
				z = Int(spriteBounds_spriteSheetSurface_h / frame_h)
				frameView_offset_x = Int(spriteBounds_spriteSheetSurface_w/2) - Int( (frame_w*z) /2)
				frameView_offset_y = 0
			End If
			
			Gui_Surface_GetMouse(spriteBounds_spriteSheetSurface, mx, my)
			
			If Gui_Button_Clicked(spriteBounds_sheetViewButton) Then
				spriteBounds_spriteSheetSurface_view = SPRITEBOUND_VIEW_SHEET
			ElseIf Gui_Surface_Clicked(spriteBounds_spriteSheetSurface) Then
				Select Case spriteBound_CurrentPoint
				Case 0
					Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame] = Int( (mx - frameView_offset_x) / z)
					Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame] = Int( (my - frameView_offset_y) / z)
					Gui_TextField_SetValue(spriteBounds_boundXField, Str$(Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]))
					Gui_TextField_SetValue(spriteBounds_boundYField, Str$(Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]))
					spriteBound_CurrentPoint = 1
				Case 1
					Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0] = Int( (mx - frameView_offset_x) / z)
					Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1] = Int( (my - frameView_offset_y) / z)
					Gui_TextField_SetValue(spriteBounds_param1Field, Str$(Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0]))
					Gui_TextField_SetValue(spriteBounds_param2Field, Str$(Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1]))
					spriteBound_CurrentPoint = 0
				End Select
			End If
			
			Gui_Surface_Clear(spriteBounds_spriteSheetSurface)
			
			Gui_Surface_DrawImage_Blit_Ex(spriteBounds_spriteSheetSurface, Sprite_Image[SpriteMain_Current_Sprite], frameView_offset_x, frameView_offset_y, frame_w*z, frame_h*z, frame_x, frame_y, frame_w, frame_h)
			
			
			sx = Sprite_Frame_Bound_X[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
			sy = Sprite_Frame_Bound_Y[SpriteMain_Current_Sprite, spriteBounds_selectedFrame]
			
			Gui_Surface_SetColor(spriteBounds_spriteSheetSurface, tileSelect_selectedTile_color)
			If spriteBound_CurrentPoint = 0 Then
				sp1 = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 0]+1
				sp2 = Sprite_Frame_Bound_Param[SpriteMain_Current_Sprite, spriteBounds_selectedFrame, 1]+1
				Gui_Surface_Box(spriteBounds_spriteSheetSurface, sx * z + frameView_offset_x, sy * z + frameView_offset_y, frameView_offset_x + (sp1 * z)-1, frameView_offset_y +(sp2 * z)-1)
			Else
				sp1 = Int( mx / z) + 1
				sp2 = Int( my / z) + 1
				Gui_Surface_Box(spriteBounds_spriteSheetSurface, sx * z + frameView_offset_x, sy * z + frameView_offset_y, sp1 * z-1, sp2 * z-1)
			End If
			
			Gui_Surface_Update(spriteBounds_spriteSheetSurface)
		End If
	End If
End Sub

Sub Editor_spriteMain_setSelectedSprite(db_entry)
	If db_entry < 0 Or db_entry >= stage_database_count Then
		Return
	End If
		
	SpriteMain_Current_Sprite = stage_database_sprite[db_entry]
	
	spr = SpriteMain_Current_Sprite
	
	SpriteMain_SpriteAnimation_Current_Animation = 0
		
	Gui_TextField_SetValue(spriteInfo_nameField, Sprite_Name$[spr])
	Gui_TextField_SetValue(spriteInfo_frameWidthField, Str$(Sprite_Frame_Width[spr]))
	Gui_TextField_SetValue(spriteInfo_frameHeightField, Str$(Sprite_Frame_Height[spr]))
	
	Gui_ListBox_Clear(spriteAnimation_animationListBox)
	
	If Sprite_NumAnimations[spr] Then
		For i = 0 to Sprite_NumAnimations[spr]-1
			Gui_ListBox_AddItem(spriteAnimation_animationListBox, Sprite_Animation_Name$[spr, i])
		Next
	End If
	Gui_ListBox_SetSelectedItem(spriteAnimation_animationListBox, 0)
	Gui_ListBox_Update(spriteAnimation_animationListBox)
	
	Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
	Gui_Surface_DrawImage(spriteAnimation_spriteSheetSurface, Sprite_Image[spr], 0, 0)
	Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
	Gui_ImageSlide_Clear(spriteAnimation_frameSlide)
	
	For i = 0 to MAX_SPRITE_ANIMATION_FRAMES-1
		Gui_ImageClip_SetSource(spriteAnimation_frameSlide_frame[i], Sprite_Image[spr])
	Next
	
	Gui_ImageClip_SetSource(spriteAnimation_previewClip, Sprite_Image[spr])
	
	Editor_spriteAnimation_ImageSlide_Update
	
	spriteAnimation_spriteSheetSurface_offset_x = 0
	spriteAnimation_spriteSheetSurface_offset_y = 0
	
	If Sprite_NumAnimations[spr] > 0 Then
		Gui_TextField_SetValue(spriteAnimation_nameField, Sprite_Animation_Name$[spr,0])
		Gui_TextField_SetValue(spriteAnimation_FPSField, Str$(Sprite_Animation_FPS[spr, 0]))
	Else
		Gui_TextField_SetValue(spriteAnimation_nameField, "")
		Gui_TextField_SetValue(spriteAnimation_FPSField, "")
	End If
	
	Gui_Surface_Clear(spriteBounds_spriteSheetSurface)
	Gui_Surface_DrawImage(spriteBounds_spriteSheetSurface, Sprite_Image[spr], 0, 0)
	Gui_Surface_Update(spriteBounds_spriteSheetSurface)
	
	spriteBounds_spriteSheetSurface_view = SPRITEBOUND_VIEW_SHEET
	spriteBounds_spriteSheetSurface_offset_x = 0
	spriteBounds_spriteSheetSurface_offset_y = 0
	Gui_TextField_SetValue(spriteBounds_indexField, "0")
	Gui_TextField_SetValue(spriteBounds_boundXField, Str$(Sprite_Frame_Bound_X[spr, 0]))
	Gui_TextField_SetValue(spriteBounds_boundYField, Str$(Sprite_Frame_Bound_Y[spr, 0]))
	Gui_TextField_SetValue(spriteBounds_param1Field, Str$(Sprite_Frame_Bound_Param[spr, 0, 0]))
	Gui_TextField_SetValue(spriteBounds_param2Field, Str$(Sprite_Frame_Bound_Param[spr, 0, 1]))
	Select Case Sprite_Frame_Bound_Shape[spr]
	Case SHAPE_TYPE_RECT	
		Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, spriteBounds_shape_rect)
	Case SHAPE_TYPE_CIRCLE
		Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, spriteBounds_shape_circle)
	End Select
End Sub

Function Editor_LoadMultipleSprites()
	System("rcbasic editor.cbc spriteMain_multiLoad")
	
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	n = 0
	shouldSetSelected = False
	If stage_database_count <= 0 Then
		shouldSetSelected = True
	End If
	While n < Dlg_data_count
		sprite_isInDB = False
		If stage_database_count > 0 Then
			For i = 0 to stage_database_count-1
				If Sprite_Name$[stage_database_sprite[i]] = Dlg_data$[n] Then
					sprite_isInDB = True
					Exit For
				End If
			Next
		End If
		If Not sprite_isInDB And stage_database_count < MAX_SPRITES Then
			stage_database_sprite[stage_database_count] = LoadSprite(Dlg_data$[n])
			stage_database_count = stage_database_count + 1
			Gui_ListBox_AddItem(spriteStageList_listBox, Dlg_data$[n])
		End If
		n = n + 1
	Wend
	If shouldSetSelected Then
		Editor_spriteMain_setSelectedSprite(0)
	End If
	Gui_ListBox_Update(spriteStageList_listBox)
	Return True
End Function

Function Editor_spriteMain_Update()
	If Gui_TextField_Return(spriteInfo_nameField) Then
		Gui_TextField_SetValue(spriteInfo_nameField, Sprite_Name$[SpriteMain_Current_Sprite])
	ElseIf Gui_TextField_Return(spriteInfo_frameWidthField) Then
		Gui_TextField_SetValue(spriteInfo_frameWidthField, Str$(Sprite_Frame_Width[SpriteMain_Current_Sprite]))
	ElseIf Gui_TextField_Return(spriteInfo_frameHeightField) Then
		Gui_TextField_SetValue(spriteInfo_frameHeightField, Str$(Sprite_Frame_Height[SpriteMain_Current_Sprite]))
	End If
	
	If Gui_Button_Clicked(spriteStageList_addButton) Then
		Editor_AddSpriteToDataBase(SpriteMain_Current_Sprite)
	ElseIf Gui_Button_Clicked(spriteStageList_addFromFileButton) Then
		Editor_LoadMultipleSprites
	ElseIf Gui_Button_Clicked(spriteStageList_editButton) And stage_database_count > 0 Then
		Editor_Sprite_Backup
		db_entry = Gui_ListBox_GetSelectedItem(spriteStageList_listBox)
		Editor_spriteMain_setSelectedSprite(db_entry)
	ElseIf Gui_Button_Clicked(spriteStageList_removeButton) Then
		db_entry = Gui_ListBox_GetSelectedItem(spriteStageList_listBox)
		If db_entry >= 0 And db_entry < stage_database_count Then
			If stage_database_sprite[db_entry] <> SpriteMain_Current_Sprite Then
				DestroySprite(stage_database_sprite[db_entry])
			End If
			Editor_RemoveSpriteFromDataBase(stage_database_sprite[db_entry])
		End If
	End If
	
	current_tab = Gui_TabGroup_GetActiveTab(sprite_tabGroup)
	
	Select Case current_tab
	Case sprite_tabGroup_animationTab
		Editor_spriteAnimation_Update
	Case sprite_tabGroup_boundsTab
		Editor_spriteBounds_Update
	End Select
	
End Function

