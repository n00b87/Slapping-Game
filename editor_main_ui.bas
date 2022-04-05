MAIN_WINDOW_WIDTH = 1280
MAIN_WINDOW_HEIGHT = 800

Dim main_window

Dim Current_Layer
Dim TileSelect_Current_Tileset
Dim TileMain_Current_Tileset

Dim SpriteMain_Current_Sprite
Dim SpriteMain_SpriteAnimation_Current_Animation
Dim SpriteMain_SpriteBound_Current_Frame

Dim top_menu_panel
Dim top_menu_newButton
Dim top_menu_loadButton
Dim top_menu_saveButton

Dim main_tabGroup
Dim main_tabGroup_stageTab
Dim main_tabGroup_tileTab
Dim main_tabGroup_spriteTab

Dim stageInfo_panel
Dim stageInfo_nameLabel
Dim stageInfo_nameField
Dim stageInfo_widthLabel
Dim stageInfo_widthField
Dim stageInfo_heightLabel
Dim stageInfo_heightField
	
Dim layerInfo_panel
Dim layerInfo_layerLabel[5]
Dim layerInfo_typeSelect[5]
Dim layerInfo_typeSelect_Option[5, 4]

LAYER_TYPE_NULL = 0
LAYER_TYPE_BKG = 1
LAYER_TYPE_TILE = 2
LAYER_TYPE_VIDEO = 3

Dim layerInfo_colDetCheckBox[5]
Dim layerInfo_typeLabel
Dim layerInfo_colDetLabel
	
Dim info_tabGroup
Dim info_stageTab
Dim info_layerTab

Dim tool_tabGroup
Dim tool_tileTab
Dim tool_bkgTab
Dim tool_actorTab
Dim tool_shapeTab

Dim tileSelect_panel
Dim tileSelect_sheetSelect_Option[4]
Dim tileSelect_sheetSelect

Dim tileSelect_selectedTile_color
Dim tileSelect_tileSheet_Surface
Dim tileSelect_tileSheet_Surface_w
Dim tileSelect_tileSheet_Surface_h
Dim tileSelect_tileSheet_offset_x
Dim tileSelect_tileSheet_offset_y
Dim tileSelect_tileSheet_selected_x
Dim tileSelect_tileSheet_selected_y
Dim tileSelect_tileSheet_selected_index
Dim tileSelect_scroll_speed

Dim background_panel
Dim background_surface
Dim background_surface_w
Dim background_surface_h
Dim background_loadImageButton
Dim background_ClearImageButton
Dim background_setColorButton
Dim background_propertiesButton

Dim actor_panel
Dim actor_listBox
Dim actor_preview_image
Dim actor_preview_w
Dim actor_preview_h
Dim actor_previewClip
Dim actor_addButton
Dim actor_removeButton
Dim actor_propertiesButton
Dim actor_name_label
Dim actor_name_field
Dim actor_positionX_label
Dim actor_positionX_field
Dim actor_positionY_label
Dim actor_positionY_field
Dim actor_layer_label
Dim actor_layer_field

Dim SHAPE_STATE_DRAW_RECT
Dim SHAPE_STATE_DRAW_LINE
Dim SHAPE_STATE_NULL

SHAPE_STATE_NULL = 0
SHAPE_STATE_DRAW_RECT = 1
SHAPE_STATE_DRAW_LINE = 2

Dim Current_Shape
Dim Shape_Current_State
Dim Shape_Current_Point
Dim Shape_Point_X[2]
Dim Shape_Point_Y[2]

Dim shape_panel
Dim shape_listBox
Dim shape_type_label
Dim shape_type_selection
Dim shape_rect
Dim shape_line
Dim shape_positionX_label
Dim shape_positionX_field
Dim shape_positionY_label
Dim shape_positionY_field
Dim shape_parameter1_label
Dim shape_parameter1_field
Dim shape_parameter2_label
Dim shape_parameter2_field
Dim shape_addButton
Dim shape_removeButton
Dim shape_drawButton

Dim stageView_panel
Dim stageView_layerSelection
Dim stageView_layer0
Dim stageView_layer1
Dim stageView_layer2
Dim stageView_layer3
Dim stageView_layer4
Dim stageView_Surface
Dim stageView_Surface_w
Dim stageView_Surface_h
Dim stageView_offset_x
Dim stageView_offset_y
Dim stageView_scroll_speed

Dim stagePos_panel

Dim stagePos_stageCoord_label
Dim stagePos_stageCoord_X_label
Dim stagePos_stageCoord_X_field
Dim stagePos_stageCoord_Y_label
Dim stagePos_stageCoord_Y_field
Dim stagePos_stageCoord_Tile_X_label
Dim stagePos_stageCoord_Tile_X_field
Dim stagePos_stageCoord_Tile_Y_label
Dim stagePos_stageCoord_Tile_Y_field

Dim stagePos_screenCoord_label
Dim stagePos_screenCoord_X_label
Dim stagePos_screenCoord_X_field
Dim stagePos_screenCoord_Y_label
Dim stagePos_screenCoord_Y_field
Dim stagePos_screenCoord_Tile_X_label
Dim stagePos_screenCoord_Tile_X_field
Dim stagePos_screenCoord_Tile_Y_label
Dim stagePos_screenCoord_Tile_Y_field

Dim stagePos_cameraView_label
Dim stagePos_cameraView_X_label
Dim stagePos_cameraView_X_field
Dim stagePos_cameraView_Y_label
Dim stagePos_cameraView_Y_field
Dim stagePos_cameraView_Tile_X_label
Dim stagePos_cameraView_Tile_X_field
Dim stagePos_cameraView_Tile_Y_label
Dim stagePos_cameraView_Tile_Y_field

Dim displaySettings_panel

Dim displaySettings_layer_label[MAX_LAYERS]
Dim displaySettings_layer_main_label
Dim displaySettings_layer_main_checkbox[MAX_LAYERS]
Dim displaySettings_layer_actor_label
Dim displaySettings_layer_actor_checkbox[MAX_LAYERS]
Dim displaySettings_layer_shape_label
Dim displaySettings_layer_shape_checkbox[MAX_LAYERS]


Dim tileMain_panel
Dim tileMain_tileSheetSelection
Dim tileMain_loadButton
Dim tileMain_saveButton
Dim tileMain_tileSheetSurface
Dim tileMain_tileSheetSurface_w
Dim tileMain_tileSheetSurface_h
Dim tileMain_tileSheet_offset_x
Dim tileMain_tileSheet_offset_y
Dim tileMain_tileSheet_selected_index
Dim tileMain_tileSheet_selected_x
Dim	tileMain_tileSheet_selected_y
Dim tileMain_frameSlide
Dim tileMain_frameSlide_frame[MAX_TILE_FRAMES]
Dim tileMain_addFrameButton
Dim tileMain_removeFrameButton
Dim tileMain_setFrameButton
Dim tileMain_previewImage
Dim tileMain_previewClip
Dim tileMain_playButton
Dim tileMain_stopButton
Dim tileMain_tileIndexLabel
Dim tileMain_tileIndexField
Dim tileMain_tileFPSLabel
Dim tileMain_tileFPSField
Dim tileMain_frameCountLabel
Dim tileMain_frameCountField
Dim tileMain_animationIsPlaying

Dim sprite_tabGroup
Dim sprite_tabGroup_animationTab
Dim sprite_tabGroup_boundsTab

Dim spriteMain_panel
Dim spriteMain_newButton
Dim spriteMain_saveButton
Dim spriteMain_loadButton

Dim spriteInfo_panel
Dim spriteInfo_nameLabel
Dim spriteInfo_nameField
Dim spriteInfo_frameWidthLabel
Dim spriteInfo_frameWidthField
Dim spriteInfo_frameHeightLabel
Dim spriteInfo_frameHeightField

Dim spriteStageList_panel_y
Dim spriteStageList_panel_h
Dim spriteStageList_panel
Dim spriteStageList_listBox
Dim spriteStageList_addButton
Dim spriteStageList_addFromFileButton
Dim spriteStageList_editButton
Dim spriteStageList_removeButton

Dim spriteAnimation_panel
Dim spriteAnimation_animationListBox
Dim spriteAnimation_newAnimationButton
Dim spriteAnimation_removeAnimationButton
Dim spriteAnimation_spriteSheetSurface
Dim spriteAnimation_spriteSheetSurface_w
Dim spriteAnimation_spriteSheetSurface_h
Dim spriteAnimation_spriteSheetSurface_offset_x
Dim spriteAnimation_spriteSheetSurface_offset_y
Dim spriteAnimation_frameSlide
Dim spriteAnimation_frameSlide_frame[MAX_SPRITE_ANIMATION_FRAMES]
Dim spriteAnimation_addFrameButton
Dim spriteAnimation_removeFrameButton
Dim spriteAnimation_setFrameButton
Dim spriteAnimation_previewImage
Dim spriteAnimation_previewClip
Dim spriteAnimation_previewPlayButton
Dim spriteAnimation_previewStopButton
Dim spriteAnimation_nameLabel
Dim spriteAnimation_nameField
Dim spriteAnimation_FPSLabel
Dim spriteAnimation_FPSField

Dim SPRITEBOUND_VIEW_FRAME
Dim SPRITEBOUND_VIEW_SHEET

SPRITEBOUND_VIEW_SHEET = 0
SPRITEBOUND_VIEW_FRAME = 1

Dim spriteBounds_panel
Dim spriteBounds_spriteSheetSurface
Dim spriteBounds_spriteSheetSurface_view
Dim spriteBounds_spriteSheetSurface_w
Dim spriteBounds_spriteSheetSurface_h
Dim spriteBounds_spriteSheetSurface_offset_x
Dim spriteBounds_spriteSheetSurface_offset_y
Dim spriteBounds_selectedFrame
Dim spriteBounds_indexLabel
Dim spriteBounds_indexField
Dim spriteBounds_shapeLabel
Dim spriteBounds_shapeSelection
Dim spriteBounds_shape_rect
Dim spriteBounds_shape_circle
Dim spriteBounds_boundXLabel
Dim spriteBounds_boundXField
Dim spriteBounds_boundYLabel
Dim spriteBounds_boundYField
Dim spriteBounds_param1Label
Dim spriteBounds_param1Field
Dim spriteBounds_param2Label
Dim spriteBounds_param2Field
Dim spriteBounds_frameViewButton
Dim spriteBounds_sheetViewButton

Dim stage_database_sprite[MAX_SPRITES]
Dim stage_database_count

Dim actor_database_count
Dim actor_database_actor[MAX_ACTORS]
Dim Current_Actor

Dim tile_snap

