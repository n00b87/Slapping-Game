include "gui.bas"
Include "engine.bas"
Include "dlg.bas"
Include "editor_main_ui.bas"
Include "editor_top_menu.bas"
Include "editor_bkg_options.bas"
Include "editor_tile_menu.bas"
Include "editor_shape_options.bas"
Include "editor_sprite_menu.bas"
Include "editor_actor_options.bas"

If NumCommands > 1 Then
	Select Case Command$(1)
	Case "top_menu_newButton"
		Editor_NewStage_Window
	Case "top_menu_loadButton"
		Editor_LoadStage_Window
	Case "top_menu_saveButton"
		If NumCommands > 2 Then
			Editor_SaveStage_Window(Command$(2))
		Else
			Editor_SaveStage_Window("Untitled")
		End If
	Case "bkg_loadImageButton"
		Editor_Bkg_LoadImage_Window
	Case "bkg_setColorButton"
		r = Val(Command$(2))
		g = Val(Command$(3))
		b = Val(Command$(4))
		Editor_Bkg_SetColor_Window(r, g, b)
	Case "bkg_propertiesButton"
		Dim c[12]
		If NumCommands > 2 Then
			For i = 2 to NumCommands-1
				c[i-2] = Val(Command$(i))
			Next
		End If
		Editor_Bkg_Properties_Window(c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7], c[8], c[9], c[10], c[11])
	Case "tileMain_loadTilesetButton"
		Editor_LoadTileset_Window
	Case "shape_addShapeButton"
		Editor_AddShape_Window
	Case "spriteMain_newSpriteButton"
		Editor_NewSprite_Window
	Case "spriteMain_newSprite_exists"
		Editor_SpriteAlreadyExists
	Case "spriteMain_shouldBackup"
		Editor_SpriteShouldBackUp
	Case "spriteMain_loadSpriteButton"
		Editor_LoadSprite_Window
	Case "spriteMain_multiLoad"
		Editor_LoadMultipleSprites_Window
	Case "editor_ActorOptions"
		Editor_NewActor_Window
	End Select
	end
End If

ENGINE_EDITOR_USE = True

Editor_Main_UI

Engine_Init

Editor_Main