Function Editor_Main_UI()
	main_window = Gui_WindowOpen("n00b Engine", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, MAIN_WINDOW_WIDTH, MAIN_WINDOW_HEIGHT)

	'Top Menu
	top_menu_panel = Gui_CreatePanel(MAIN_WINDOW_WIDTH, Int(MAIN_WINDOW_HEIGHT/20))

	top_menu_newButton = Gui_CreateButton("New", Int(MAIN_WINDOW_HEIGHT/20)*2, Int(MAIN_WINDOW_HEIGHT/20)-2)
	top_menu_loadButton = Gui_CreateButton("Load", Int(MAIN_WINDOW_HEIGHT/20)*2, Int(MAIN_WINDOW_HEIGHT/20)-2)
	top_menu_saveButton = Gui_CreateButton("Save", Int(MAIN_WINDOW_HEIGHT/20)*2, Int(MAIN_WINDOW_HEIGHT/20)-2)

	Gui_Panel_AddObject(top_menu_panel, top_menu_newButton, 1, 1)
	Gui_Panel_AddObject(top_menu_panel, top_menu_loadButton, 2 + (Int(MAIN_WINDOW_HEIGHT/20)*2), 1)
	Gui_Panel_AddObject(top_menu_panel, top_menu_saveButton, 1 + (2 + (Int(MAIN_WINDOW_HEIGHT/20)*4)), 1)

	Gui_Window_AddPanel(main_window, top_menu_panel, 0, 0)

	'Main Tab
	main_tabGroup = Gui_CreateTabGroup(Int(MAIN_WINDOW_WIDTH), Int(MAIN_WINDOW_HEIGHT/20))

	main_tabGroup_stageTab = Gui_TabGroup_AddTab(main_tabGroup, "Stage")
	main_tabGroup_tileTab = Gui_TabGroup_AddTab(main_tabGroup, "Tile")
	main_tabGroup_spriteTab = Gui_TabGroup_AddTab(main_tabGroup, "Sprite")

	Gui_Window_AddTabGroup(main_window, main_tabGroup, 0, Int(MAIN_WINDOW_HEIGHT/20) + 2)

	'Stage Info
	TOOL_AREA_Y = Int(MAIN_WINDOW_HEIGHT/20)*2 + 4
	TOOL_AREA_HEIGHT = MAIN_WINDOW_HEIGHT - (Int(MAIN_WINDOW_HEIGHT/20)*2 +2)

	stageInfo_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Int(TOOL_AREA_HEIGHT/3 - 4) - Int(MAIN_WINDOW_HEIGHT/10))

	dim txt_w
	dim txt_h
	GetTextSize(GUI_FONT, "Stage Name:", txt_w, txt_h)
	stageInfo_nameLabel = Gui_CreateLabel("Stage Name", GUI_FONT_W * 13, GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_nameLabel, 5, 5)
	stageInfo_nameField = Gui_CreateTextField(Int(MAIN_WINDOW_WIDTH/4) - 2 - (5 + GUI_FONT_W*13), GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_nameField, txt_w + 13, 5)

	'GetTextSize(GUI_FONT, "Stage Width:", txt_w, txt_h)
	stageInfo_widthLabel = Gui_CreateLabel("Stage Width", GUI_FONT_W * 13, GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_widthLabel, 5, 5 + GUI_FONT_H + 2)
	stageInfo_widthField = Gui_CreateTextField( GUI_FONT_W * 6, GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_widthField, txt_w + 13, 5 + GUI_FONT_H + 2)

	'GetTextSize(GUI_FONT, "Stage Width:", txt_w, txt_h)
	stageInfo_heightLabel = Gui_CreateLabel("Stage Height", GUI_FONT_W * 13, GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_heightLabel, 5, 5 + GUI_FONT_H*2 + 4)
	stageInfo_heightField = Gui_CreateTextField( GUI_FONT_W * 6, GUI_FONT_H)
	Gui_Panel_AddObject(stageInfo_panel, stageInfo_heightField, txt_w + 13, 5 + GUI_FONT_H*2 + 4)

	Gui_Window_AddPanel(main_window, stageInfo_panel, 1, TOOL_AREA_Y + Int(MAIN_WINDOW_HEIGHT/20)+2)

	'Layer Info
	layerInfo_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Int(TOOL_AREA_HEIGHT/3 - 4) - Int(MAIN_WINDOW_HEIGHT/10))

	layerInfo_typeLabel = Gui_CreateLabel("TYPE", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(layerInfo_panel, layerInfo_typeLabel, 5 + GUI_FONT_W*12, 5)

	layerInfo_colDetLabel = Gui_CreateLabel("COL-DET", GUI_FONT_W*7, GUI_FONT_H)
	Gui_Panel_AddObject(layerInfo_panel, layerInfo_colDetLabel, 5 + GUI_FONT_W*12 + Int(MAIN_WINDOW_WIDTH/12) + 10, 5)

	For i = 0 to 4
		layerInfo_layerLabel[i] = Gui_CreateLabel("Layer " + str(i), GUI_FONT_W * 13, GUI_FONT_H)
		Gui_Panel_AddObject(layerInfo_panel, layerInfo_layerLabel[i], 5, 5 + i * (GUI_FONT_H+5) + GUI_FONT_H)
		
		layerInfo_typeSelect[i] = Gui_CreateDropDown(Int(MAIN_WINDOW_WIDTH/12), GUI_FONT_H+2)
		layerInfo_typeSelect_Option[i, 0] = Gui_DropDown_AddItem(layerInfo_typeSelect[i], "null")
		layerInfo_typeSelect_Option[i, 1] = Gui_DropDown_AddItem(layerInfo_typeSelect[i], "tile")
		layerInfo_typeSelect_Option[i, 2] = Gui_DropDown_AddItem(layerInfo_typeSelect[i], "background")
		Gui_Panel_AddObject(layerInfo_panel, layerInfo_typeSelect[i], GUI_FONT_W*12, 5 + i * (GUI_FONT_H+5) + GUI_FONT_H)
		
		layerInfo_colDetCheckBox[i] = Gui_CreateCheckBox(GUI_FONT_H, GUI_FONT_H)
		Gui_Panel_AddObject(layerInfo_panel, layerInfo_colDetCheckBox[i], 5 + GUI_FONT_W*12 + Int(MAIN_WINDOW_WIDTH/12) + 10, 5 + i * (GUI_FONT_H+5) + GUI_FONT_H)
	Next


	Gui_Window_AddPanel(main_window, layerInfo_panel, 1, TOOL_AREA_Y + Int(MAIN_WINDOW_HEIGHT/20)+2)

	'Info Tab Group
	info_tabGroup = Gui_CreateTabGroup(Int(MAIN_WINDOW_WIDTH/4)-2, Int(MAIN_WINDOW_HEIGHT/20))

	info_stageTab = Gui_TabGroup_AddTab(info_tabGroup, "Stage Info")
	Gui_TabGroup_Tab_AddObject(info_tabGroup, info_stageTab, stageInfo_panel)
	info_layerTab = Gui_TabGroup_AddTab(info_tabGroup, "Layer Settings")
	Gui_TabGroup_Tab_AddObject(info_tabGroup, info_layerTab, layerInfo_panel)

	Gui_Window_AddTabGroup(main_window, info_tabGroup, 1, TOOL_AREA_Y)

	'Tool Panels
	Tool_TabGroup_Y = TOOL_AREA_Y + Int(MAIN_WINDOW_HEIGHT/20) + ( Int(TOOL_AREA_HEIGHT/3 - 4) - Int(MAIN_WINDOW_HEIGHT/10) ) + 4

	'Tool Tab Group
	tool_tabGroup = Gui_CreateTabGroup(Int(MAIN_WINDOW_WIDTH/4)-2, Int(MAIN_WINDOW_HEIGHT/20))

	tool_tileTab = Gui_TabGroup_AddTab(tool_tabGroup, "Tile")
	tool_bkgTab = Gui_TabGroup_AddTab(tool_tabGroup, "Bkg")
	tool_actorTab = Gui_TabGroup_AddTab(tool_tabGroup, "Actor")
	tool_shapeTab = Gui_TabGroup_AddTab(tool_tabGroup, "Shape")

	Gui_Window_AddTabGroup(main_window, tool_tabGroup, 1, Tool_TabGroup_Y)


	Tool_Panel_Y = Tool_TabGroup_Y + Int(MAIN_WINDOW_HEIGHT/20) + 2
	Tool_Panel_H = MAIN_WINDOW_HEIGHT - Tool_Panel_Y - 4

	'---------------Tile Select Panel-------------------------------------------------------

	tileSelect_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Tool_Panel_H)
	Gui_TabGroup_Tab_AddObject(tool_tabGroup, tool_tileTab, tileSelect_panel)

	'tilesheet Selection
	tileSelect_sheetSelect = Gui_CreateDropDown(Int(MAIN_WINDOW_WIDTH/4)-8, GUI_FONT_H+2)
	
	For i = 0 to MAX_TILESETS-1
		Gui_DropDown_AddItem(tileSelect_sheetSelect, "Tileset " + Str$(i))
	Next

	Gui_Panel_AddObject(tileSelect_panel, tileSelect_sheetSelect, 2, 2)

	tileSelect_selectedTile_color = rgb(255, 0, 0)
	tileSelect_tileSheet_selected_index = 0
	tileSelect_tileSheet_selected_x = 0
	tileSelect_tileSheet_selected_y = 0
	tileSelect_tileSheet_offset_x = 0
	tileSelect_tileSheet_offset_y = 0
	tileSelect_scroll_speed = 4
	
	'tilesheet surface
	tileSelect_tileSheet_Surface_w = Int(MAIN_WINDOW_WIDTH/4)-8
	tileSelect_tileSheet_Surface_h = Tool_Panel_H - (GUI_FONT_H*4)
	tileSelect_tileSheet_Surface = Gui_CreateSurface(tileSelect_tileSheet_Surface_w, tileSelect_tileSheet_Surface_h)
	Gui_Panel_AddObject(tileSelect_panel, tileSelect_tileSheet_Surface, 2, GUI_FONT_H + 8)

	Gui_Window_AddPanel(main_window, tileSelect_panel, 1, Tool_Panel_Y)
	'---------------------------------------------------------------------------------------

	'-------------Background Panel----------------------------------------------------------
	background_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Tool_Panel_H)
	Gui_TabGroup_Tab_AddObject(tool_tabGroup, tool_bkgTab, background_panel)

	background_surface = Gui_CreateSurface(Int(MAIN_WINDOW_WIDTH/4)-8, Int(MAIN_WINDOW_WIDTH/6)-8)
	background_surface_w = Int(MAIN_WINDOW_WIDTH/4)-8
	background_surface_h = Int(MAIN_WINDOW_WIDTH/6)-8
	Gui_Panel_AddObject(background_panel, background_surface, 2, 2)

	background_loadImageButton = Gui_CreateButton("Load Image", Int(MAIN_WINDOW_WIDTH/8)-4, GUI_FONT_H*2)
	Gui_Panel_AddObject(background_panel, background_loadImageButton, 2, Int(MAIN_WINDOW_WIDTH/6)-4)

	background_ClearImageButton = Gui_CreateButton("Clear Image", Int(MAIN_WINDOW_WIDTH/8)-4, GUI_FONT_H*2)
	Gui_Panel_AddObject(background_panel, background_ClearImageButton, 2, (Int(MAIN_WINDOW_WIDTH/6)-4) + GUI_FONT_H*2 + 2)

	background_setColorButton = Gui_CreateButton("Set Color", Int(MAIN_WINDOW_WIDTH/8)-4, GUI_FONT_H*2)
	Gui_Panel_AddObject(background_panel, background_setColorButton, Int(MAIN_WINDOW_WIDTH/8), Int(MAIN_WINDOW_WIDTH/6)-4)

	background_propertiesButton = Gui_CreateButton("Properties", Int(MAIN_WINDOW_WIDTH/8)-4, GUI_FONT_H*2)
	Gui_Panel_AddObject(background_panel, background_propertiesButton, Int(MAIN_WINDOW_WIDTH/8), (Int(MAIN_WINDOW_WIDTH/6)-4) + GUI_FONT_H*2 + 2)

	Gui_Window_AddPanel(main_window, background_panel, 1, Tool_Panel_Y)
	'---------------------------------------------------------------------------------------

	'-------------Actor Panel----------------------------------------------------------
	actor_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Tool_Panel_H)
	Gui_TabGroup_Tab_AddObject(tool_tabGroup, tool_actorTab, actor_panel)

	actor_listBox = Gui_CreateListBox(Int(MAIN_WINDOW_WIDTH/8)-8, Tool_Panel_H/2 - 4)
	Gui_Panel_AddObject(actor_panel, actor_listBox, 2, 2)

	actor_preview_image = Gui_CreateEmptyImage(Int(MAIN_WINDOW_WIDTH/10), Int(MAIN_WINDOW_WIDTH/10))
	actor_preview_w = Int(MAIN_WINDOW_WIDTH/10)
	actor_preview_h = Int(MAIN_WINDOW_WIDTH/10)

	actor_previewClip = Gui_CreateImageClip(actor_preview_image, actor_preview_w, actor_preview_h, actor_preview_w, actor_preview_h)
	Gui_Panel_AddObject(actor_panel, actor_previewClip, Int(MAIN_WINDOW_WIDTH/8)+16, 8)

	actor_addButton = Gui_CreateButton("Add Actor", actor_preview_w, GUI_FONT_H+2)
	Gui_Panel_AddObject(actor_panel, actor_addButton, Int(MAIN_WINDOW_WIDTH/8)+16, 8 + actor_preview_h + GUI_FONT_H)

	actor_removeButton = Gui_CreateButton("Remove Actor", actor_preview_w, GUI_FONT_H+2)
	Gui_Panel_AddObject(actor_panel, actor_removeButton, Int(MAIN_WINDOW_WIDTH/8)+16, 8 + actor_preview_h + GUI_FONT_H*2 + 4)

	'Properties: visible, solid, col-det
	'actor_propertiesButton = Gui_CreateButton("Properties", actor_preview_w, GUI_FONT_H+2)
	'Gui_Panel_AddObject(actor_panel, actor_propertiesButton, Int(MAIN_WINDOW_WIDTH/8)+16, 8 + actor_preview_h + GUI_FONT_H*3 + 8)

	actor_name_label = Gui_CreateLabel("Name", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(actor_panel, actor_name_label, 4, Tool_Panel_H/2 + 40)

	actor_name_field = Gui_CreateTextField(GUI_FONT_W* 12, GUI_FONT_H+1)
	Gui_Panel_AddObject(actor_panel, actor_name_field, GUI_FONT_W*4 + 6, Tool_Panel_H/2 + 40)

	actor_positionX_label = Gui_CreateLabel("PosX", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(actor_panel, actor_positionX_label, 4, Tool_Panel_H/2 + (GUI_FONT_H*2+4) + 40)

	actor_positionX_field = Gui_CreateTextField(GUI_FONT_W* 12, GUI_FONT_H+1)
	Gui_Panel_AddObject(actor_panel, actor_positionX_field, GUI_FONT_W*4 + 6, Tool_Panel_H/2 + (GUI_FONT_H*2+4) + 40)

	actor_positionY_label = Gui_CreateLabel("PosY", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(actor_panel, actor_positionY_label, 4, Tool_Panel_H/2 + (GUI_FONT_H*3+8) + 40)

	actor_positionY_field = Gui_CreateTextField(GUI_FONT_W* 12, GUI_FONT_H+1)
	Gui_Panel_AddObject(actor_panel, actor_positionY_field, GUI_FONT_W*4 + 6, Tool_Panel_H/2 + (GUI_FONT_H*3+8) + 40)
	
	actor_layer_label = Gui_CreateLabel("Layer", GUI_FONT_W*6, GUI_FONT_H)
	Gui_Panel_AddObject(actor_panel, actor_layer_label, 4, Tool_Panel_H/2 + (GUI_FONT_H*5+8) + 40)
	
	actor_layer_field = Gui_CreateTextField(GUI_FONT_W* 6, GUI_FONT_H+1)
	Gui_Panel_AddObject(actor_panel, actor_layer_field, GUI_FONT_W*5 + 6, Tool_Panel_H/2 + (GUI_FONT_H*5+8) + 40)
	
	Gui_Window_AddPanel(main_window, actor_panel, 1, Tool_Panel_Y)
	'---------------------------------------------------------------------------------------

	'-------------Shape Panel----------------------------------------------------------
	shape_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Tool_Panel_H)
	Gui_TabGroup_Tab_AddObject(tool_tabGroup, tool_shapeTab, shape_panel)

	shape_listBox = Gui_CreateListBox(Int(MAIN_WINDOW_WIDTH/8)-8, Tool_Panel_H/2)
	Gui_Panel_AddObject(shape_panel, shape_listBox, 2, 2)

	shape_type_label = Gui_CreateLabel("Type", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(shape_panel, shape_type_label, Int(MAIN_WINDOW_WIDTH/8)+4, 4)

	shape_type_selection = Gui_CreateDropDown(GUI_FONT_W*14, GUI_FONT_H+2)
	Gui_Panel_AddObject(shape_panel, shape_type_selection, Int(MAIN_WINDOW_WIDTH/8) + GUI_FONT_W*4 + 5, 4)

	shape_rect = Gui_DropDown_AddItem(shape_type_selection, "Rectangle")
	shape_line = Gui_DropDown_AddItem(shape_type_selection, "Line")

	shape_positionX_label = Gui_CreateLabel("PosX", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(shape_panel, shape_positionX_label, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H+2) + 12)

	shape_positionX_field = Gui_CreateTextField(GUI_FONT_W* 10, GUI_FONT_H+1)
	Gui_Panel_AddObject(shape_panel, shape_positionX_field, Int(MAIN_WINDOW_WIDTH/8)+4+(GUI_FONT_W*5)+8, 4 + (GUI_FONT_H+2) + 12)

	shape_positionY_label = Gui_CreateLabel("PosY", GUI_FONT_W*4, GUI_FONT_H)
	Gui_Panel_AddObject(shape_panel, shape_positionY_label, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H*3+2) + 12)

	shape_positionY_field = Gui_CreateTextField(GUI_FONT_W* 10, GUI_FONT_H+1)
	Gui_Panel_AddObject(shape_panel, shape_positionY_field, Int(MAIN_WINDOW_WIDTH/8)+4+(GUI_FONT_W*5)+8, 4 + (GUI_FONT_H*3+2) + 12)

	shape_parameter1_label = Gui_CreateLabel("Param1", GUI_FONT_W*6, GUI_FONT_H)
	Gui_Panel_AddObject(shape_panel, shape_parameter1_label, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H*5+2) + 12)

	shape_parameter1_field = Gui_CreateTextField(GUI_FONT_W* 10, GUI_FONT_H+1)
	Gui_Panel_AddObject(shape_panel, shape_parameter1_field, Int(MAIN_WINDOW_WIDTH/8)+4+(GUI_FONT_W*5)+8, 4 + (GUI_FONT_H*5+2) + 12)

	shape_parameter2_label = Gui_CreateLabel("Param2", GUI_FONT_W*6, GUI_FONT_H)
	Gui_Panel_AddObject(shape_panel, shape_parameter2_label, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H*7+2) + 12)

	shape_parameter2_field = Gui_CreateTextField(GUI_FONT_W* 10, GUI_FONT_H+1)
	Gui_Panel_AddObject(shape_panel, shape_parameter2_field, Int(MAIN_WINDOW_WIDTH/8)+4+(GUI_FONT_W*5)+8, 4 + (GUI_FONT_H*7+2) + 12)

	shape_addButton = Gui_CreateButton("Add Shape", GUI_FONT_W*16, GUI_FONT_H+2)
	Gui_Panel_AddObject(shape_panel, shape_addButton, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H*9+2) + 12)

	shape_removeButton = Gui_CreateButton("Remove Shape", GUI_FONT_W*16, GUI_FONT_H+2)
	Gui_Panel_AddObject(shape_panel, shape_removeButton, Int(MAIN_WINDOW_WIDTH/8)+4, 4 + (GUI_FONT_H*11+2) + 12)

	Gui_Window_AddPanel(main_window, shape_panel, 1, Tool_Panel_Y)
	'---------------------------------------------------------------------------------------

	'stage panel
	stageView_panel = Gui_CreatePanel(650, 520)

	stageView_layerSelection = Gui_CreateDropDown(GUI_FONT_W*16, GUI_FONT_H+2)
	Gui_Panel_AddObject(stageView_panel, stageView_layerSelection, 4, 4)

	stageView_layer0 = Gui_DropDown_AddItem(stageView_layerSelection, "Layer 0")
	stageView_layer1 = Gui_DropDown_AddItem(stageView_layerSelection, "Layer 1")
	stageView_layer2 = Gui_DropDown_AddItem(stageView_layerSelection, "Layer 2")
	stageView_layer3 = Gui_DropDown_AddItem(stageView_layerSelection, "Layer 3")
	stageView_layer4 = Gui_DropDown_AddItem(stageView_layerSelection, "Layer 4")

	'stageView_Surface_w = Int(MAIN_WINDOW_WIDTH/4*3)-12
	'stageView_Surface_h = TOOL_AREA_HEIGHT-(GUI_FONT_H*2)-16
	stageView_Surface_w = 640
	stageView_Surface_h = 480
	STAGE_SCREEN_WIDTH = stageView_Surface_w
	STAGE_SCREEN_HEIGHT = stageView_Surface_h
	stageView_scroll_speed = 4
	stageView_Surface = Gui_CreateSurface(stageView_Surface_w, stageView_Surface_h)
	Gui_Panel_AddObject(stageView_panel, stageView_surface, 2, GUI_FONT_H *2 + 6)

	Gui_Window_AddPanel(main_window, stageView_panel, Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y)
	
	'Stage Position Panel
	'Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y
	stagePos_panel = Gui_CreatePanel(650, MAIN_WINDOW_HEIGHT - (TOOL_AREA_Y+526))
	
	stagePos_stageCoord_label = Gui_CreateLabel("STAGE POS", GUI_FONT_W*10, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_label, 8, 4)
	
	stagePos_stageCoord_X_label = Gui_CreateLabel("Pos X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_X_label, 8, 40)
	
	stagePos_stageCoord_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_X_field, 8 + GUI_FONT_W*6 + 4, 40)
	
	stagePos_stageCoord_Y_label = Gui_CreateLabel("Pos Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Y_label, 8, 40 + GUI_FONT_H+2)
	
	stagePos_stageCoord_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Y_field, 8 + GUI_FONT_W*6 + 4, 40 + GUI_FONT_H+2)
	
	stagePos_stageCoord_Tile_X_label = Gui_CreateLabel("Tile X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Tile_X_label, 8, 80)
	
	stagePos_stageCoord_Tile_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Tile_X_field, 8 + GUI_FONT_W*6 + 4, 80)
	
	stagePos_stageCoord_Tile_Y_label = Gui_CreateLabel("Tile Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Tile_Y_label, 8, 80 + GUI_FONT_H+2)
	
	stagePos_stageCoord_Tile_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_stageCoord_Tile_Y_field, 8 + GUI_FONT_W*6 + 4, 80 + GUI_FONT_H+2)
	
	
	stagePos_screenCoord_label = Gui_CreateLabel("SCREEN POS", GUI_FONT_W*11, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_label, 8 + GUI_FONT_W*20, 4)
	
	stagePos_screenCoord_X_label = Gui_CreateLabel("Pos X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_X_label, 8 + GUI_FONT_W*20, 40)
	
	stagePos_screenCoord_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_X_field, 8 + GUI_FONT_W*20 + GUI_FONT_W*6 + 4, 40)
	
	stagePos_screenCoord_Y_label = Gui_CreateLabel("Pos Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Y_label, 8 + GUI_FONT_W*20, 40 + GUI_FONT_H+2)
	
	stagePos_screenCoord_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Y_field, 8 + GUI_FONT_W*20 + GUI_FONT_W*6 + 4, 40 + GUI_FONT_H+2)
	
	stagePos_screenCoord_Tile_X_label = Gui_CreateLabel("Tile X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Tile_X_label, 8 + GUI_FONT_W*20, 80)
	
	stagePos_screenCoord_Tile_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Tile_X_field, 8 + GUI_FONT_W*20 + GUI_FONT_W*6 + 4, 80)
	
	stagePos_screenCoord_Tile_Y_label = Gui_CreateLabel("Tile Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Tile_Y_label, 8 + GUI_FONT_W*20, 80 + GUI_FONT_H+2)
	
	stagePos_screenCoord_Tile_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_screenCoord_Tile_Y_field, 8 + GUI_FONT_W*20 + GUI_FONT_W*6 + 4, 80 + GUI_FONT_H+2)
	
	
	stagePos_cameraView_label = Gui_CreateLabel("CAMERA VIEW", GUI_FONT_W*11, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_label, 8 + GUI_FONT_W*40, 4)
	
	stagePos_cameraView_X_label = Gui_CreateLabel("Pos X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_X_label, 8 + GUI_FONT_W*40, 40)
	
	stagePos_cameraView_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_X_field, 8 + GUI_FONT_W*40 + GUI_FONT_W*6 + 4, 40)
	
	stagePos_cameraView_Y_label = Gui_CreateLabel("Pos Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Y_label, 8 + GUI_FONT_W*40, 40 + GUI_FONT_H+2)
	
	stagePos_cameraView_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Y_field, 8 + GUI_FONT_W*40 + GUI_FONT_W*6 + 4, 40 + GUI_FONT_H+2)
	
	stagePos_cameraView_Tile_X_label = Gui_CreateLabel("Tile X", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Tile_X_label, 8 + GUI_FONT_W*40, 80)
	
	stagePos_cameraView_Tile_X_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Tile_X_field, 8 + GUI_FONT_W*40 + GUI_FONT_W*6 + 4, 80)
	
	stagePos_cameraView_Tile_Y_label = Gui_CreateLabel("Tile Y", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Tile_Y_label, 8 + GUI_FONT_W*40, 80 + GUI_FONT_H+2)
	
	stagePos_cameraView_Tile_Y_field = Gui_CreateDynamicTextField(GUI_FONT_W*10, GUI_FONT_H)
	Gui_Panel_AddObject(stagePos_panel, stagePos_cameraView_Tile_Y_field, 8 + GUI_FONT_W*40 + GUI_FONT_W*6 + 4, 80 + GUI_FONT_H+2)
	
	Gui_Window_AddPanel(main_window, stagePos_panel, Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y + Gui_Panel_H[Gui_Element_Index[stageView_panel]]+2)
	
	'Display Settings
	displaySettings_x = Gui_Panel_X[ Gui_Element_Index[stageView_panel]] + Gui_Panel_W[ Gui_Element_Index[stageView_panel]] + 2
	displaySettings_y = TOOL_AREA_Y
	displaySettings_w = MAIN_WINDOW_WIDTH - displaySettings_x - 2
	displaySettings_h = MAIN_WINDOW_HEIGHT - TOOL_AREA_Y - 4
	displaySettings_panel = Gui_CreatePanel( displaySettings_w, displaySettings_h)
	
	ds_main_x = GUI_FONT_W*8+4
	ds_actor_x = ds_main_x + GUI_FONT_W*8
	ds_shape_x = ds_actor_x + GUI_FONT_W*8
	ds_title_y = 20
	
	displaySettings_layer_main_label = Gui_CreateLabel("MAIN", GUI_FONT_W*5, GUI_FONT_H+1)
	displaySettings_layer_actor_label = Gui_CreateLabel("ACTOR", GUI_FONT_W*6, GUI_FONT_H+1)
	displaySettings_layer_shape_label = Gui_CreateLabel("SHAPE", GUI_FONT_W*6, GUI_FONT_H+1)
	Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_main_label, ds_main_x, ds_title_y)
	Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_actor_label, ds_actor_x, ds_title_y)
	Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_shape_label, ds_shape_x, ds_title_y)
	
	For i = 0 to MAX_LAYERS-1
		displaySettings_layer_label[i] = Gui_CreateLabel("Layer " + Str(i), GUI_FONT_W*7, GUI_FONT_H+1)
		displaySettings_layer_main_checkbox[i] = Gui_CreateCheckBox(GUI_FONT_H+1, GUI_FONT_H+1)
		displaySettings_layer_actor_checkbox[i] = Gui_CreateCheckBox(GUI_FONT_H+1, GUI_FONT_H+1)
		displaySettings_layer_shape_checkbox[i] = Gui_CreateCheckBox(GUI_FONT_H+1, GUI_FONT_H+1)
		y = (ds_title_y+GUI_FONT_H+8) + (i*(GUI_FONT_H+1)) + (i*10)
		
		Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_label[i], 8, y)
		Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_main_checkbox[i], ds_main_x, y)
		Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_actor_checkbox[i], ds_actor_x, y)
		Gui_Panel_AddObject(displaySettings_panel, displaySettings_layer_shape_checkbox[i], ds_shape_x, y)
		
		Gui_CheckBox_SetValue(displaySettings_layer_main_checkbox[i], True)
		Gui_CheckBox_SetValue(displaySettings_layer_actor_checkbox[i], True)
		Gui_CheckBox_SetValue(displaySettings_layer_shape_checkbox[i], True)
	Next
	
	Gui_Window_AddPanel(main_window, displaySettings_panel, displaySettings_x, displaySettings_y)	

	'Add info_tabGroup, tool_tabGroup, and the stageView_panel to the main_tabGroup_stageTab
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_stageTab, info_tabGroup)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_stageTab, tool_tabGroup)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_stageTab, stageView_panel)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_stageTab, stagePos_panel)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_stageTab, displaySettings_panel)

	'Tile Tab
	tileMain_panel = Gui_CreatePanel(MAIN_WINDOW_WIDTH-4, TOOL_AREA_HEIGHT-4)
	Gui_Window_AddPanel(main_window, tileMain_panel, 2, TOOL_AREA_Y)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_tileTab, tileMain_panel)

	tileMain_tileSheetSelection = Gui_CreateDropDown(GUI_FONT_W*20, GUI_FONT_H+2)
	
	For i = 0 to MAX_TILESETS-1
		Gui_DropDown_AddItem(tileMain_tileSheetSelection, "Tileset " + Str$(i))
	Next
	
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileSheetSelection, GUI_FONT_W, GUI_FONT_H)

	tileMain_loadButton = Gui_CreateButton("Load TileSet", GUI_FONT_W*18, GUI_FONT_H+8)
	Gui_Panel_AddObject(tileMain_panel, tileMain_loadButton, GUI_FONT_W*22, GUI_FONT_H)

	tileMain_saveButton = Gui_CreateButton("Save TileSet", GUI_FONT_W*18, GUI_FONT_H+8)
	Gui_Panel_AddObject(tileMain_panel, tileMain_saveButton, GUI_FONT_W*40+2, GUI_FONT_H)

	tileMain_tileSheetSurface_w = 640
	tileMain_tileSheetSurface_h = 480
	tileMain_tileSheetSurface = Gui_CreateSurface(tileMain_tileSheetSurface_w, tileMain_tileSheetSurface_h)
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileSheetSurface, GUI_FONT_W, GUI_FONT_H*3 + 4)

	tileMain_frameSlide = Gui_CreateImageSlide(512, 64, 64, 64)
	Gui_Panel_AddObject(tileMain_panel, tileMain_frameSlide, GUI_FONT_W+64, GUI_FONT_H*3 + 500)
	
	For i = 0 to MAX_TILE_FRAMES-1
		tileMain_frameSlide_frame[i] = Gui_CreateImageClip(0, 32, 32, 32, 32)
	Next

	tileMain_addFrameButton = Gui_CreateButton("+",32, 32)
	Gui_Panel_AddObject(tileMain_panel, tileMain_addFrameButton, GUI_FONT_W+64, GUI_FONT_H*3 + 566)

	tileMain_removeFrameButton = Gui_CreateButton("-",32, 32)
	Gui_Panel_AddObject(tileMain_panel, tileMain_removeFrameButton, GUI_FONT_W+98, GUI_FONT_H*3 + 566)
	
	tileMain_setFrameButton = Gui_CreateButton("=",32, 32)
	Gui_Panel_AddObject(tileMain_panel, tileMain_setFrameButton, GUI_FONT_W+132, GUI_FONT_H*3 + 566)
	
	tileMain_previewImage = Gui_CreateEmptyImage(128, 128)
	tileMain_previewClip = Gui_CreateImageClip(tileMain_previewImage, 128, 128, 128, 128)
	Gui_Panel_AddObject(tileMain_panel, tileMain_previewClip, GUI_FONT_W + 640 + GUI_FONT_W*8, GUI_FONT_H*3+4)

	tileMain_playButton = Gui_CreateButton("PLAY", 63, 32)
	Gui_Panel_AddObject(tileMain_panel, tileMain_playButton, GUI_FONT_W + 640 + GUI_FONT_W*8, GUI_FONT_H*3 + 136)

	tileMain_stopButton = Gui_CreateButton("STOP", 63, 32)
	Gui_Panel_AddObject(tileMain_panel, tileMain_stopButton, GUI_FONT_W + 640 + GUI_FONT_W*8 + 64, GUI_FONT_H*3 + 136)

	tileMain_tileIndexLabel = Gui_CreateLabel("Tile Index", GUI_FONT_W*11, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileIndexLabel, GUI_FONT_W + 640 + GUI_FONT_W*8, 180 + GUI_FONT_H*5)

	tileMain_tileIndexField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileIndexField, GUI_FONT_W + 640 + GUI_FONT_W*18, 180 + GUI_FONT_H*5)

	tileMain_tileFPSLabel = Gui_CreateLabel("Tile FPS", GUI_FONT_W*11, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileFPSLabel, GUI_FONT_W + 640 + GUI_FONT_W*8, 180 + GUI_FONT_H*6 + 4)

	tileMain_tileFPSField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_tileFPSField, GUI_FONT_W + 640 + GUI_FONT_W*18, 180 + GUI_FONT_H*6 + 4)

	tileMain_frameCountLabel = Gui_CreateLabel("Frame Count", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_frameCountLabel, GUI_FONT_W + 640 + GUI_FONT_W*8, 180 + GUI_FONT_H*7 + 8)

	tileMain_frameCountField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(tileMain_panel, tileMain_frameCountField, GUI_FONT_W + 640 + GUI_FONT_W*18, 180 + GUI_FONT_H*7 + 8)

	'Sprite Tab

	'sprite_tabGroup
	sprite_tabGroup = Gui_CreateTabGroup(Int(MAIN_WINDOW_WIDTH/4*3)-6,  Int(MAIN_WINDOW_HEIGHT/20))
	sprite_tabGroup_animationTab = Gui_TabGroup_AddTab(sprite_tabGroup, "Animations")
	sprite_tabGroup_boundsTab = Gui_TabGroup_AddTab(sprite_tabGroup, "Bounds")
	Gui_Window_AddTabGroup(main_window, sprite_tabGroup, Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_spriteTab, sprite_tabGroup)

	'Sprite Control
	spriteMain_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Int(GUI_FONT_H*2))

	spriteMain_newButton = Gui_CreateButton("New Sprite", GUI_FONT_W*12, GUI_FONT_H+2)
	Gui_Panel_AddObject(spriteMain_panel, spriteMain_newButton, 4, 4)

	spriteMain_saveButton = Gui_CreateButton("Save Sprite", GUI_FONT_W*12, GUI_FONT_H+2)
	Gui_Panel_AddObject(spriteMain_panel, spriteMain_saveButton, 4 + GUI_FONT_W*12 + 2, 4)

	spriteMain_loadButton = Gui_CreateButton("Load Sprite", GUI_FONT_W*12, GUI_FONT_H+2)
	Gui_Panel_AddObject(spriteMain_panel, spriteMain_loadButton, 4 + GUI_FONT_W*12*2 + 4, 4)

	Gui_Window_AddPanel(main_window, spriteMain_panel, 2, TOOL_AREA_Y)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_spriteTab, spriteMain_panel)

	'Sprite Info
	spriteInfo_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, Int(TOOL_AREA_HEIGHT/3 - 4) - Int(MAIN_WINDOW_HEIGHT/10) - Int(GUI_FONT_H*2) - 2)

	spriteInfo_nameLabel = Gui_CreateLabel("Sprite Name", GUI_FONT_W * 10, GUI_FONT_H + 1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_nameLabel, 2, 2)

	spriteInfo_nameField = Gui_CreateTextField(GUI_FONT_W * 16, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_nameField, GUI_FONT_W*11 + 4, 2)

	spriteInfo_frameWidthLabel = Gui_CreateLabel("Frame Width", GUI_FONT_W * 11, GUI_FONT_H + 1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_frameWidthLabel, 2, GUI_FONT_H*3 + 2)

	spriteInfo_frameWidthField = Gui_CreateTextField(GUI_FONT_W * 16, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_frameWidthField, GUI_FONT_W*11 + 4, GUI_FONT_H*3 + 2)

	spriteInfo_frameHeightLabel = Gui_CreateLabel("Frame Height", GUI_FONT_W * 11, GUI_FONT_H + 1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_frameHeightLabel, 2, GUI_FONT_H*4 + 4)

	spriteInfo_frameHeightField = Gui_CreateTextField(GUI_FONT_W * 16, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteInfo_panel, spriteInfo_frameHeightField, GUI_FONT_W*11 + 4, GUI_FONT_H*4 + 4)

	Gui_Window_AddPanel(main_window, spriteInfo_panel, 2, TOOL_AREA_Y + GUI_FONT_H*2 + 2)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_spriteTab, spriteInfo_panel)

	'Sprite In Stage List
	spriteStageList_panel_y = TOOL_AREA_Y + (Int(TOOL_AREA_HEIGHT/3 - 4) - Int(MAIN_WINDOW_HEIGHT/10)) + 2
	spriteStageList_panel_h = MAIN_WINDOW_HEIGHT - ( Gui_Panel_Y[ Gui_Element_Index[spriteInfo_panel] ] + Gui_Panel_H[ Gui_Element_Index[spriteInfo_panel] ]) - 4

	spriteStageList_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4)-2, spriteStageList_panel_h)

	spriteStageList_listBox = Gui_CreateListBox(Int(MAIN_WINDOW_WIDTH/4)- GUI_FONT_W*14, spriteStageList_panel_h - GUI_FONT_H*12)
	Gui_Panel_AddObject(spriteStageList_panel, spriteStageList_listBox, GUI_FONT_W*4, GUI_FONT_H)

	spriteStageList_addButton = Gui_CreateButton("Add Current Sprite", Int(MAIN_WINDOW_WIDTH/4) - GUI_FONT_W*14, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteStageList_panel, spriteStageList_addButton, GUI_FONT_W*4, GUI_FONT_H + (spriteStageList_panel_h - GUI_FONT_H*12) + (GUI_FONT_H) + 2)

	spriteStageList_addFromFileButton = Gui_CreateButton("Add From File", Int(MAIN_WINDOW_WIDTH/4) - GUI_FONT_W*14, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteStageList_panel, spriteStageList_addFromFileButton, GUI_FONT_W*4, GUI_FONT_H + (spriteStageList_panel_h - GUI_FONT_H*12) + (GUI_FONT_H*2) + 6)

	spriteStageList_editButton = Gui_CreateButton("Edit Sprite", Int(MAIN_WINDOW_WIDTH/4) - GUI_FONT_W*14, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteStageList_panel, spriteStageList_editButton, GUI_FONT_W*4, GUI_FONT_H + (spriteStageList_panel_h - GUI_FONT_H*12) + (GUI_FONT_H*3) + 10)

	spriteStageList_removeButton = Gui_CreateButton("Remove Sprite", Int(MAIN_WINDOW_WIDTH/4) - GUI_FONT_W*14, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteStageList_panel, spriteStageList_removeButton, GUI_FONT_W*4, GUI_FONT_H + (spriteStageList_panel_h - GUI_FONT_H*12) + (GUI_FONT_H*4) + 14)

	Gui_Window_AddPanel(main_window, spriteStageList_panel, 2, spriteStageList_panel_y)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_spriteTab, spriteStageList_panel)

	'Sprite Animation Tab
	spriteAnimation_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4*3)-6,  TOOL_AREA_HEIGHT - Int(MAIN_WINDOW_HEIGHT/20) - 6 )

	spriteAnimation_animationListBox = Gui_CreateListBox(Int(GUI_FONT_W*20), Int(GUI_FONT_H*32))
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_animationListBox, GUI_FONT_W, GUI_FONT_H)

	spriteAnimation_newAnimationButton = Gui_CreateButton("New Animation", Int(GUI_FONT_W*20), GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_newAnimationButton, GUI_FONT_W, GUI_FONT_H + Int(GUI_FONT_H*34) + 2) 

	spriteAnimation_removeAnimationButton = Gui_CreateButton("Remove Animation", Int(GUI_FONT_W*20), GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_removeAnimationButton, GUI_FONT_W, GUI_FONT_H + Int(GUI_FONT_H*36) + 4) 

	spriteAnimation_spriteSheetSurface_w = 512
	spriteAnimation_spriteSheetSurface_h = Int(GUI_FONT_H*32)
	spriteAnimation_spriteSheetSurface = Gui_CreateSurface(spriteAnimation_spriteSheetSurface_w, spriteAnimation_spriteSheetSurface_h)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_spriteSheetSurface, GUI_FONT_W + (GUI_FONT_W*20) + 32, GUI_FONT_H)

	spriteAnimation_frameSlide = Gui_CreateImageSlide(512, 64, 64, 64)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_frameSlide, GUI_FONT_W + (GUI_FONT_W*20) + 32, GUI_FONT_H*35 + 2)
	
	for i = 0 to MAX_SPRITE_ANIMATION_FRAMES-1
		spriteAnimation_frameSlide_frame[i] = Gui_CreateImageClip(0, 64, 64, 32, 32)
	Next

	spriteAnimation_addFrameButton = Gui_CreateButton("+", 32, 32)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_addFrameButton, GUI_FONT_W + (GUI_FONT_W*20) + 32, GUI_FONT_H*35 + 68)

	spriteAnimation_removeFrameButton = Gui_CreateButton("-", 32, 32)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_removeFrameButton, GUI_FONT_W + (GUI_FONT_W*20) + 66, GUI_FONT_H*35 + 68)

	spriteAnimation_setFrameButton = Gui_CreateButton("=", 32, 32)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_setFrameButton, GUI_FONT_W + (GUI_FONT_W*20) + 102, GUI_FONT_H*35 + 68)
	
	spriteAnimation_previewImage = Gui_CreateEmptyImage(128 , 128)
	spriteAnimation_previewClip = Gui_CreateImageClip(spriteAnimation_previewImage, 128, 128, 128, 128)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_previewClip, GUI_FONT_W + (GUI_FONT_W*20) + 580, GUI_FONT_H)

	spriteAnimation_previewPlayButton = Gui_CreateButton("PLAY",62, GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_previewPlayButton, GUI_FONT_W + (GUI_FONT_W*20) + 580, GUI_FONT_H + 130)

	spriteAnimation_previewStopButton = Gui_CreateButton("STOP",62, GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_previewStopButton, GUI_FONT_W + (GUI_FONT_W*20) + 580 + 64, GUI_FONT_H + 130)

	spriteAnimation_nameLabel = Gui_CreateLabel("Anim Name", GUI_FONT_W*15, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_nameLabel, GUI_FONT_W + (GUI_FONT_W*20) + 580, GUI_FONT_H + 130 + (GUI_FONT_H*6) + 2)

	spriteAnimation_nameField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_nameField, GUI_FONT_W + (GUI_FONT_W*20) + 580 + GUI_FONT_W*9, GUI_FONT_H + 130 + (GUI_FONT_H*6) + 2)

	spriteAnimation_FPSLabel = Gui_CreateLabel("Anim FPS", GUI_FONT_W*15, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_FPSLabel, GUI_FONT_W + (GUI_FONT_W*20) + 580, GUI_FONT_H + 130 + (GUI_FONT_H*7) + 8)

	spriteAnimation_FPSField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteAnimation_panel, spriteAnimation_FPSField, GUI_FONT_W + (GUI_FONT_W*20) + 580 + GUI_FONT_W*9, GUI_FONT_H + 130 + (GUI_FONT_H*7) + 8)

	Gui_Window_AddPanel(main_window, spriteAnimation_panel, Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y + Int(MAIN_WINDOW_HEIGHT/20) + 2)
	Gui_TabGroup_Tab_AddObject(sprite_tabGroup, sprite_tabGroup_animationTab, spriteAnimation_panel)
	Gui_TabGroup_Tab_AddObject(main_tabGroup, main_tabGroup_spriteTab, spriteAnimation_panel)

	'Sprite Bounds Tab
	spriteBounds_panel = Gui_CreatePanel(Int(MAIN_WINDOW_WIDTH/4*3)-6,  TOOL_AREA_HEIGHT - Int(MAIN_WINDOW_HEIGHT/20) - 6 )

	spriteBounds_spriteSheetSurface_w = 512
	spriteBounds_spriteSheetSurface_h = 512
	spriteBounds_spriteSheetSurface = Gui_CreateSurface(spriteBounds_spriteSheetSurface_w, spriteBounds_spriteSheetSurface_h)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_spriteSheetSurface, GUI_FONT_W, GUI_FONT_H)

	spriteBounds_indexLabel = Gui_CreateLabel("Frame Index", GUI_FONT_W*11, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_indexLabel,  512 + GUI_FONT_W*4, GUI_FONT_H*4+6)

	spriteBounds_indexField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_indexField, 512 + GUI_FONT_W*15, GUI_FONT_H*4 + 6)

	spriteBounds_shapeLabel = Gui_CreateLabel("Sprite Shape", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_shapeLabel,  512 + GUI_FONT_W*4, GUI_FONT_H*2)

	spriteBounds_shapeSelection = Gui_CreateDropDown(GUI_FONT_W*20, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_shapeSelection,  512 + GUI_FONT_W*15, GUI_FONT_H*2)
	
	spriteBounds_shape_rect = Gui_DropDown_AddItem(spriteBounds_shapeSelection, "Rectangle")
	spriteBounds_shape_circle = Gui_DropDown_AddItem(spriteBounds_shapeSelection, "Circle")

	spriteBounds_boundXLabel = Gui_CreateLabel("Bound X", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_boundXLabel,  512 + GUI_FONT_W*4, GUI_FONT_H*6 + 2)

	spriteBounds_boundXField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_boundXField, 512 + GUI_FONT_W*15, GUI_FONT_H*6 + 2)

	spriteBounds_boundYLabel = Gui_CreateLabel("Bound Y", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_boundYLabel,  512 + GUI_FONT_W*4, GUI_FONT_H*7 + 6)

	spriteBounds_boundYField = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_boundYField, 512 + GUI_FONT_W*15, GUI_FONT_H*7 + 6)

	spriteBounds_param1Label = Gui_CreateLabel("Param 1", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_param1Label,  512 + GUI_FONT_W*4, GUI_FONT_H*8 + 10)

	spriteBounds_param1Field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_param1Field, 512 + GUI_FONT_W*15, GUI_FONT_H*8 + 10)

	spriteBounds_param2Label = Gui_CreateLabel("Param 2", GUI_FONT_W*13, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_param2Label,  512 + GUI_FONT_W*4, GUI_FONT_H*9 + 14)

	spriteBounds_param2Field = Gui_CreateTextField(GUI_FONT_W*12, GUI_FONT_H+1)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_param2Field, 512 + GUI_FONT_W*15, GUI_FONT_H*9 + 14)

	spriteBounds_frameViewButton = Gui_CreateButton("Frame View", 254, GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_frameViewButton, GUI_FONT_W, 512 + GUI_FONT_H+2)

	spriteBounds_sheetViewButton = Gui_CreateButton("SpriteSheet View", 254, GUI_FONT_H*2)
	Gui_Panel_AddObject(spriteBounds_panel, spriteBounds_sheetViewButton, GUI_FONT_W + 256, 512 + GUI_FONT_H+2)

	Gui_Window_AddPanel(main_window, spriteBounds_panel, Int(MAIN_WINDOW_WIDTH/4) + 2, TOOL_AREA_Y + Int(MAIN_WINDOW_HEIGHT/20) + 2)
	Gui_TabGroup_Tab_AddObject(sprite_tabGroup, sprite_tabGroup_boundsTab, spriteBounds_panel)

End Function

Function Editor_NewStage()
	System("rcbasic editor.cbc top_menu_newButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return 0
	End If
	
	s_name$ = Dlg_data$[0]
	s_width = Int(Val(Dlg_data$[1]))
	s_height = Int(Val(Dlg_data$[2]))
	s_tile_width = Int(Val(Dlg_data$[3]))
	s_tile_height = Int(Val(Dlg_data$[4]))
	NewStage(s_name$, s_width, s_height, s_tile_width, s_tile_height)
	
	'Stage Info
	Gui_TextField_SetValue(stageInfo_nameField, s_name$)
	Gui_TextField_SetValue(stageInfo_widthField, Str$(s_width))
	Gui_TextField_SetValue(stageInfo_heightField, Str$(s_height))
	
	'Layer Settings
	For i = 0 to MAX_LAYERS-1
		Gui_DropDown_SetSelectedItem(layerInfo_typeSelect[i], Stage_Layer_Type[i])
		Gui_CheckBox_SetValue(layerInfo_colDetCheckBox[i], Stage_Layer_ColDet[i])
	Next
	
	'Tile Selector
	Gui_DropDown_SetSelectedItem(tileSelect_sheetSelect, 0)
	Gui_Surface_Clear(tileSelect_tileSheet_Surface)
	tileSelect_tileSheet_offset_x = 0
	tileSelect_tileSheet_offset_y = 0
	tileSelect_tileSheet_selected_x = 0
	tileSelect_tileSheet_selected_y = 0
	tileSelect_tileSheet_selected_index = 0
	Gui_Surface_SetColor(tileSelect_tileSheet_Surface, tileSelect_selectedTile_color)
	Gui_Surface_Rect(tileSelect_tileSheet_Surface, tileSelect_tileSheet_selected_x, tileSelect_tileSheet_selected_y, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
	Gui_Surface_Update(tileSelect_tileSheet_Surface)
	
	'Setting the Active Layer to 0
	Gui_DropDown_SetSelectedItem(stageView_layerSelection, 0)
	
	'Clear StageView Surface
	
	
	'Drawing the background surface in the background tab
	Gui_Surface_SetClearColor(background_surface, RGB(0, 0, 0))
	Gui_Surface_Clear(background_surface)
	Gui_Surface_Update(background_surface)
	
	'Set default Background Settings
	For i = 0 to MAX_LAYERS-1
		ClearBkg(i)
		Bkg_SetAlpha(i, 255)
		Bkg_SetAngle(i, 0)
		Bkg_SetBlit(i, 0, 0, 0, 0)
		Bkg_SetZoom(i, 1, 1)
		Bkg_SetType(i, STAGE_LAYER_BKG_TYPE_IMAGE)
		Bkg_SetFlag(i, STAGE_LAYER_BKG_FLAG_NONE)
	Next
	
	'Shapes
	Gui_ListBox_Clear(shape_listBox)
	Gui_TextField_SetValue(shape_positionX_field, "0")
	Gui_TextField_SetValue(shape_positionY_field, "0")
	Gui_TextField_SetValue(shape_parameter1_field, "0")
	Gui_TextField_SetValue(shape_parameter2_field, "0")
	Gui_ListBox_SetSelectedItem(shape_listBox, 0)
	Gui_DropDown_SetSelectedItem(shape_type_selection, 0)
	
	'Actors and Sprites
	Gui_ListBox_Clear(actor_listBox)
	Gui_ListBox_Update(actor_listBox)
	Gui_TextField_SetValue(actor_name_field, " ")
	Gui_TextField_SetValue(actor_positionX_field, "0")
	Gui_TextField_SetValue(actor_positionY_field, "0")
	Gui_TextField_SetValue(actor_layer_field, "-1")
	Gui_ImageClip_Clear(actor_previewClip)
	Gui_ImageClip_Clear(spriteAnimation_previewClip)
	Gui_ImageSlide_Clear(spriteAnimation_frameSlide)
	Gui_TextField_SetValue(spriteInfo_nameField, " ")
	Gui_TextField_SetValue(spriteInfo_frameWidthField, " ")
	Gui_TextField_SetValue(spriteInfo_frameHeightField, " ")
	Gui_TextField_SetValue(spriteAnimation_nameField, " ")
	Gui_TextField_SetValue(spriteAnimation_FPSField, " ")
	Gui_TextField_SetValue(spriteBounds_indexField, " ")
	Gui_TextField_SetValue(spriteBounds_boundXField, " ")
	Gui_TextField_SetValue(spriteBounds_boundYField, " ")
	Gui_TextField_SetValue(spriteBounds_param1Field, " ")
	Gui_TextField_SetValue(spriteBounds_param2Field, " ")
	Gui_TextField_SetValue(tileMain_tileIndexField, " ")
	Gui_TextField_SetValue(tileMain_tileFPSField, " ")
	Gui_TextField_SetValue(tileMain_frameCountField, " ")
	Gui_DropDown_SetSelectedItem(tileMain_tileSheetSelection, 0)
	Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, 0)
	actor_database_count = 0
	stage_database_count = 0
	
	Gui_ListBox_Clear(spriteAnimation_animationListBox)
	Gui_ListBox_Update(spriteAnimation_animationListBox)
	
	Gui_ListBox_Clear(spriteStageList_listBox)
	Gui_ListBox_Update(spriteStageList_listBox)
	
	Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
	Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
	
	Gui_Surface_Clear(spriteBounds_spriteSheetSurface)
	Gui_Surface_Update(spriteBounds_spriteSheetSurface)
	
	'Tile Main Tab
	Gui_DropDown_SetSelectedItem(tileMain_tileSheetSelection, 0)
	Gui_TextField_SetValue(tileMain_tileIndexField, "0")
	Gui_TextField_SetValue(tileMain_tileFPSField, "0")
	Gui_Surface_Clear(tileMain_tileSheetSurface)
	Gui_Surface_Update(tileMain_tileSheetSurface)
	TileMain_Current_Tileset = 0
	tileMain_tileSheet_selected_index = 0
	tileMain_tileSheet_selected_x = 0
	tileMain_tileSheet_selected_y = 0
	Gui_ImageSlide_Clear(tileMain_frameSlide)
	For i = 0 to MAX_TILE_FRAMES-1
		Gui_ImageClip_SetSource(tileMain_frameSlide_frame[i], Stage_Tileset_Image[TileMain_Current_Tileset])
	Next
	
	Return True
End Function

Function Editor_SaveStage()
	System("rcbasic editor.cbc top_menu_saveButton " + Gui_TextField_GetValue$(stageInfo_nameField))
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	For i = 0 to MAX_LAYERS-1
		Stage_Layer_ColDet[i] = Gui_CheckBox_GetValue(layerInfo_colDetCheckBox[i])
	Next
	SaveStage(Dlg_data$[0])
	Gui_TextField_SetValue(stageInfo_nameField, Mid(Dlg_data$[0], 0, FindLastOf(".",Dlg_data$[0])) )
	Return True
End Function

Function Editor_Bkg_LoadImage()
	System("rcbasic editor.cbc bkg_loadImageButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	If Not LoadBkg(Current_Layer, Dlg_data$[0]) Then
		Return False
	End If
	Gui_Surface_Clear(background_surface)
	Dim w
	Dim h
	GetImageSize(Stage_Layer_Bkg_Image[Current_Layer], w, h)
	Gui_Surface_DrawImage_Blit_Ex(background_surface, Stage_Layer_Bkg_Image[Current_Layer], 0, 0, background_surface_w, background_surface_h, 0, 0, w, h)
	Gui_Surface_Update(background_surface)
	Return True
End Function

Function Editor_Bkg_Properties()
	dim c_arg$
	c_arg$ = Str$(Stage_Layer_Bkg_Type[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_Flag[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_Alpha[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_ZoomX[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_ZoomY[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_Angle[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_BlitX[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_BlitY[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_BlitW[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_BlitH[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_Scroll_HSpeed[Current_Layer]) + " "
	c_arg$ = c_arg$ + Str$(Stage_Layer_Bkg_Scroll_VSpeed[Current_Layer]) + " "
	System("rcbasic editor.cbc bkg_propertiesButton " + c_arg$)
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	Bkg_SetType(Current_Layer, Val(Dlg_data$[0]))
	Bkg_SetFlag(Current_Layer, Val(Dlg_data$[1]))
	Bkg_SetAlpha(Current_Layer, Val(Dlg_data$[2]))
	Bkg_SetZoom(Current_Layer, Val(Dlg_data$[3]), Val(Dlg_data$[4]))
	Bkg_SetAngle(Current_Layer, Val(Dlg_data$[5]))
	Bkg_SetBlit(Current_Layer, Val(Dlg_data$[6]), Val(Dlg_data$[7]), Val(Dlg_data$[8]), Val(Dlg_data$[9]))
	Bkg_SetScrollSpeed(Current_Layer, Val(Dlg_data$[10]), Val(Dlg_data$[11]))
	
	If Stage_Layer_Bkg_Type[Current_Layer] = STAGE_LAYER_BKG_TYPE_SURFACE Then
		r = Stage_Layer_Bkg_Color[Current_Layer, 0]
		g = Stage_Layer_Bkg_Color[Current_Layer, 1]
		b = Stage_Layer_Bkg_Color[Current_Layer, 2]
		Gui_Surface_SetColor(background_surface, RGB(r, g, b))
		Gui_Surface_RectFill(background_surface, 0, 0, background_surface_w, background_surface_h)
		Gui_Surface_Update(background_surface)
	Else
		Gui_Surface_Clear(background_surface)
		Dim w
		Dim h
		If Stage_Layer_Bkg_ImageIsLoaded[Current_Layer] Then
			GetImageSize(Stage_Layer_Bkg_Image[Current_Layer], w, h)
			Gui_Surface_DrawImage_Blit_Ex(background_surface, Stage_Layer_Bkg_Image[Current_Layer], 0, 0, background_surface_w, background_surface_h, 0, 0, w, h)
			Gui_Surface_Update(background_surface)
		End If
	End If
	
	Return True
End Function

Function Editor_Bkg_SetColor()
	r$ = Str$(Stage_Layer_Bkg_Color[Current_Layer, 0])
	g$ = Str$(Stage_Layer_Bkg_Color[Current_Layer, 1])
	b$ = Str$(Stage_Layer_Bkg_Color[Current_Layer, 2])
	System("rcbasic editor.cbc bkg_setColorButton " + r$ + g$ + b$)
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	red = Val(Dlg_data$[0])
	green = Val(Dlg_data$[1])
	blue = Val(Dlg_data$[2])
	Bkg_SetClearColor(Current_Layer, red, green, blue)
	If Stage_Layer_Bkg_Type[Current_Layer] = STAGE_LAYER_BKG_TYPE_SURFACE Then
		Gui_Surface_SetColor(background_surface, RGB(red, green, blue))
		Gui_Surface_RectFill(background_surface, 0, 0, background_surface_w, background_surface_h)
		Gui_Surface_Update(background_surface)
	End If
	Return True
End Function

Function Editor_Bkg_ClearImage()
	ClearBkg(Current_Layer)
	Gui_Surface_Clear(background_surface)
	Gui_Surface_Update(background_surface)
End Function

Function Editor_SetLayer(layer_num)
	Current_Layer = layer_num
	
	'Background Tab
	If Stage_Layer_Bkg_Type[Current_Layer] = STAGE_LAYER_BKG_TYPE_SURFACE Then
		r = Stage_Layer_Bkg_Color[Current_Layer, 0]
		g = Stage_Layer_Bkg_Color[Current_Layer, 1]
		b = Stage_Layer_Bkg_Color[Current_Layer, 2]
		a = Stage_Layer_Bkg_Alpha[Current_Layer]
		Gui_Surface_Clear(background_surface)
		Gui_Surface_SetColor(background_surface, RGBA(r, g, b, a))
		Gui_Surface_RectFill(background_surface, 0, 0, background_surface_w, background_surface_h)
		Gui_Surface_Update(background_surface)
	Else
		Gui_Surface_Clear(background_surface)
		Dim w
		Dim h
		If Stage_Layer_Bkg_ImageIsLoaded[Current_Layer] Then
			GetImageSize(Stage_Layer_Bkg_Image[Current_Layer], w, h)
			Gui_Surface_DrawImage_Blit_Ex(background_surface, Stage_Layer_Bkg_Image[Current_Layer], 0, 0, background_surface_w, background_surface_h, 0, 0, w, h)
		End If
		Gui_Surface_Update(background_surface)
	End If
	
	'Shape Tab
	Gui_ListBox_Clear(shape_listBox)
	If Stage_Layer_Shape_Count[Current_Layer] > 0 Then
		For i = 0 to Stage_Layer_Shape_Count[Current_Layer]-1
			Dim item$
			Select Case Stage_Layer_Shape_Type[Current_Layer, i]
			Case SHAPE_TYPE_LINE
				item$ = "LINE:"
			Case SHAPE_TYPE_RECT
				item$ = "RECT:"
			End Select
			item$ = item$ + "(" + Str$(Stage_Layer_Shape_X[Current_Layer, i]) + ","
			item$ = item$ + Str$(Stage_Layer_Shape_Y[Current_Layer, i]) + ")-"
			item$ = item$ + "(" + Str$(Stage_Layer_Shape_Param[Current_Layer, i, 0]) + ","
			item$ = item$ + Str$(Stage_Layer_Shape_Param[Current_Layer, i, 1]) + ")"
			Gui_ListBox_AddItem(shape_listBox, item$)
		Next
	End If
	Gui_ListBox_SetSelectedItem(shape_listBox, 0)
	Current_Shape = 0
	Gui_ListBox_Update(shape_listBox)
	Select Case Stage_Layer_Shape_Type[Current_Layer, Current_Shape]
	Case SHAPE_TYPE_LINE
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
	Case SHAPE_TYPE_RECT
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
	End Select
	Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[Current_Layer, 0]))
	Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[Current_Layer, 0]))
	Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[Current_Layer, 0, 0]))
	Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[Current_Layer, 0, 1]))
End Function

Function Editor_tileSelect_Surface_Update(flag)
	Gui_Surface_Clear(tileSelect_tileSheet_Surface)
	src_w = 0
	src_h = 0
	If Stage_Tileset_ImageIsLoaded[TileSelect_Current_Tileset] Then
		GetImageSize(Stage_Tileset_Image[TileSelect_Current_Tileset], src_w, src_h)
		If tileSelect_tileSheet_Surface_w < src_w Then
			src_w = tileSelect_tileSheet_Surface_w
		End If
		If tileSelect_tileSheet_Surface_h < src_h Then
			src_h = tileSelect_tileSheet_Surface_h
		End If
		Gui_Surface_DrawImage_Blit(tileSelect_tileSheet_Surface, Stage_Tileset_Image[TileSelect_Current_Tileset], 0, 0, tileSelect_tileSheet_offset_x, tileSelect_tileSheet_offset_y, src_w, src_h)
	End If
	If flag Then
		Gui_Surface_Update(tileSelect_tileSheet_Surface)
	End If
End Function

Function Editor_tileSelect_Update()
	Editor_tileSelect_Surface_Update(0)
	mx = 0
	my = 0
	Gui_Surface_GetMouse(tileSelect_tileSheet_Surface, mx, my)
	Gui_Surface_SetColor(tileSelect_tileSheet_Surface, tileSelect_selectedTile_color)
	If Stage_Tileset_ImageIsLoaded[TileSelect_Current_Tileset] Then
		If Gui_Surface_MouseOver(tileSelect_tileSheet_Surface) Then
			Dim tx
			Dim ty
			tx = tileSelect_tileSheet_offset_x
			ty = tileSelect_tileSheet_offset_y
			If Key(K_LEFT) Then
				'scroll left
				tx = tileSelect_tileSheet_offset_x - tileSelect_scroll_speed
			End If
			If Key(K_RIGHT) Then
				'scroll right
				tx = tileSelect_tileSheet_offset_x + tileSelect_scroll_speed
			End If
			If Key(K_UP) Then
				'scroll up
				ty = tileSelect_tileSheet_offset_y - tileSelect_scroll_speed
			End If
			If Key(K_DOWN) Then
				'scroll down
				ty = tileSelect_tileSheet_offset_y + tileSelect_scroll_speed
			End If
			If (tx >= 0) And ((tx + tileSelect_tileSheet_Surface_w) < Stage_Tileset_Image_Width[TileSelect_Current_Tileset]) Then
				tileSelect_tileSheet_offset_x = tx
			End If
			If (ty >= 0) And ((ty + tileSelect_tileSheet_Surface_h) < Stage_Tileset_Image_Height[TileSelect_Current_Tileset]) Then
				tileSelect_tileSheet_offset_y = ty
			End If
		End If
		If Gui_Surface_Clicked(tileSelect_tileSheet_Surface) Then
			index = Int( (tileSelect_tileSheet_offset_y + my) / Stage_Tileset_Tile_Height ) * Stage_Tileset_Image_WidthInTiles[TileSelect_Current_Tileset] + Int( (tileSelect_tileSheet_offset_x + mx) / Stage_Tileset_Tile_Width)
			If index < Stage_Tileset_NumTiles[TileSelect_Current_Tileset] Then
				tileSelect_tileSheet_selected_index = index
			End If
		End If
		tileSelect_tileSheet_selected_x = Int(tileSelect_tileSheet_selected_index Mod Stage_Tileset_Image_WidthInTiles[TileSelect_Current_Tileset]) * Stage_Tileset_Tile_Width
		tileSelect_tileSheet_selected_y = Int(tileSelect_tileSheet_selected_index / Stage_Tileset_Image_WidthInTiles[TileSelect_Current_Tileset]) * Stage_Tileset_Tile_Height
	Else
		tileSelect_tileSheet_selected_index = 0
		tileSelect_tileSheet_selected_x = 0
		tileSelect_tileSheet_selected_y = 0
	End If
	If Stage_Tileset_ImageIsLoaded[TileSelect_Current_Tileset] Then
		rx = tileSelect_tileSheet_selected_x - tileSelect_tileSheet_offset_x
		ry = tileSelect_tileSheet_selected_y - tileSelect_tileSheet_offset_y
		should_draw = (rx + Stage_Tileset_Tile_Width >= 0) And (rx < tileSelect_tileSheet_Surface_w)
		should_draw = should_draw And ((ry + Stage_Tileset_Tile_Height >= 0) And (ry < tileSelect_tileSheet_Surface_h))
		If should_draw Then
			Gui_Surface_SetColor(tileSelect_tileSheet_Surface, tileSelect_selectedTile_color)
			Gui_Surface_Rect(tileSelect_tileSheet_Surface, rx, ry, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
		End If
	End If
	Gui_Surface_Update(tileSelect_tileSheet_Surface)
	
End Function

Function Editor_tileMain_ImageSlide_Change()
	If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] Then
		For i = 0 to MAX_TILE_FRAMES-1
			Gui_ImageClip_SetSource(tileMain_frameSlide_frame[i], Stage_Tileset_Image[TileMain_Current_Tileset])
		Next
	End If
End Function

Function Editor_tileMain_Surface_Update(flag)
	Gui_Surface_Clear(tileMain_tileSheetSurface)
	src_w = 0
	src_h = 0
	If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] Then
		GetImageSize(Stage_Tileset_Image[TileMain_Current_Tileset], src_w, src_h)
		If tileMain_tileSheetSurface_w < src_w Then
			src_w = tileMain_tileSheetSurface_w
		End If
		If tileMain_tileSheetSurface_h < src_h Then
			src_h = tileMain_tileSheetSurface_h
		End If
		'Print "tileset: ";tileMain_tileSheet_offset_x;", ";tileMain_tileSheet_offset_y;", ";src_w;", ";src_h
		Gui_Surface_DrawImage_Blit(tileMain_tileSheetSurface, Stage_Tileset_Image[TileMain_Current_Tileset], 0, 0, tileMain_tileSheet_offset_x, tileMain_tileSheet_offset_y, src_w, src_h)
	End If
	If flag Then
		Gui_Surface_Update(tileMain_tileSheetSurface)
	End If
End Function

Function Editor_tileMain_ImageSlide_Update()
	'Image Slide
	Gui_ImageSlide_Clear(tileMain_frameSlide)
	If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] And Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] > 0 Then
		tile_index = tileMain_tileSheet_selected_index
		For i = 0 to Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]-1
			off_x = Int(Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tile_index, i] Mod Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Width
			off_y = Int(Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tile_index, i] / Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Width
			Gui_ImageClip_SetOffset(tileMain_frameSlide_frame[i], off_x, off_y)
			Gui_ImageSlide_AddImageClip(tileMain_frameSlide, tileMain_frameSlide_frame[i])
		Next
	End If
End Function


Sub Editor_Preview_PlayTile(tset, tile_index, flag)
	If flag Then
		Gui_ImageClip_SetSourceSize(tileMain_previewClip, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
		Gui_ImageClip_SetSource(tileMain_previewClip, Stage_Tileset_Image[tset])
		Stage_Tileset_Tile_CurrentTime[tset, tile_index] = timer
		tileMain_animationIsPlaying = True
	End If
	If Not tileMain_animationIsPlaying Or Not Stage_Tileset_ImageIsLoaded[tset] Then
		Return
	End If
	t = timer
	If t - Stage_Tileset_Tile_CurrentTime[tset, tile_index] > Stage_Tileset_Tile_Delay Then
		Stage_Tileset_Tile_CurrentFrame[tset, tile_index] = Stage_Tileset_Tile_CurrentFrame[tset, tile_index] + 1
		If Stage_Tileset_Tile_CurrentFrame[tset, tile_index] >= Stage_Tileset_Tile_NumFrames[tset, tile_index] Then
			Stage_Tileset_Tile_CurrentFrame[tset, tile_index] = 0
		End If
		Stage_Tileset_Tile_CurrentTime[tset, tile_index] = t
	End If
	current_frame = Stage_Tileset_Tile_CurrentFrame[tset, tile_index]
	src_x = Int(Stage_Tileset_Tile_Frame[tset, tile_index, current_frame] Mod Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Width
	src_y = Int(Stage_Tileset_Tile_Frame[tset, tile_index, current_frame] / Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Height
	Gui_ImageClip_SetOffset(tileMain_previewClip, src_x, src_y)
End Sub

Sub Editor_Preview_StopTile()
	tileMain_animationIsPlaying = False
End Sub

Function Editor_tileMain_Update()
	Editor_tileMain_Surface_Update(0)
	mx = 0
	my = 0
	slide_change = False
	Gui_Surface_GetMouse(tileMain_tileSheetSurface, mx, my)
	Gui_Surface_SetColor(tileMain_tileSheetSurface, tileSelect_selectedTile_color) 'Using the same color used in tileSelect
	If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] Then
		If Gui_Surface_MouseOver(tileMain_tileSheetSurface) Then
			Dim tx
			Dim ty
			tx = tileMain_tileSheet_offset_x
			ty = tileMain_tileSheet_offset_y
			If Key(K_LEFT) Then
				'scroll left
				tx = tx - tileSelect_scroll_speed
			End If
			If Key(K_RIGHT) Then
				'scroll right
				tx = tx + tileSelect_scroll_speed
			End If
			If Key(K_UP) Then
				'scroll up
				ty = ty - tileSelect_scroll_speed
			End If
			If Key(K_DOWN) Then
				'scroll down
				ty = ty + tileSelect_scroll_speed
			End If
			If (tx >= 0) And ((tx + tileMain_tileSheetSurface_w) < Stage_Tileset_Image_Width[TileMain_Current_Tileset]) Then
				tileMain_tileSheet_offset_x = tx
			End If
			If (ty >= 0) And ((ty + tileMain_tileSheetSurface_h) < Stage_Tileset_Image_Height[TileSelect_Current_Tileset]) Then
				tileMain_tileSheet_offset_y = ty
			End If
		End If
		If Gui_Surface_Clicked(tileMain_tileSheetSurface) Then
			index = Int( (tileMain_tileSheet_offset_y + my) / Stage_Tileset_Tile_Height ) * Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset] + Int( (tileMain_tileSheet_offset_x + mx) / Stage_Tileset_Tile_Width)
			If index < Stage_Tileset_NumTiles[TileMain_Current_Tileset] Then
				tileMain_tileSheet_selected_index = index
				slide_change = True
			End If
		End If
		tileMain_tileSheet_selected_x = Int(tileMain_tileSheet_selected_index Mod Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Width
		tileMain_tileSheet_selected_y = Int(tileMain_tileSheet_selected_index / Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Height
	Else
		tileMain_tileSheet_selected_index = 0
		tileMain_tileSheet_selected_x = 0
		tileMain_tileSheet_selected_y = 0
	End If
	If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] Then
		rx = tileMain_tileSheet_selected_x - tileMain_tileSheet_offset_x
		ry = tileMain_tileSheet_selected_y - tileMain_tileSheet_offset_y
		should_draw = (rx + Stage_Tileset_Tile_Width >= 0) And (rx < tileMain_tileSheetSurface_w)
		should_draw = should_draw And ((ry + Stage_Tileset_Tile_Height >= 0) And (ry < tileMain_tileSheetSurface_h))
		If should_draw Then
			Gui_Surface_Rect(tileMain_tileSheetSurface, rx, ry, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
		End If
	End If
	Gui_Surface_Update(tileMain_tileSheetSurface)
	
	'Image Slide
	If slide_change Then
		Gui_TextField_SetValue(tileMain_tileIndexField, Str$(tileMain_tileSheet_selected_index))
		Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]))
		Gui_TextField_SetValue(tileMain_tileFPSField, Str$(Stage_Tileset_Tile_FPS))
		Gui_ImageSlide_Clear(tileMain_frameSlide)
		If Stage_Tileset_ImageIsLoaded[TileMain_Current_Tileset] And Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] > 0 Then
			tile_index = tileMain_tileSheet_selected_index
			For i = 0 to Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]-1
				off_x = Int(Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tile_index, i] Mod Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Width
				off_y = Int(Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tile_index, i] / Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset]) * Stage_Tileset_Tile_Height
				Gui_ImageClip_SetOffset(tileMain_frameSlide_frame[i], off_x, off_y)
				Gui_ImageSlide_AddImageClip(tileMain_frameSlide, tileMain_frameSlide_frame[i])
			Next
		End If
	End If
	
	'Add, Remove, and Set Buttons
	selected_clip = Gui_ImageSlide_GetSelectedClip(tileMain_frameSlide)
	If Gui_Button_Clicked(tileMain_addFrameButton) And Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]+1 <= MAX_TILE_FRAMES Then
		Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] = Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] + 1
		Editor_tileMain_ImageSlide_Update
		Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]))
	ElseIf Gui_Button_Clicked(tileMain_removeFrameButton) And Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] > 0 Then
		Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] = Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index] - 1
		Editor_tileMain_ImageSlide_Update
		Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]))
	ElseIf Gui_Button_Clicked(tileMain_setFrameButton) And selected_clip > 0 Then
		
		Locate(40, 90)
		SetColor(RGB(255,0,0))
		PrintS("SELECT A TILE")
		
		While Not Gui_Surface_Clicked(tileMain_tileSheetSurface)
			Gui_Surface_GetMouse(tileMain_tileSheetSurface, mx, my)
			Gui_Update
		Wend
		
		Cls
		
		index = Int( (tileMain_tileSheet_offset_y + my) / Stage_Tileset_Tile_Height ) * Stage_Tileset_Image_WidthInTiles[TileMain_Current_Tileset] + Int( (tileMain_tileSheet_offset_x + mx) / Stage_Tileset_Tile_Width)
		If index < Stage_Tileset_NumTiles[TileMain_Current_Tileset] Then
			Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tileMain_tileSheet_selected_index, selected_clip] = index
		Else
			Stage_Tileset_Tile_Frame[TileMain_Current_Tileset, tileMain_tileSheet_selected_index, selected_clip] = tileMain_tileSheet_selected_index
		End If
		Editor_tileMain_ImageSlide_Update
	End If
	
	'TextFields and Buttons
	If Gui_TextField_Return(tileMain_tileFPSField) Then
		If Gui_TextField_GetValue$(tileMain_tileFPSField) = "" Then
			Gui_TextField_SetValue(tileMain_tileFPSField, "0")
		End If
		Stage_Tileset_Tile_FPS = Val(Gui_TextField_GetValue$(tileMain_tileFPSField))
	ElseIf Gui_TextField_Return(tileMain_frameCountField) Then
		Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]))
	ElseIf Gui_TextField_Return(tileMain_tileIndexField) Then
		Gui_TextField_SetValue(tileMain_tileIndexField, Str$(tileMain_tileSheet_selected_index))
	ElseIf Gui_Button_Clicked(tileMain_playButton) Then
		'start playing animation
		Editor_Preview_PlayTile(TileMain_Current_Tileset, tileMain_tileSheet_selected_index, 1)
	ElseIf Gui_Button_Clicked(tileMain_stopButton) Then
		'stop playing animation
		Editor_Preview_StopTile
	End If
	
	Editor_Preview_PlayTile(TileMain_Current_Tileset, tileMain_tileSheet_selected_index, 0)
	
End Function

Sub Editor_Layer_DrawBkg(layer)
	If Not Stage_Layer_Bkg_ImageIsLoaded[layer] And Not Stage_Layer_Bkg_Type[layer] = STAGE_LAYER_BKG_TYPE_SURFACE Then
		Return
	End If
	
	Select Case Stage_Layer_Bkg_Type[layer]
	Case STAGE_LAYER_BKG_TYPE_IMAGE
		Select Case Stage_Layer_Bkg_Flag[layer]
		Case STAGE_LAYER_BKG_FLAG_NONE
			Gui_Surface_DrawImage(stageView_Surface, Stage_Layer_Bkg_Image[layer], 0, 0)
		Case STAGE_LAYER_BKG_FLAG_STRETCHED
			Gui_Surface_DrawImage_Blit_Ex(stageView_Surface, Stage_Layer_Bkg_Image[layer], 0, 0, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT, 0, 0, Stage_Layer_Bkg_Image_W[layer], Stage_Layer_Bkg_Image_H[layer])
		Case STAGE_LAYER_BKG_FLAG_BLIT
			Gui_Surface_DrawImage_Blit(stageView_Surface, Stage_Layer_Bkg_Image[layer], 0, 0, Stage_Layer_Bkg_BlitX[layer], Stage_Layer_Bkg_BlitY[layer], Stage_Layer_Bkg_BlitW[layer], Stage_Layer_Bkg_BlitH[layer])
		Case STAGE_LAYER_BKG_FLAG_TILED
			If Stage_Layer_Bkg_Image_H[layer] > 0 And Stage_Layer_Bkg_Image_W[layer] > 0 Then
				For y = 0 to STAGE_SCREEN_HEIGHT-1 Step Stage_Layer_Bkg_Image_H[layer]
					For x = 0 to STAGE_SCREEN_WIDTH-1 Step Stage_Layer_Bkg_Image_W[layer]
						Gui_Surface_DrawImage(stageView_Surface, Stage_Layer_Bkg_Image[layer], x, y)
					Next
				Next
			End If
		Case STAGE_LAYER_BKG_FLAG_SCROLL
			If Stage_Layer_Bkg_Image_H[layer] > 0 And Stage_Layer_Bkg_Image_W[layer] > 0 Then
				img_w = Stage_Layer_Bkg_Image_W[layer]
				img_h = Stage_Layer_Bkg_Image_H[layer]
				i = 0
				For y =  -1* Int( (Stage_offset_y * Stage_Layer_Bkg_Scroll_VSpeed[layer]) Mod img_h) to STAGE_SCREEN_HEIGHT-1 Step Stage_Layer_Bkg_Image_H[layer]
					For x = -1 * Int( (Stage_offset_x * Stage_Layer_Bkg_Scroll_HSpeed[layer]) Mod img_w) to STAGE_SCREEN_WIDTH-1 Step Stage_Layer_Bkg_Image_W[layer]
						'print "i = ";i
						'i = i + 1
						Gui_Surface_DrawImage(stageView_Surface, Stage_Layer_Bkg_Image[layer], x, y)
					Next
				Next
			End If
		End Select
	Case STAGE_LAYER_BKG_TYPE_SURFACE
		Gui_Surface_SetColor(stageView_Surface, RGBA(Stage_Layer_Bkg_Color[layer,0], Stage_Layer_Bkg_Color[layer,1], Stage_Layer_Bkg_Color[layer, 2], Stage_Layer_Bkg_Alpha[layer]))
		Gui_Surface_RectFill(stageView_Surface, 0, 0, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT)
		'Need to add surface draw commands here
	End Select
End Sub

Sub Editor_DrawActor(actor)
	sprite = Actor_Sprite[actor]
	anim = Actor_CurrentAnimation[actor]
	frame = Actor_CurrentFrame[actor]
	src_x = Int(Sprite_Animation_Frame[sprite, anim, frame] Mod Sprite_Image_WidthInFrames[sprite]) * Sprite_Frame_Width[sprite]
	src_y = Int(Sprite_Animation_Frame[sprite, anim, frame] / Sprite_Image_WidthInFrames[sprite]) * Sprite_Frame_Height[sprite]
	src_w = Sprite_Frame_Width[sprite]
	src_h = Sprite_Frame_Height[sprite]
	img = Sprite_Image[sprite]
	x = Actor_X[actor]
	y = Actor_Y[actor]
	w = Sprite_Frame_Width[sprite] * Actor_ZX[actor]
	h = Sprite_Frame_Height[sprite] * Actor_ZY[actor]
	Gui_Surface_DrawImage_Blit_Ex(stageView_Surface, img, x-Stage_offset_x, y-Stage_offset_y, w, h, src_x, src_y, src_w, src_h)
	If actor = Current_Actor Then
		Gui_Surface_SetColor(stageView_Surface, RGB(255,0,0))
		Gui_Surface_Rect(stageView_Surface, x-Stage_offset_x, y-Stage_offset_y, w, h)
	End If
End Sub	

Function GetFirstActorAt(x, y)
	For i = 0 to actor_database_count-1
		actor = actor_database_actor[i]
		If Actor_inUse[actor] Then
			If x >= Actor_X[actor] And x < Actor_X[actor] + Sprite_Frame_Width[Actor_Sprite[actor]] Then
				If y >= Actor_Y[actor] And y < Actor_Y[actor] + Sprite_Frame_Height[Actor_Sprite[actor]] Then
					Return i
				End If
			End If
		End If
	Next
	Return -1
End Function

Function Editor_stageView_Surface_Update()
	If Stage_Tile_Width <= 0 And Stage_Tile_Height <= 0 Then
		Return 0
	End If
	
	t = timer
	
	Dim sect_x[9]
	Dim sect_y[9]
	
	Gui_Surface_SetClearColor(stageView_Surface, rgb(128,128,128))
	Gui_Surface_Clear(stageView_Surface)
	
	off_x = Stage_offset_x Mod Stage_Tileset_Tile_Width * -1
	off_y = Stage_offset_y Mod Stage_Tileset_Tile_Height * -1
	
	draw_w = stageView_Surface_w
	draw_h = stageView_Surface_h
	
	If (off_x + draw_w + Stage_Tileset_Tile_Width) < Stage_Pixel_Width Then
		draw_w = draw_w + Stage_Tileset_Tile_Width
	End If
	
	If (off_y + draw_h + Stage_Tileset_Tile_Height) < Stage_Pixel_Height Then
		draw_h = draw_h + Stage_Tileset_Tile_Height
	End If
	
	For layer = 0 to MAX_LAYERS-1
		If Stage_Layer_Type[layer] = STAGE_LAYER_TYPE_TILE And Gui_CheckBox_GetValue(displaySettings_layer_main_checkbox[layer]) Then
			For sy = 0 to draw_h-1 Step Stage_Tileset_Tile_Height
				For sx = 0 to draw_w-1 Step Stage_Tileset_Tile_Width
					x = (Stage_offset_x + sx) / Stage_Tileset_Tile_Width
					y = (Stage_offset_y + sy) / Stage_Tileset_Tile_Height
					tile = Stage_Layer_Tile_Data[layer, y, x]
					tset = Stage_Layer_Tile_Tileset[layer, y, x]
					If Stage_Tileset_ImageIsLoaded[tset] And tile >= 0 Then
						
						If t - Stage_Tileset_Tile_CurrentTime[tset, tile] > Stage_Tileset_Tile_Delay Then
							Stage_Tileset_Tile_CurrentFrame[tset, tile] = Stage_Tileset_Tile_CurrentFrame[tset, tile] + 1
							If Stage_Tileset_Tile_CurrentFrame[tset, tile] >= Stage_Tileset_Tile_NumFrames[tset, tile] Then
								Stage_Tileset_Tile_CurrentFrame[tset, tile] = 0
							End If
							Stage_Tileset_Tile_CurrentTime[tset, tile] = t
						End If
						
						frame = Stage_Tileset_Tile_CurrentFrame[tset, tile]
						src_x = (Stage_Tileset_Tile_Frame[tset, tile, frame] Mod Stage_Tileset_Image_WidthInTiles[tset]) * Stage_Tileset_Tile_Width
						src_y = Int(Stage_Tileset_Tile_Frame[tset, tile, frame] / Stage_Tileset_Image_WidthInTiles[tset]) * Stage_Tileset_Tile_Height
						Gui_Surface_DrawImage_Blit(stageView_Surface, Stage_Tileset_Image[tset], off_x + sx, off_y + sy, src_x, src_y, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
					End If
				Next
			Next
		ElseIf Stage_Layer_Type[layer] = STAGE_LAYER_TYPE_BKG And Gui_CheckBox_GetValue(displaySettings_layer_main_checkbox[layer]) Then
			Editor_Layer_DrawBkg(layer)
		End If
		
		'num_shapes_to_draw = Stage_Layer_Shape_Count[layer]
		'If Shape_Current_Point = 1 Then
		'	num_shapes_to_draw = num_shapes_to_draw + 1
		'End If
		
		'If num_shapes_to_draw > 0 And Gui_CheckBox_GetValue(displaySettings_layer_shape_checkbox[layer]) Then
		'	Gui_Surface_SetColor(stageView_Surface, rgb(0,255,0))
		'	For shape_num = 0 to num_shapes_to_draw-1
		'		x = Stage_Layer_Shape_X[layer, shape_num] - Stage_offset_x
		'		y = Stage_Layer_Shape_Y[layer, shape_num] - Stage_offset_y
		'		p1 = Stage_Layer_Shape_Param[layer, shape_num, 0] - Stage_offset_x
		'		p2 = Stage_Layer_Shape_Param[layer, shape_num, 1] - Stage_offset_y
		'		Select Case Stage_Layer_Shape_Type[layer, shape_num]
		'		Case SHAPE_TYPE_LINE
		'			Gui_Surface_Line(stageView_Surface, x, y, p1, p2)
		'		Case SHAPE_TYPE_RECT
		'			Gui_Surface_Box(stageView_Surface, x, y, p1, p2)
		'		End Select
		'	Next
		'End If
		
		sect_x[0] = Int(Stage_offset_x / Stage_Sector_Width)
		sect_y[0] = Int(Stage_offset_y / Stage_Sector_Height)
		
		sector_x = sect_x[0]
		sector_y = sect_y[0]
		
		sect_x[1] = sector_x - 1
		sect_y[1] = sector_y - 1
		
		sect_x[2] = sector_x
		sect_y[2] = sector_y - 1
		
		sect_x[3] = sector_x + 1
		sect_y[3] = sector_y - 1
		
		sect_x[4] = sector_x - 1
		sect_y[4] = sector_y
		
		sect_x[5] = sector_x + 1
		sect_y[5] = sector_y
		
		sect_x[6] = sector_x - 1
		sect_y[6] = sector_y + 1
		
		sect_x[7] = sector_x
		sect_y[7] = sector_y + 1
		
		sect_x[8] = sector_x + 1
		sect_y[8] = sector_y + 1
		
		Gui_Surface_SetColor(stageView_Surface, rgb(0,255,0))
		
		For i = 0 to 8
			sector_x = sect_x[i]
			sector_y = sect_y[i]
			If sector_x >= 0 And sector_y >= 0 Then
				If Stage_Sector_NumShapes[sector_x, sector_y] > 0 Then
					For shape_num = 0 to Stage_Sector_NumShapes[sector_x, sector_y]-1
						If Stage_Sector_Shape_Layer[sector_x, sector_y, shape_num] = layer And Gui_CheckBox_GetValue(displaySettings_layer_shape_checkbox[layer]) Then
							shape_index = Stage_Sector_Shape_Index[sector_x, sector_y, shape_num]
							x = Stage_Layer_Shape_X[layer, shape_index] - Stage_offset_x
							y = Stage_Layer_Shape_Y[layer, shape_index] - Stage_offset_y
							p1 = Stage_Layer_Shape_Param[layer, shape_index, 0] - Stage_offset_x
							p2 = Stage_Layer_Shape_Param[layer, shape_index, 1] - Stage_offset_y
							Select Case Stage_Layer_Shape_Type[layer, shape_index]
							Case SHAPE_TYPE_LINE
								Gui_Surface_Line(stageView_Surface, x, y, p1, p2)
							Case SHAPE_TYPE_RECT
								Gui_Surface_Box(stageView_Surface, x, y, p1, p2)
							End Select
						End If
					Next
				End If
			End If
		Next
		
		If layer = Current_Layer And Shape_Current_Point = 1 Then
			shape_index = Stage_Layer_Shape_Count[layer]
			x = Stage_Layer_Shape_X[layer, shape_index] - Stage_offset_x
			y = Stage_Layer_Shape_Y[layer, shape_index] - Stage_offset_y
			p1 = Stage_Layer_Shape_Param[layer, shape_index, 0] - Stage_offset_x
			p2 = Stage_Layer_Shape_Param[layer, shape_index, 1] - Stage_offset_y
			Select Case Stage_Layer_Shape_Type[layer, shape_index]
			Case SHAPE_TYPE_LINE
				Gui_Surface_Line(stageView_Surface, x, y, p1, p2)
			Case SHAPE_TYPE_RECT
				Gui_Surface_Box(stageView_Surface, x, y, p1, p2)
			End Select
		End If
		
		If Stage_Layer_NumActors[layer] > 0 And Gui_CheckBox_GetValue(displaySettings_layer_actor_checkbox[layer]) Then
			For a = 0 to Stage_Layer_NumActors[layer]-1
				Editor_DrawActor(Stage_Layer_Actor[layer, a])
			Next
		End If
	Next
	
End Function

Function Editor_stageView_Update()
	'Editor_tileMain_Surface_Update(0)
	mx = 0
	my = 0
	offset_x = Stage_offset_x
	offset_y = Stage_offset_y
	Gui_Surface_GetMouse(stageView_Surface, mx, my)
	
	current_tab = Gui_TabGroup_GetActiveTab(tool_tabGroup)
	If Stage_Layer_Type[Current_Layer] = STAGE_LAYER_TYPE_TILE Then
		If Stage_Tileset_ImageIsLoaded[TileSelect_Current_Tileset] And current_tab = tool_tileTab Then
			If Gui_Surface_MouseOver(stageView_Surface) Then
				If Gui_Surface_Down(stageView_Surface) Then
					'The position in the stage to place the tile
					'stage_pos_index = Int( (offset_y + my) / Stage_Tileset_Tile_Height ) * Stage_Tile_Width + Int( (offset_x + mx) / Stage_Tileset_Tile_Width)
					Stage_Layer_SetTile(Current_Layer, TileSelect_Current_Tileset, tileSelect_tileSheet_selected_index, offset_x+mx, offset_y+my)
				ElseIf MouseButton(2) Then
					Stage_Layer_RemoveTile(Current_Layer, offset_x+mx, offset_y+my)
				End If
			End If
		End If
	End If
	
	actor = actor_database_actor[Current_Actor]
	
	If Actor_inUse[actor] And current_tab = tool_actorTab Then
		If Gui_Surface_MouseOver(stageView_Surface) Then
			If MouseButton(0) Then
				If tile_snap Then
					tsnap_x = Int( (offset_x + mx) / Stage_Tileset_Tile_Width) * Stage_Tileset_Tile_Width
					tsnap_y = Int( (offset_y + my) / Stage_Tileset_Tile_Height) * Stage_Tileset_Tile_Height
					Actor_SetPosition(actor, tsnap_x, tsnap_y)
				Else
					Actor_SetPosition(actor, offset_x + mx, offset_y + my)
				End If
				Actor_SetLayer(actor, Current_Layer)
				Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[actor]))
				Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[actor]))
				Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[actor]))
			ElseIf MouseButton(2) Then
				f_actor = GetFirstActorAt(offset_x + mx, offset_y + my)
				If f_actor >= 0 Then
					Current_Actor = f_actor
					Gui_ListBox_SetSelectedItem(actor_listBox, Current_Actor)
					Gui_ListBox_Update(actor_listBox)
					Gui_TextField_SetValue(actor_name_field, Actor_Name$[Current_Actor])
					Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[Current_Actor]))
					Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[Current_Actor]))
					Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[Current_Actor]))
				End If
			End If
		End If
	End If
	
	If current_tab = tool_shapeTab Then
			If Key(K_R) Then
				Shape_Current_State = SHAPE_STATE_DRAW_RECT
				Shape_Current_Point = 0
			ElseIf Key(K_L) Then
				Shape_Current_State = SHAPE_STATE_DRAW_LINE
				Shape_Current_Point = 0
			End If
			
			If Gui_TextField_Return(shape_positionX_field) Then
				Stage_Layer_Shape_X[Current_Layer, Current_Shape] = Int(Val(Gui_TextField_GetValue$(shape_positionX_field)))
			ElseIf Gui_TextField_Return(shape_positionY_field) Then
				Stage_Layer_Shape_Y[Current_Layer, Current_Shape] = Int(Val(Gui_TextField_GetValue$(shape_positionY_field)))
			ElseIf Gui_TextField_Return(shape_parameter1_field) Then
				Stage_Layer_Shape_Param[Current_Layer, Current_Shape, 0] = Int(Val(Gui_TextField_GetValue$(shape_parameter1_field)))
			ElseIf Gui_TextField_Return(shape_parameter2_field) Then
				Stage_Layer_Shape_Param[Current_Layer, Current_Shape, 1] = Int(Val(Gui_TextField_GetValue$(shape_parameter2_field)))
			End If
			
			If Stage_Layer_Shape_Count[Current_Layer] > 0 Then
				Select Case Gui_DropDown_GetSelectedItem(shape_type_selection)
				Case shape_rect
					If Stage_Layer_Shape_Type[Current_Layer, Current_Shape] <> SHAPE_TYPE_RECT Then
						Stage_Layer_Shape_Type[Current_Layer, Current_Shape] = SHAPE_TYPE_RECT
						shape_num = Current_Shape
						shape_listBox_entry$ = "RECT:"
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]) + ", " + Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]) + ")-"
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]) + ", " + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]) + ")"
						Gui_ListBox_SetValue(shape_listBox, shape_num, shape_listBox_entry$)
						Gui_ListBox_Update(shape_listBox)
					End If
				Case shape_line
					If Stage_Layer_Shape_Type[Current_Layer, Current_Shape] <> SHAPE_TYPE_LINE Then
						Stage_Layer_Shape_Type[Current_Layer, Current_Shape] = SHAPE_TYPE_LINE
						shape_num = Current_Shape
						shape_listBox_entry$ = "LINE:"
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]) + ", " + Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]) + ")-"
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]) + ", " + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]) + ")"
						Gui_ListBox_SetValue(shape_listBox, shape_num, shape_listBox_entry$)
						Gui_ListBox_Update(shape_listBox)
					End If
				End Select
			End If
			
			If Gui_Surface_MouseOver(stageView_Surface) And Shape_Current_State > 0 Then
				shape_num = Stage_Layer_Shape_Count[Current_Layer]
				Select Case Shape_Current_State
				Case SHAPE_STATE_DRAW_LINE
					Stage_Layer_Shape_Type[Current_Layer, shape_num] = SHAPE_TYPE_LINE
				Case SHAPE_STATE_DRAW_RECT
					Stage_Layer_Shape_Type[Current_Layer, shape_num] = SHAPE_TYPE_RECT
				End Select
				
				sx = offset_x + mx
				sy = offset_y + my
				
				If tile_snap Then
					sx = Int(sx / Stage_Tileset_Tile_Width) * Stage_Tileset_Tile_Width
					sy = Int(sy / Stage_Tileset_Tile_Height) * Stage_Tileset_Tile_Height
				End If
				
				If Gui_Surface_Clicked(stageView_Surface) Then
					
					If Shape_Current_Point = 0 Then
						Stage_Layer_Shape_X[Current_Layer, shape_num] = sx
						Stage_Layer_Shape_Y[Current_Layer, shape_num] = sy
						Shape_Current_Point = 1
					Else
						Stage_Layer_Shape_Param[Current_Layer, shape_num, 0] = sx
						Stage_Layer_Shape_Param[Current_Layer, shape_num, 1] = sy
						
						SetShapeSector(Current_Layer, shape_num)
						
						shape_listbox_entry$ = ""
						
						Select Case Stage_Layer_Shape_Type[Current_Layer, shape_num]
						Case SHAPE_TYPE_LINE
							shape_listbox_entry$ = "LINE:"
						Case SHAPE_TYPE_RECT
							shape_listbox_entry$ = "RECT:"
						End Select
						
						Select Case Stage_Layer_Shape_Type[Current_Layer, shape_num]
						Case SHAPE_TYPE_LINE
							Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
						Case SHAPE_TYPE_RECT
							Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
						End Select
						
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]) + ", " + Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]) + ")-"
						shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]) + ", " + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]) + ")"
						Gui_ListBox_AddItem(shape_listBox, shape_listbox_entry$)
						Gui_ListBox_SetSelectedItem(shape_listBox, shape_num)
						Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]))
						Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]))
						Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]))
						Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]))
						Gui_ListBox_Update(shape_listBox)
						Shape_Current_Point = 0
						Stage_Layer_Shape_Count[Current_Layer] = shape_num + 1
					End If
				
				ElseIf MouseButton(2) Then
					Shape_Current_Point = 0
					Shape_Current_State = SHAPE_STATE_NULL
				ElseIf Shape_Current_Point = 1 Then
					If tile_snap Then
						Stage_Layer_Shape_X[Current_Layer, shape_num] = Int(Stage_Layer_Shape_X[Current_Layer, shape_num] / Stage_Tileset_Tile_Width) * Stage_Tileset_Tile_Width
						Stage_Layer_Shape_Y[Current_Layer, shape_num] = Int(Stage_Layer_Shape_Y[Current_Layer, shape_num] / Stage_Tileset_Tile_Height) * Stage_Tileset_Tile_Height
					End If
					Stage_Layer_Shape_Param[Current_Layer, shape_num, 0] = sx
					Stage_Layer_Shape_Param[Current_Layer, shape_num, 1] = sy
				End If
			End If
			
	End If
	
	Editor_stageView_Surface_Update
	
	If Gui_Surface_MouseOver(stageView_Surface) Then
		If Key(K_LEFT) Then
			Stage_offset_x = Stage_offset_x - stageView_scroll_speed
			If Stage_offset_x < 0 Then
				Stage_offset_x = 0
			End If
		End If
		
		If Key(K_RIGHT) Then
			If Stage_offset_x + stageView_Surface_w + stageView_scroll_speed < Stage_Pixel_Width Then
				Stage_offset_x = Stage_offset_x + stageView_scroll_speed
			End If
		End If
		
		If Key(K_UP) Then
			Stage_offset_y = Stage_offset_y - stageView_scroll_speed
			If Stage_offset_y < 0 Then
				Stage_offset_y = 0
			End If
		End If
		
		If Key(K_DOWN) Then
			If Stage_offset_y + stageView_Surface_h + stageView_scroll_speed < Stage_Pixel_Height Then
				Stage_offset_y = Stage_offset_y + stageView_scroll_speed
			End If
		End If
		
		If Key(K_T) Then
			tile_snap = True
		ElseIf Key(K_F) Then
			tile_snap = False
		End If
		
		Gui_TextField_SetValue(stagePos_stageCoord_X_field, Str$(Stage_offset_x+mx))
		Gui_TextField_SetValue(stagePos_stageCoord_Y_field, Str$(Stage_offset_y+my))
		
		Gui_TextField_SetValue(stagePos_screenCoord_X_field, Str$(mx))
		Gui_TextField_SetValue(stagePos_screenCoord_Y_field, Str$(my))
		
		Gui_TextField_SetValue(stagePos_cameraView_X_field, Str$(Stage_offset_x))
		Gui_TextField_SetValue(stagePos_cameraView_Y_field, Str$(Stage_offset_y))
		
		If Stage_Tile_Width > 0 And Stage_Tile_Height > 0 Then
			off_x = Stage_offset_x Mod Stage_Tileset_Tile_Width * -1
			off_y = Stage_offset_y Mod Stage_Tileset_Tile_Height * -1
			Gui_TextField_SetValue(stagePos_stageCoord_Tile_X_field, Str$(Int((Stage_offset_x+mx)/Stage_Tileset_Tile_Width)*Stage_Tileset_Tile_Width))
			Gui_TextField_SetValue(stagePos_stageCoord_Tile_Y_field, Str$(Int((Stage_offset_y+my)/Stage_Tileset_Tile_Height)*Stage_Tileset_Tile_Height))
			Gui_TextField_SetValue(stagePos_screenCoord_Tile_X_field, Str$(Int(mx/Stage_Tileset_Tile_Width)*Stage_Tileset_Tile_Width))
			Gui_TextField_SetValue(stagePos_screenCoord_Tile_Y_field, Str$(Int(my/Stage_Tileset_Tile_Height)*Stage_Tileset_Tile_Height))
			Gui_TextField_SetValue(stagePos_cameraView_Tile_X_field, Str$( Int(Stage_offset_x /Stage_Tileset_Tile_Width)*Stage_Tileset_Tile_Width))
			Gui_TextField_SetValue(stagePos_cameraView_Tile_Y_field, Str$( Int(Stage_offset_y /Stage_Tileset_Tile_Height)*Stage_Tileset_Tile_Height))
		Else
			Gui_TextField_SetValue(stagePos_stageCoord_Tile_X_field, "0")
			Gui_TextField_SetValue(stagePos_stageCoord_Tile_Y_field, "0")
			Gui_TextField_SetValue(stagePos_screenCoord_Tile_X_field, "0")
			Gui_TextField_SetValue(stagePos_screenCoord_Tile_Y_field, "0")
			Gui_TextField_SetValue(stagePos_cameraView_Tile_X_field, "0")
			Gui_TextField_SetValue(stagePos_cameraView_Tile_Y_field, "0")
		End If
		
		If Stage_Tile_Width > 0 And Stage_Tile_Height > 0 And Gui_TabGroup_GetActiveTab(tool_tabGroup) = tool_tileTab Then
			off_x = Stage_offset_x Mod Stage_Tileset_Tile_Width * -1
			off_y = Stage_offset_y Mod Stage_Tileset_Tile_Height * -1
			Gui_Surface_SetColor(stageView_Surface, tileSelect_selectedTile_color) 'Using the same color as tile selector
			Gui_Surface_Rect(stageView_Surface, off_x + Int((-1*off_x + mx)/Stage_Tileset_Tile_Width)*Stage_Tileset_Tile_Width, off_y + Int((-1*off_y + my)/Stage_Tileset_Tile_Height)*Stage_Tileset_Tile_Height, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
		End If
	End If
	
	Gui_Surface_Update(stageView_Surface)
End Function

Function Editor_LoadTileset()
	System("rcbasic editor.cbc tileMain_loadTilesetButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	tileSelect_tileSheet_selected_index = 0
	LoadTileSet(TileMain_Current_Tileset, Dlg_data$[0])
	tileMain_tileSheet_offset_x = 0
	tileMain_tileSheet_offset_y = 0
	Gui_ImageSlide_Clear(tileMain_frameSlide)
	For i = 0 to MAX_TILE_FRAMES-1
		Gui_ImageClip_SetSource(tileMain_frameSlide_frame[i], Stage_Tileset_Image[TileMain_Current_Tileset])
	Next
	Editor_tileMain_Surface_Update(1)
	If TileMain_Current_Tileset = TileSelect_Current_Tileset Then
		Editor_tileSelect_Surface_Update(True)
	End If
	Gui_TextField_SetValue(tileMain_tileIndexField, Str$(tileMain_tileSheet_selected_index))
	Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[TileMain_Current_Tileset, tileMain_tileSheet_selected_index]))
	Gui_TextField_SetValue(tileMain_tileFPSField, Str$(Stage_Tileset_Tile_FPS))
	Return True
End Function

Function Editor_SaveTileset()
	tset_file$ = Stage_Tileset_File$[TileMain_Current_Tileset]
	tset_file$ = Mid$(tset_file$, 0, FindLastOf(".",tset_file$)) + ".tset"
	SaveTileSet(TileMain_Current_Tileset, tset_file$)
	Return True
End Function

Function Editor_Sprite_inDatabase(sprite)
	sprite_isInDB = False
	If stage_database_count > 0 Then
		For i = 0 to stage_database_count-1
			If Sprite_Name$[stage_database_sprite[i]] = Sprite_Name$[sprite] Then
				sprite_isInDB = True
				Exit For
			End If
		Next
	End If
	Return sprite_isInDB
End Function

Sub Editor_AddSpriteToDataBase(sprite)
	If sprite < 0 Then
		Return
	End If
	'Print "d = ";Editor_Sprite_inDatabase(sprite)
	'Print "u = ";Sprite_inUse[sprite]
	'Print ""
	If Sprite_inUse[sprite] And (Not Editor_Sprite_inDatabase(sprite)) And stage_database_count < MAX_SPRITES Then
		stage_database_sprite[ stage_database_count ] = sprite
		Gui_ListBox_AddItem(spriteStageList_listBox, Sprite_Name$[sprite])
		If stage_database_count = 0 Then
			Gui_ListBox_SetSelectedItem(spriteStageList_listBox, 0)
		End If
		Gui_ListBox_Update(spriteStageList_listBox)
		stage_database_count = stage_database_count + 1
	End If
End Sub

Sub Editor_AddSpriteToDataBase_NoUpdate(sprite)
	If sprite < 0 Then
		Return
	End If
	'Print "d = ";Editor_Sprite_inDatabase(sprite)
	'Print "u = ";Sprite_inUse[sprite]
	'Print ""
	'Print Sprite_Name$[sprite];"  ";Sprite_inUse[sprite];"  ";(Not Editor_Sprite_inDatabase(sprite));"  ";stage_database_count < MAX_SPRITES
	If Sprite_inUse[sprite] And (Not Editor_Sprite_inDatabase(sprite)) And stage_database_count < MAX_SPRITES Then
		stage_database_sprite[ stage_database_count ] = sprite
		Gui_ListBox_AddItem(spriteStageList_listBox, Sprite_Name$[sprite])
		If stage_database_count = 0 Then
			Gui_ListBox_SetSelectedItem(spriteStageList_listBox, 0)
		End If
		stage_database_count = stage_database_count + 1
	End If
End Sub

Sub Editor_RemoveSpriteFromDataBase(sprite)
	If Editor_Sprite_inDatabase(sprite) Then
		db_entry = 0
		For i = 0 to stage_database_count-1
			If Sprite_Name$[sprite] = Sprite_Name$[ stage_database_sprite[i] ] Then
				db_entry = i
				Exit For
			End If
		Next
		
		num_to_sort = stage_database_count - db_entry - 1
		
		If num_to_sort > 0 Then
			For i = db_entry to db_entry + num_to_sort
				stage_database_sprite[i] = stage_database_sprite[i+1]
			Next
		End If
		stage_database_count = stage_database_count - 1
		
		Gui_ListBox_RemoveItem(spriteStageList_listBox, db_entry)
		If db_entry >= stage_database_count Then
			Gui_ListBox_SetSelectedItem(spriteStageList_listBox, db_entry-1)
		End If
		Gui_ListBox_Update(spriteStageList_listBox)
	End If
End Sub

Function Editor_Sprite_Backup()
	If Sprite_inUse[SpriteMain_Current_Sprite] And Not Editor_Sprite_inDatabase(SpriteMain_Current_Sprite) Then
		'Ask user if they want to discard the sprite
		System("rcbasic editor.cbc spriteMain_shouldBackup")
		Dlg_GetData
		If Dlg_data$[0] = "#NULL" Then
			Return False
		End If
		SaveSprite(SpriteMain_Current_Sprite)
	End If
	Return True
End Function

Sub Editor_SetActorClip()
	a = actor_database_actor[Current_Actor]
	s = Actor_Sprite[a]
	Gui_ImageClip_SetSource(actor_previewClip, Sprite_Image[s])
	Gui_ImageClip_SetSourceSize(actor_previewClip, Sprite_Frame_Width[s], Sprite_Frame_Height[s])
	anim = Actor_CurrentAnimation[a]
	frame = Sprite_Animation_Frame[s, anim, 0]
	img_w = Sprite_Image_W[s]
	img_h = Sprite_Image_H[s]
	off_x = Int(frame Mod Sprite_Image_WidthInFrames[s]) * Sprite_Frame_Width[s]
	off_y = Int(frame / Sprite_Image_WidthInFrames[s]) * Sprite_Frame_Height[s]
	Gui_ImageClip_SetOffset(actor_previewClip, off_x, off_y)
End Sub

Sub Editor_AddActorToDatabase(actor)
	If actor_database_count < MAX_ACTORS Then
		actor_database_actor[actor_database_count] = actor
		If actor_database_count = 0 Then
			Current_Actor = 0
			Gui_TextField_SetValue(actor_name_field, Actor_Name$[actor])
			Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[actor_database_count]))
			Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[actor_database_count]))
			Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[actor_database_count]))
			Editor_SetActorClip
		End If
		actor_database_count = actor_database_count + 1
	End If
	
	Gui_ListBox_AddItem(actor_listBox, Actor_Name$[actor])
End Sub

Include "spriteMain_ui.bas"

Function Editor_LoadStage()
	System("rcbasic editor.cbc top_menu_loadButton")
	Dlg_GetData
	
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	Current_Layer = 0
	
	LoadStage(Dlg_data$[0])
	
	'Stage Info
	Gui_TextField_SetValue(stageInfo_nameField, Stage_Name$)
	Gui_TextField_SetValue(stageInfo_widthField, Str$(Stage_Tile_Width))
	Gui_TextField_SetValue(stageInfo_heightField, Str$(Stage_Tile_Height))
	
	'Layer Settings
	For i = 0 to MAX_LAYERS-1
		Gui_DropDown_SetSelectedItem(layerInfo_typeSelect[i], Stage_Layer_Type[i])
		Gui_CheckBox_SetValue(layerInfo_colDetCheckBox[i], Stage_Layer_ColDet[i])
	Next
	
	'Tile Selector
	Gui_DropDown_SetSelectedItem(tileSelect_sheetSelect, 0)
	Gui_Surface_Clear(tileSelect_tileSheet_Surface)
	If Stage_Tileset_ImageIsLoaded[0] Then
		Gui_Surface_DrawImage(tileSelect_tileSheet_Surface, Stage_Tileset_Image[0], 0, 0)
	End If
	
	tileSelect_tileSheet_offset_x = 0
	tileSelect_tileSheet_offset_y = 0
	tileSelect_tileSheet_selected_x = 0
	tileSelect_tileSheet_selected_y = 0
	tileSelect_tileSheet_selected_index = 0
	Gui_Surface_SetColor(tileSelect_tileSheet_Surface, tileSelect_selectedTile_color)
	Gui_Surface_Rect(tileSelect_tileSheet_Surface, tileSelect_tileSheet_selected_x, tileSelect_tileSheet_selected_y, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
	Gui_Surface_Update(tileSelect_tileSheet_Surface)
	
	'Setting the Active Layer to 0
	Gui_DropDown_SetSelectedItem(stageView_layerSelection, 0)
	
	'Drawing the background surface in the background tab
	Gui_Surface_Clear(background_surface)
	If ImageExists(Stage_Layer_Bkg_Image[0]) Then
		w = 0
		h = 0
		GetImageSize(Stage_Layer_Bkg_Image[0], w, h)
		Gui_Surface_DrawImage_Blit_Ex(background_surface, Stage_Layer_Bkg_Image[0], 0, 0, background_surface_w, background_surface_h, 0, 0, w, h)
	End If
	Gui_Surface_Update(background_surface)
	
	'Shapes
	If Stage_Layer_Shape_Count[0] > 0 Then
		For i = 0 to Stage_Layer_Shape_Count[0]-1
			shape_t$ = ""
			Select Case Stage_Layer_Shape_Type[0, i]
			Case SHAPE_TYPE_LINE
				shape_t$ = "LINE"
			Case SHAPE_TYPE_RECT
				shape_t$ = "RECT"
			End Select			
			Gui_ListBox_AddItem(shape_listBox, shape_t$ + ":(" + Str$(Stage_Layer_Shape_X[0,i]) + "," + Str$(Stage_Layer_Shape_Y[0,i]) + ")-(" + Str$(Stage_Layer_Shape_Param[0,i,0]) + "," + Str$(Stage_Layer_Shape_Param[0,i,1]) + ")")
		Next
		Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[0,0]))
		Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[0,0]))
		Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[0,0,0]))
		Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[0,0,1]))
		Gui_ListBox_SetSelectedItem(shape_listBox, 0)
		If Stage_Layer_Shape_Type[0,0] = SHAPE_TYPE_LINE Then
			Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
		Else
			Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
		End If
	Else
		Gui_TextField_SetValue(shape_positionX_field, "0")
		Gui_TextField_SetValue(shape_positionY_field, "0")
		Gui_TextField_SetValue(shape_parameter1_field, "0")
		Gui_TextField_SetValue(shape_parameter2_field, "0")
		Gui_ListBox_SetSelectedItem(shape_listBox, 0)
		Gui_DropDown_SetSelectedItem(shape_type_selection, 0)
	End If
	
	'Actors and Sprites
	Gui_ListBox_Clear(spriteStageList_listBox)
	Gui_ListBox_Clear(spriteAnimation_animationListBox)
	Gui_ListBox_Clear(actor_listBox)
	Gui_ImageClip_Clear(actor_previewClip)
	Gui_ImageClip_Clear(spriteAnimation_previewClip)
	Gui_TextField_SetValue(spriteInfo_nameField, " ")
	Gui_TextField_SetValue(spriteInfo_frameWidthField, " ")
	Gui_TextField_SetValue(spriteInfo_frameHeightField, " ")
	
	actor_database_count = 0
	stage_database_count = 0
	For layer_num = 0 to MAX_LAYERS-1
		If Stage_Layer_NumActors[layer_num] > 0 Then
			For i = 0 to Stage_Layer_NumActors[layer_num]-1
				a = Stage_Layer_Actor[layer_num, i]
				spr = Actor_Sprite[a]
				Editor_AddSpriteToDataBase_NoUpdate(spr)
				Editor_AddActorToDatabase(a)
			Next
		End If
	Next
	
	Gui_ListBox_SetSelectedItem(spriteStageList_listBox, 0)
	Gui_ListBox_SetSelectedItem(actor_listBox, 0)
	
	Gui_ListBox_Update(spriteStageList_listBox)
	Gui_ListBox_Update(actor_listBox)
	
	Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
	Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
	Gui_ImageSlide_Clear(spriteAnimation_frameSlide)
	
	Gui_Surface_Clear(spriteBounds_spriteSheetSurface)
	Gui_Surface_Update(spriteBounds_spriteSheetSurface)
	
	SpriteMain_Current_Sprite = stage_database_sprite[0]
	
	If stage_database_count > 0 Then
		Editor_spriteMain_setSelectedSprite(SpriteMain_Current_Sprite)
	End If
	
	
	'Tile Main Tab
	Gui_DropDown_SetSelectedItem(tileMain_tileSheetSelection, 0)
	Gui_DropDown_Update(tileMain_tileSheetSelection)
	Gui_TextField_SetValue(tileMain_tileIndexField, "0")
	Gui_TextField_SetValue(tileMain_tileFPSField, Str$(Stage_Tileset_Tile_FPS))
	Gui_TextField_SetValue(tileMain_frameCountField, Str$(Stage_Tileset_Tile_NumFrames[0, 0]))
	TileMain_Current_Tileset = 0
	tileMain_tileSheet_selected_index = 0
	tileMain_tileSheet_selected_x = 0
	tileMain_tileSheet_selected_y = 0
	
	Gui_Surface_Clear(tileMain_tileSheetSurface)
	If ImageExists(Stage_Tileset_Image[0]) Then
		Gui_Surface_DrawImage(tileMain_tileSheetSurface, Stage_Tileset_Image[0], 0, 0)
	End If
	Gui_Surface_Update(tileMain_tileSheetSurface)
	
	For i = 0 to MAX_TILE_FRAMES-1
		Gui_ImageClip_SetSource(tileMain_frameSlide_frame[i], Stage_Tileset_Image[TileMain_Current_Tileset])
	Next
	Editor_tileMain_ImageSlide_Update()
	
	Return True
End Function

Function Editor_AddShape()
	System("rcbasic editor.cbc shape_addShapeButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	s_type = 0
	If Dlg_data$[0] = "RECT" Then
		s_type = SHAPE_TYPE_RECT
	Else
		s_type = SHAPE_TYPE_LINE
	End If
	x = Int(Val(Dlg_data$[1]))
	y = Int(Val(Dlg_data$[2]))
	p1 = Int(Val(Dlg_data$[3]))
	p2 = Int(Val(Dlg_data$[4]))
	Current_Shape = Stage_Layer_AddShape(Current_Layer, s_type, x, y, p1, p2)
	
	shape_num = Current_Shape
	shape_listbox_entry$ = ""
						
	Select Case Stage_Layer_Shape_Type[Current_Layer, shape_num]
	Case SHAPE_TYPE_LINE
		shape_listbox_entry$ = "LINE:"
	Case SHAPE_TYPE_RECT
		shape_listbox_entry$ = "RECT:"
	End Select
						
	Select Case Stage_Layer_Shape_Type[Current_Layer, shape_num]
	Case SHAPE_TYPE_LINE
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
	Case SHAPE_TYPE_RECT
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
	End Select
						
	shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]) + ", " + Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]) + ")-"
	shape_listbox_entry$ = shape_listbox_entry$ + "(" + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]) + ", " + Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]) + ")"
	Gui_ListBox_AddItem(shape_listBox, shape_listbox_entry$)
	Gui_ListBox_SetSelectedItem(shape_listBox, shape_num)
	Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]))
	Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]))
	Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]))
	Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]))
	Gui_ListBox_Update(shape_listBox)
	Shape_Current_Point = 0
	
	Return True
End Function

Function Editor_RemoveShape()
	If Stage_Layer_Shape_Count[Current_Layer] <= 0 Then
		Return 0
	End If
	Stage_Layer_RemoveShape(Current_Layer, Current_Shape)
	Gui_ListBox_RemoveItem(shape_listBox, Current_Shape)
	If Current_Shape >= Stage_Layer_Shape_Count[Current_Layer] Then
		Current_Shape = Current_Shape - 1
	End If
	If Current_Shape < 0 Then
		Current_Shape = 0
	End If
	Gui_ListBox_SetSelectedItem(shape_listBox, Current_Shape)
	Gui_ListBox_Update(shape_listBox)
	
	shape_num = Current_Shape
						
	Select Case Stage_Layer_Shape_Type[Current_Layer, shape_num]
	Case SHAPE_TYPE_LINE
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
	Case SHAPE_TYPE_RECT
		Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
	End Select
						
	Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[Current_Layer, shape_num]))
	Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[Current_Layer, shape_num]))
	Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 0]))
	Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[Current_Layer, shape_num, 1]))
	
	Shape_Current_Point = 0
	
	Return True
End Function

Function Editor_NewSprite()	
	Editor_Sprite_Backup
	System("rcbasic editor.cbc spriteMain_newSpriteButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	spr_file$ = Dlg_data$[0]
	frame_w = Int(Val(Dlg_data$[1]))
	frame_h = Int(Val(Dlg_data$[2]))
	
	spr_overwrite = False
	
	If spr_file$ <> "" Then
		If FileExists(SPRITE_PATH$ + Mid$(spr_file$, 0, FindLastOf(".", spr_file$)) + ".sprite") Then
			System("rcbasic editor.cbc spriteMain_newSprite_exists")
			Dlg_GetData
			If Dlg_data$[0] = "#NULL" Then
				Return False
			End If
			spr_overwrite = True
		End If
	End If
	
	'Need to check if sprite is in database and delete it if it isn't
	If stage_database_count > 0 Then
		sprite_isInDB = Editor_Sprite_inDatabase(SpriteMain_Current_Sprite)
		For i = 0 to stage_database_count-1
			If stage_database_sprite[i] = SpriteMain_Current_Sprite Then
				sprite_isInDB = True
				Exit For
			End If
		Next
		If Not sprite_isInDB Then
			DestroySprite(SpriteMain_Current_Sprite)
		End If
		
		If spr_overwrite Then
			spr_name$ = Mid$(spr_file$, 0, FindLastOf(".",spr_file$))
			For i = 0 to stage_database_count-1
				If Sprite_Name$[stage_database_sprite[i]] = spr_name$ Then
					DestroySprite(stage_database_sprite[i])
					Editor_RemoveSpriteFromDataBase(stage_database_sprite[i])
					Exit For
				End If
			Next
		End If
		
	End If
	
	spr = NewSprite(spr_file$, frame_w, frame_h)
	
	If spr < 0 Then
		Return False
	End If
	
	Gui_TextField_SetValue(spriteInfo_nameField, Sprite_Name$[spr])
	Gui_TextField_SetValue(spriteInfo_frameWidthField, Str$(Sprite_Frame_Width[spr]))
	Gui_TextField_SetValue(spriteInfo_frameHeightField, Str$(Sprite_Frame_Height[spr]))
	
	Gui_ListBox_Clear(spriteAnimation_animationListBox)
	Gui_Surface_Clear(spriteAnimation_spriteSheetSurface)
	Gui_Surface_DrawImage(spriteAnimation_spriteSheetSurface, Sprite_Image[spr], 0, 0)
	Gui_Surface_Update(spriteAnimation_spriteSheetSurface)
	Gui_ImageSlide_Clear(spriteAnimation_frameSlide)
	For i = 0 to MAX_SPRITE_ANIMATION_FRAMES-1
		Gui_ImageClip_SetSource(spriteAnimation_frameSlide_frame[i], Sprite_Image[spr])
	Next
	Gui_ImageClip_SetSource(spriteAnimation_previewClip, Sprite_Image[spr])
	spriteAnimation_spriteSheetSurface_offset_x = 0
	spriteAnimation_spriteSheetSurface_offset_y = 0
	Gui_TextField_SetValue(spriteAnimation_nameField, "")
	Gui_TextField_SetValue(spriteAnimation_FPSField, "")
	
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
	Gui_DropDown_SetSelectedItem(spriteBounds_shapeSelection, spriteBounds_shape_rect)
	
	SpriteMain_Current_Sprite = spr
	SpriteMain_SpriteAnimation_Current_Animation = 0
	
	Return True
End Function

Function Editor_LoadSprite()	
	Editor_Sprite_Backup
	System("rcbasic editor.cbc spriteMain_loadSpriteButton")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	spr_file$ = Dlg_data$[0]
	
	'Need to check if sprite is in database and delete it if it isn't
	If stage_database_count > 0 Then
		sprite_isInDB = Editor_Sprite_inDatabase(SpriteMain_Current_Sprite)
		For i = 0 to stage_database_count-1
			If stage_database_sprite[i] = SpriteMain_Current_Sprite Then
				sprite_isInDB = True
				Exit For
			End If
		Next
		If Not sprite_isInDB Then
			DestroySprite(SpriteMain_Current_Sprite)
		End If
		
	End If
	
	spr = LoadSprite(spr_file$)
	
	SpriteMain_Current_Sprite = spr
	
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
		Gui_TextField_SetValue(spriteAnimation_nameField, Sprite_Animation_Name$[spr, 0])
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
	
	Return True
End Function

Function Editor_NewActor()
	f = FreeFile
	FileOpen(f, "dlg_data.nb", TEXT_OUTPUT)
	
	WriteLine(f, Str$(stage_database_count))
	If stage_database_count > 0 Then
		For i = 0 to stage_database_count-1
			WriteLine(f, Sprite_Name$[i])
			WriteLine(f, Str$(Sprite_NumAnimations[i]))
			If Sprite_NumAnimations[i] > 0 Then
				For anim = 0 to Sprite_NumAnimations[i]-1
					WriteLine(f, Sprite_Animation_Name$[i, anim])
				Next
			End If
		Next
	End If
	
	FileClose(f)
	
	System("rcbasic editor.cbc editor_ActorOptions")
	Dlg_GetData
	If Dlg_data$[0] = "#NULL" Then
		Return False
	End If
	
	a_name$ = Dlg_data$[0]
	s_name$ = Dlg_data$[1]
	s_anim$ = Dlg_data$[2]
	
	If actor_database_count < MAX_ACTORS Then
		actor_database_actor[actor_database_count] = NewActor(a_name$, GetSpriteID(s_name$))
		Actor_SetAnimationByName(actor_database_actor[actor_database_count], s_anim$)
		If actor_database_count = 0 Then
			Current_Actor = 0
			Gui_TextField_SetValue(actor_name_field, a_name$)
			Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[actor_database_count]))
			Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[actor_database_count]))
			Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[actor_database_count]))
			Editor_SetActorClip
		End If
		actor_database_count = actor_database_count + 1
	End If
	
	Gui_ListBox_AddItem(actor_listBox, a_name$)
	Gui_ListBox_Update(actor_listBox)
End Function

Function Editor_ActorEdit_Update()
	selected_actor = Gui_ListBox_GetSelectedItem(actor_listBox)
	If selected_actor <> Current_Actor And selected_actor >= 0 And selected_actor < actor_database_count Then
		Current_Actor = selected_actor
		'Print "Current Actor = ";Current_Actor
		a = actor_database_actor[Current_Actor]
		Gui_TextField_SetValue(actor_name_field, Actor_Name$[a])
		Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[a]))
		Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[a]))
		Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[a]))
		Editor_SetActorClip
	End If
	
	If Gui_Button_Clicked(actor_addButton) Then
		Editor_NewActor
	ElseIf Gui_Button_Clicked(actor_removeButton) And Current_Actor < actor_database_count Then
		RemoveActor(Current_Actor)
		Gui_ListBox_RemoveItem(actor_listBox, Current_Actor)
		If Current_Actor <= actor_database_count Then
			For i = Current_Actor To actor_database_count-1
				actor_database_actor[i] = actor_database_actor[i+1]
			Next
		End If
		If stage_database_count > 0 Then
			stage_database_count = stage_database_count - 1
		End If
		If stage_database_count > 0 And Current_Actor >= stage_database_count Then
			Current_Actor = Current_Actor - 1
		End If
		If stage_database_count > 0 Then
			Gui_ListBox_SetSelectedItem(actor_listBox, Current_Actor)
			a = actor_database_actor[Current_Actor]
			Gui_TextField_SetValue(actor_name_field, Actor_Name$[a])
			Gui_TextField_SetValue(actor_positionX_field, Str$(Actor_X[a]))
			Gui_TextField_SetValue(actor_positionY_field, Str$(Actor_Y[a]))
			Gui_TextField_SetValue(actor_layer_field, Str$(Actor_Layer[a]))
		Else
			Gui_TextField_SetValue(actor_name_field, " ")
			Gui_TextField_SetValue(actor_positionX_field, " ")
			Gui_TextField_SetValue(actor_positionY_field, " ")
			Gui_TextField_SetValue(actor_layer_field, " ")
		End If
		Gui_ListBox_Update(actor_listBox)
	ElseIf Gui_TextField_Return(actor_positionX_field) Or Gui_TextField_Return(actor_positionY_field) Or Gui_TextField_Return(actor_layer_field) Then
		px = Int(Val(Gui_TextField_GetValue$(actor_positionX_field)))
		py = Int(Val(Gui_TextField_GetValue$(actor_positionY_field)))
		l = Int(Val(Gui_TextField_GetValue$(actor_layer_field)))
		Actor_SetPosition(Current_Actor, px, py)
		Actor_SetLayer(Current_Actor, l)
		Gui_TextField_SetValue(actor_positionX_field, Str$(px))
		Gui_TextField_SetValue(actor_positionY_field, Str$(py))
		Gui_TextField_SetValue(actor_layer_field, Str$(l))
	ElseIf Gui_TextField_Return(actor_name_field) Then
		Actor_Name$[actor_database_actor[Current_Actor]] = Gui_TextField_GetValue$(actor_name_field)
		Gui_ListBox_SetValue(actor_listBox, actor_database_actor[Current_Actor], Actor_Name$[actor_database_actor[Current_Actor]])
		Gui_ListBox_Update(actor_listBox)
	End If
End Function

Function Editor_Main()
	'Editor_SetLayer(0)
	
	While WindowExists(main_window)
		If key(k_escape) Then
			end
		End If
		
		n = Gui_DropDown_GetSelectedItem(stageView_layerSelection)
		
		If n <> Current_Layer Then
			Editor_SetLayer(n)
		End If
		
		n = Gui_DropDown_GetSelectedItem(tileSelect_sheetSelect)
		
		If n <> TileSelect_Current_Tileset Then
			TileSelect_Current_Tileset = n
		End If
		
		
		If Gui_Button_Clicked(top_menu_newButton) Then
			Editor_NewStage
			tileMain_tileSheet_offset_x = 0
			tileMain_tileSheet_offset_y = 0
			spriteAnimation_spriteSheetSurface_offset_x = 0
			spriteAnimation_spriteSheetSurface_offset_y = 0
			spriteBounds_spriteSheetSurface_offset_x = 0
			spriteBounds_spriteSheetSurface_offset_y = 0
		ElseIf Gui_Button_Clicked(top_menu_loadButton) Then
			Editor_LoadStage
		ElseIf Gui_Button_Clicked(top_menu_saveButton) Then
			Editor_SaveStage
		ElseIf Gui_Button_Clicked(background_propertiesButton) Then
			Editor_Bkg_Properties
		ElseIf Gui_Button_Clicked(background_loadImageButton) Then
			Editor_Bkg_LoadImage
		ElseIf Gui_Button_Clicked(background_setColorButton) Then
			Editor_Bkg_SetColor
		ElseIf Gui_Button_Clicked(background_ClearImageButton) Then
			Editor_Bkg_ClearImage
		ElseIf Gui_Button_Clicked(tileMain_loadButton) Then
			Editor_LoadTileset
		ElseIf Gui_Button_Clicked(tileMain_saveButton) Then
			Editor_SaveTileset
		ElseIf Gui_Button_Clicked(shape_addButton) Then
			Editor_AddShape
		ElseIf Gui_Button_Clicked(shape_removeButton) Then
			Editor_RemoveShape
		ElseIf Gui_Button_Clicked(spriteMain_newButton) Then
			Editor_NewSprite
		ElseIf Gui_Button_Clicked(spriteMain_saveButton) Then
			SaveSprite(SpriteMain_Current_Sprite)
		ElseIf Gui_Button_Clicked(spriteMain_loadButton) Then
			Editor_LoadSprite
		End If
		
		current_main_tab = Gui_TabGroup_GetActiveTab(main_tabGroup)
		
		If current_main_tab = main_tabGroup_stageTab Then
			current_info_tab = Gui_TabGroup_GetActiveTab(info_tabGroup)
			If current_info_tab = info_layerTab Then
				For i = 0 to MAX_LAYERS-1
					Stage_Layer_Type[i] = Gui_DropDown_GetSelectedItem(layerInfo_typeSelect[i])
				Next
			End If
			
			selected_shape = Gui_ListBox_GetSelectedItem(shape_listBox)
			
			If selected_shape <> Current_Shape Then
				Current_Shape = selected_shape
				Shape_Current_Point = 0
				Select Case Stage_Layer_Shape_Type[Current_Layer, Current_Shape]
				Case SHAPE_TYPE_LINE
					Gui_DropDown_SetSelectedItem(shape_type_selection, shape_line)
				Case SHAPE_TYPE_RECT
					Gui_DropDown_SetSelectedItem(shape_type_selection, shape_rect)
				End Select
				Gui_TextField_SetValue(shape_positionX_field, Str$(Stage_Layer_Shape_X[Current_Layer, Current_Shape]))
				Gui_TextField_SetValue(shape_positionY_field, Str$(Stage_Layer_Shape_Y[Current_Layer, Current_Shape]))
				Gui_TextField_SetValue(shape_parameter1_field, Str$(Stage_Layer_Shape_Param[Current_Layer, Current_Shape, 0]))
				Gui_TextField_SetValue(shape_parameter2_field, Str$(Stage_Layer_Shape_Param[Current_Layer, Current_Shape, 1]))
			End If
			
			Editor_ActorEdit_Update
			Editor_tileSelect_Update
			Editor_stageView_Update
		ElseIf current_main_tab = main_tabGroup_tileTab Then
			n = Gui_DropDown_GetSelectedItem(tileMain_tileSheetSelection)
		
			If n <> TileMain_Current_Tileset Then
				TileMain_Current_Tileset = n
				For i = 0 to MAX_TILE_FRAMES-1
					Gui_ImageClip_SetSource(tileMain_frameSlide_frame[i], Stage_Tileset_Image[TileMain_Current_Tileset])
				Next
				Editor_tileMain_ImageSlide_Update
			End If
			
			Editor_tileMain_Update
		ElseIf current_main_tab = main_tabGroup_spriteTab Then
			current_anim = Gui_ListBox_GetSelectedItem(spriteAnimation_animationListBox)
			If SpriteMain_SpriteAnimation_Current_Animation <> current_anim Then
				Editor_spriteAnimation_setSelectedAnimation(current_anim)
			End If
			Editor_spriteMain_Update
		End If
		
		Gui_Update
	Wend
End Function
