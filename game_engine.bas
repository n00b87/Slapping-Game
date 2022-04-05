Include "n00b-engine/strings.bas"
Include "n00b-engine/math_util.bas"
Include "n00b-engine/joystick.bas"
Include "n00b-engine/simple_touch.bas"

ENGINE_VERSION = 1

ENGINE_EDITOR_USE = False

Dim STAGE_SCREEN_POS_X
Dim STAGE_SCREEN_POS_Y
Dim STAGE_SCREEN_WIDTH
Dim STAGE_SCREEN_HEIGHT

Dim ACTOR_PATH$
Dim FONT_PATH$
Dim BKG_PATH$
Dim GUI_PATH$
Dim STAGE_PATH$
Dim MUSIC_PATH$
Dim SFX_PATH$
Dim SPRITE_PATH$
Dim TILE_PATH$
Dim VIDEO_PATH$

Dim ENGINE_DIR$

If Trim$(Env("ENGINE_DIR")) <> "" Then
	ENGINE_DIR$ = Env("ENGINE_DIR")
Else
	ENGINE_DIR$ = Dir$
End If

Print ENGINE_DIR$

If OS = "WINDOWS" Then
	ACTOR_PATH$ = ENGINE_DIR$ + "\\actor\\"
	BKG_PATH$ = ENGINE_DIR$ + "\\bkg\\"
	FONT_PATH$ = ENGINE_DIR$ + "\\font\\"
	GUI_PATH$ = ENGINE_DIR$ + "\\gui_gfx\\"
	STAGE_PATH$ = ENGINE_DIR$ + "\\stage\\"
	MUSIC_PATH$ = ENGINE_DIR$ + "\\music\\"
	SFX_PATH$ = ENGINE_DIR$ + "\\sfx\\"
	SPRITE_PATH$ = ENGINE_DIR$ + "\\sprite\\"
	TILE_PATH$ = ENGINE_DIR$ + "\\tile\\"
	VIDEO_PATH$ = ENGINE_DIR$ + "\\video\\"
Else
	ACTOR_PATH$ = ENGINE_DIR$ + "/actor/"
	BKG_PATH$ = ENGINE_DIR$ + "/bkg/"
	FONT_PATH$ = ENGINE_DIR$ + "/font/"
	GUI_PATH$ = ENGINE_DIR$ + "/gui_gfx/"
	STAGE_PATH$ = ENGINE_DIR$ + "/stage/"
	MUSIC_PATH$ = ENGINE_DIR$ + "/music/"
	SFX_PATH$ = ENGINE_DIR$ + "/sfx/"
	SPRITE_PATH$ = ENGINE_DIR$ + "/sprite/"
	TILE_PATH$ = ENGINE_DIR$ + "/tile/"
	VIDEO_PATH$ = ENGINE_DIR$ + "/video/"
End If

MAX_IMAGES = 1024
MAX_TILESETS = 4
MAX_TILES = 2048
MAX_SHAPES_PER_LAYER = 512
MAX_STAGE_IMAGES = 12
MAX_LAYERS = 5
MAX_TILE_FRAMES = 4
MAX_SPRITES = 50
MAX_SPRITE_FRAMES = 2048
MAX_SPRITE_ANIMATIONS = 512
MAX_SPRITE_ANIMATION_FRAMES = 8
MAX_ACTORS = 512

'Stage Structure
'Stage Name
Dim Stage_Name$
Dim Stage_Version

'Dimensions
Dim Stage_Tile_Width 'In tiles
Dim Stage_Tile_Height 'In tiles
Dim Stage_Pixel_Width
Dim Stage_Pixel_Height

'Layer Info
Dim STAGE_LAYER_TYPE_NONE
Dim STAGE_LAYER_TYPE_TILE
Dim STAGE_LAYER_TYPE_BKG

STAGE_LAYER_TYPE_NONE = 0
STAGE_LAYER_TYPE_TILE = 1
STAGE_LAYER_TYPE_BKG = 2

Dim Stage_Layer_Type[MAX_LAYERS] 'Type can be tile or image
Dim Stage_Layer_Active[MAX_LAYERS]
Dim Stage_Layer_ColDet[MAX_LAYERS]
Dim Stage_Layer_Physics[MAX_LAYERS]
Dim Stage_Physics_Gravity

'Tileset
Dim Stage_Tileset_Tile_Width
Dim Stage_Tileset_Tile_Height
Dim Stage_Tileset_Tile_FPS
Dim Stage_Tileset_Tile_Delay '1000 / FPS
Dim Stage_Tileset_CurrentTime
Dim Stage_Tileset_ImageIsLoaded[MAX_TILESETS]
Dim Stage_Tileset_File$[MAX_TILESETS]
Dim Stage_Tileset_Version[MAX_TILESETS]
Dim Stage_Tileset_NumTiles[MAX_TILESETS]
Dim Stage_Tileset_Image[MAX_TILESETS]
Dim Stage_Tileset_Image_Width[MAX_TILESETS]
Dim Stage_Tileset_Image_Height[MAX_TILESETS]
Dim Stage_Tileset_Image_WidthInTiles[MAX_TILESETS]
Dim Stage_Tileset_Image_HeightInTiles[MAX_TILESETS]
Dim Stage_Tileset_Tile_NumFrames[MAX_TILESETS, MAX_TILES]
Dim Stage_Tileset_Tile_Frame[MAX_TILESETS, MAX_TILES, MAX_TILE_FRAMES]
Dim Stage_Tileset_Tile_CurrentFrame[MAX_TILESETS, MAX_TILES]
Dim Stage_Tileset_Tile_CurrentTime[MAX_TILESETS, MAX_TILES]

'Background Layer
Dim STAGE_LAYER_BKG_TYPE_IMAGE
Dim STAGE_LAYER_BKG_TYPE_SURFACE

Dim STAGE_LAYER_BKG_FLAG_NONE
Dim STAGE_LAYER_BKG_FLAG_TILED
Dim STAGE_LAYER_BKG_FLAG_STRETCHED
Dim STAGE_LAYER_BKG_FLAG_BLIT
Dim STAGE_LAYER_BKG_FLAG_SCROLL

STAGE_LAYER_BKG_TYPE_IMAGE = 0
STAGE_LAYER_BKG_TYPE_SURFACE = 1

Stage_LAYER_BKG_FLAG_NONE = 0
Stage_LAYER_BKG_FLAG_TILED = 1
Stage_LAYER_BKG_FLAG_STRETCHED = 2
Stage_LAYER_BKG_FLAG_BLIT = 3
STAGE_LAYER_BKG_FLAG_SCROLL = 4

Dim Stage_Layer_Bkg_ImageIsLoaded[MAX_LAYERS]
Dim Stage_Layer_Bkg_Image_W[MAX_LAYERS]
Dim Stage_Layer_Bkg_Image_H[MAX_LAYERS]
Dim Stage_Layer_Bkg_File$[MAX_LAYERS]
Dim Stage_Layer_Bkg_Image[MAX_LAYERS]
Dim Stage_Layer_Bkg_Flag[MAX_LAYERS]
Dim Stage_Layer_Bkg_Type[MAX_LAYERS]
Dim Stage_Layer_Bkg_ZoomX[MAX_LAYERS]
Dim Stage_Layer_Bkg_ZoomY[MAX_LAYERS]
Dim Stage_Layer_Bkg_Angle[MAX_LAYERS]
Dim Stage_Layer_Bkg_BlitX[MAX_LAYERS]
Dim Stage_Layer_Bkg_BlitY[MAX_LAYERS]
Dim Stage_Layer_Bkg_BlitW[MAX_LAYERS]
Dim Stage_Layer_Bkg_BlitH[MAX_LAYERS]
Dim Stage_Layer_Bkg_Color[MAX_LAYERS, 3]
Dim Stage_Layer_Bkg_Alpha[MAX_LAYERS]
Dim Stage_Layer_Bkg_Scroll_HSpeed[MAX_LAYERS]
Dim Stage_Layer_Bkg_Scroll_VSpeed[MAX_LAYERS]

'Stage Tile Data
MAX_STAGE_WIDTH = 512
MAX_STAGE_HEIGHT = 512

Dim Stage_Layer_Tile_Tileset[MAX_LAYERS, MAX_STAGE_HEIGHT, MAX_STAGE_WIDTH]
Dim Stage_Layer_Tile_Data[MAX_LAYERS, MAX_STAGE_HEIGHT, MAX_STAGE_WIDTH]


'Stage Shape Data
MAX_SECTORS_ACROSS = 30
MAX_SECTORS_DOWN = 30
MAX_SHAPES_PER_SECTOR = 50
Dim SHAPE_TYPE_RECT
Dim SHAPE_TYPE_LINE
Dim SHAPE_TYPE_NULL
Dim SHAPE_TYPE_CIRCLE
Dim SHAPE_TYPE_DYNARECT
SHAPE_TYPE_NULL = 0
SHAPE_TYPE_RECT = 1
SHAPE_TYPE_LINE = 2
SHAPE_TYPE_CIRCLE = 3
SHAPE_TYPE_DYNARECT = 4

Dim Stage_Layer_Shape_Count[MAX_LAYERS]
Dim Stage_Layer_Shape_Type[MAX_LAYERS, MAX_SHAPES_PER_LAYER]
Dim Stage_Layer_Shape_X[MAX_LAYERS, MAX_SHAPES_PER_LAYER]
Dim Stage_Layer_Shape_Y[MAX_LAYERS, MAX_SHAPES_PER_LAYER]
Dim Stage_Layer_Shape_Param[MAX_LAYERS, MAX_SHAPES_PER_LAYER, 2]
Dim Stage_Layer_Shape_Attribute[MAX_LAYERS, MAX_SHAPES_PER_LAYER, 2]
Dim Stage_Layer_Shape_AddValue[MAX_LAYERS]
Dim Stage_Layer_Shape_Actor[MAX_LAYERS, MAX_SHAPES_PER_LAYER]
'Dim Stage_Layer_Shape_Sector[MAX_LAYERS, MAX_SHAPES_PER_LAYER, (MAX_SECTORS_ACROSS*MAX_SECTORS_DOWN)]

'Sectors

Dim Stage_Sector_Shape_Index[MAX_SECTORS_ACROSS, MAX_SECTORS_DOWN, MAX_SHAPES_PER_SECTOR]
Dim Stage_Sector_Shape_Layer[MAX_SECTORS_ACROSS, MAX_SECTORS_DOWN, MAX_SHAPES_PER_SECTOR]
Dim Stage_Sector_X[MAX_SECTORS_ACROSS, MAX_SECTORS_DOWN]
Dim Stage_Sector_Y[MAX_SECTORS_ACROSS, MAX_SECTORS_DOWN]
Dim Stage_Sector_Width
Dim Stage_Sector_Height
Dim Stage_Sector_NumShapes[MAX_SECTORS_ACROSS, MAX_SECTORS_DOWN]

'Stage Actors
Dim Stage_Layer_NumActors[MAX_LAYERS]
Dim Stage_Layer_Actor[MAX_LAYERS, MAX_ACTORS]

'Actors
Dim Actor_Visible[MAX_ACTORS]
Dim Actor_Active[MAX_ACTORS]
Dim Actor_Name$[MAX_ACTORS]
Dim Actor_inUse[MAX_ACTORS]
Dim Actor_Layer[MAX_ACTORS]
Dim Actor_LayerPosition[MAX_ACTORS]
Dim Actor_Sprite[MAX_ACTORS]
Dim Actor_X[MAX_ACTORS]
Dim Actor_Y[MAX_ACTORS]
Dim Actor_NewX[MAX_ACTORS]
Dim Actor_NewY[MAX_ACTORS]
Dim Actor_ZX[MAX_ACTORS]
Dim Actor_ZY[MAX_ACTORS]
Dim Actor_Angle[MAX_ACTORS]
Dim Actor_Physics[MAX_ACTORS]
Dim Actor_Speed[MAX_ACTORS]
Dim Actor_Momentum[MAX_ACTORS]
Dim Actor_Physics_State[MAX_ACTORS]
Dim Actor_Solid_State[MAX_ACTORS]
Dim Actor_Solid_Priority[MAX_ACTORS]
Dim Actor_Jump[MAX_ACTORS]
Dim Actor_Weight[MAX_ACTORS]
Dim Actor_DynaRect_SpeedAdjust[MAX_ACTORS,2]
Dim Actor_Contact_Shape[MAX_ACTORS]

Dim PHYSICS_STATE_GROUND
Dim PHYSICS_STATE_RISE
Dim PHYSICS_STATE_FALL

PHYSICS_STATE_GROUND = 2
PHYSICS_STATE_RISE = 1
PHYSICS_STATE_FALL = 0

Dim Actor_Force_X[MAX_ACTORS]
Dim Actor_Force_Y[MAX_ACTORS]
Dim Actor_Force_Acceleration[MAX_ACTORS]
Dim Actor_Force_Speed[MAX_ACTORS]

Dim Actor_CurrentAnimation[MAX_ACTORS]
Dim Actor_CurrentFrame[MAX_ACTORS]
Dim Actor_CurrentFrameTime[MAX_ACTORS]
Dim Actor_CurrentFrameDelay[MAX_ACTORS]
Dim Actor_AnimationSync[MAX_ACTORS]
Dim Actor_AnimationParent[MAX_ACTORS]

'Dynamic Rect
Dim Actor_Shape[MAX_ACTORS]
Dim Actor_Shape_Layer[MAX_ACTORS]

Dim Actor_Move_Flag[MAX_ACTORS]

'Actor Offset From another actor
Dim Actor_OffsetActor[MAX_ACTORS, 3]

'Actor Collision and Physics
MAX_STAGE_COLLISIONS = 20
Dim Actor_NumStageCollisions[MAX_ACTORS]
Dim Actor_Stage_Collision_X[MAX_ACTORS, MAX_STAGE_COLLISIONS]
Dim Actor_Stage_Collision_Y[MAX_ACTORS, MAX_STAGE_COLLISIONS]
Dim Actor_Stage_Collision_From_Direction[MAX_ACTORS, MAX_STAGE_COLLISIONS]
Dim Actor_Collision_Inside_Shape[MAX_ACTORS]


Dim MAX_ACTOR_COLLISIONS
MAX_ACTOR_COLLISIONS = 5

Dim Actor_Collision[MAX_ACTORS]
Dim Actor_CollisionActor[MAX_ACTORS, MAX_ACTOR_COLLISIONS]
Dim Actor_ParentActor[MAX_ACTORS]
Dim Actor_ChildActor[MAX_ACTORS]
Dim Actor_NumActorCollisions[MAX_ACTORS]
Dim Actor_Persistent[MAX_ACTORS]

Dim Stage_SolidActors[MAX_ACTORS]
Dim Stage_NumSolidActors


'Sprites
Dim Sprite_Version[MAX_SPRITES]
Dim Sprite_Name$[MAX_SPRITES]
Dim Sprite_Image[MAX_SPRITES]
Dim Sprite_Image_W[MAX_SPRITES]
Dim Sprite_Image_H[MAX_SPRITES]
Dim Sprite_Image_WidthInFrames[MAX_SPRITES]
Dim Sprite_Image_HeightInFrames[MAX_SPRITES]
Dim Sprite_inUse[MAX_SPRITES]
Dim Sprite_Visible[MAX_SPRITES]
Dim Sprite_Frame_Width[MAX_SPRITES]
Dim Sprite_Frame_Height[MAX_SPRITES]
Dim Sprite_NumFrames[MAX_SPRITES]
Dim Sprite_NumAnimations[MAX_SPRITES]

Dim Sprite_Frame_Bound_Shape[MAX_SPRITES]
Dim Sprite_Frame_Bound_X[MAX_SPRITES, MAX_SPRITE_FRAMES]
Dim Sprite_Frame_Bound_Y[MAX_SPRITES, MAX_SPRITE_FRAMES]
Dim Sprite_Frame_Bound_Param[MAX_SPRITES, MAX_SPRITE_FRAMES, 2]

Dim Sprite_Animation_Name$[MAX_SPRITES, MAX_SPRITE_ANIMATIONS]
Dim Sprite_Animation_NumFrames[MAX_SPRITES, MAX_SPRITE_ANIMATIONS]
Dim Sprite_Animation_FPS[MAX_SPRITES, MAX_SPRITE_ANIMATIONS]
Dim Sprite_Animation_Delay[MAX_SPRITES] 'Recalc everytime animation is changed
Dim Sprite_Animation_Frame[MAX_SPRITES, MAX_SPRITE_ANIMATIONS, MAX_SPRITE_ANIMATION_FRAMES]


'Engine Rendering Stuff
Dim Stage_offset_x
Dim Stage_offset_y
Dim Stage_Viewport_w
Dim Stage_Viewport_h

Sub Engine_Init()
	For i = 0 to MAX_LAYERS-1
		Stage_Layer_NumActors[i] = 0
	Next
	Stage_Sector_Width = 640
	Stage_Sector_Height = 480
End Sub

Sub Num32_To_ByteArray(num32, byref byte_array)
	byte_array[0] = AndBit( (num32 shr 24), 255) 
	byte_array[1] = AndBit( (num32 shr 16), 255)
	byte_array[2] = AndBit( (num32 shr 8), 255)
	byte_array[3] = AndBit( num32, 255)
End Sub

Function ByteArray_To_Num32(byref byte_array)
	num32 = (byte_array[0] shl 24) + (byte_array[1] shl 16) + (byte_array[2] shl 8) + byte_array[3]
	Return num32
End Function

Sub Write32(stream, num32)
	Dim byte_array[4]
	Num32_To_ByteArray(num32, byte_array)
	WriteByte(stream, byte_array[0])
	WriteByte(stream, byte_array[1])
	WriteByte(stream, byte_array[2])
	WriteByte(stream, byte_array[3])
End Sub

Function Read32(stream)
	Dim byte_array[4]
	byte_array[0] = ReadByte(stream)
	byte_array[1] = ReadByte(stream)
	byte_array[2] = ReadByte(stream)
	byte_array[3] = ReadByte(stream)
	Return ByteArray_To_Num32(byte_array)
End Function

'Manage Image Slots
Function GetFreeImage()
	For i = 0 to MAX_IMAGES-1
		If Not ImageExists(i) Then
			Return i
		End If
	Next
	Return -1
End Function

'ACTOR FUNCTIONS
Function NewActor(a_name$, spr)
	a_index = -1
	For i = 0 To MAX_ACTORS-1
		If Not Actor_inUse[i] Then
			a_index = i
			Actor_inUse[a_index] = True
			Exit For
		End If
	Next
	If a_index = -1 Then
		Return -1
	End If
	Actor_Name$[a_index] = a_name$
	Actor_Sprite[a_index] = spr
	Actor_Layer[a_index] = -1
	Actor_LayerPosition[a_index] = -1
	Actor_ZX[a_index] = 1
	Actor_ZY[a_index] = 1
	Actor_Angle[a_index] = 0
	Actor_CurrentAnimation[a_index] = 0
	Actor_Visible[a_index] = true
	Actor_Active[a_index] = true
	Actor_AnimationSync[a_index] = false
	Actor_ParentActor[a_index] = -1
	Actor_Shape[a_index] = -1
	Actor_OffsetActor[a_index, 0] = -1
	Actor_Collision[a_index] = true
	Return a_index
End Function

Function SaveActor(actor)
	If actor < 0 Or actor >= MAX_ACTORS Or (Not Actor_inUse[actor]) Then
		Return 0
	End If
	
	a_file$ = Actor_Name$[actor] + ".actor"
	
	If FileExists(ACTOR_PATH$ + a_file$) Then
		RemoveFile(ACTOR_PATH$ + a_file$)
	End If
	
	f = FreeFile
	
	spr = Actor_Sprite[actor]
	
	FileOpen(f, ACTOR_PATH$ + a_file$, TEXT_OUTPUT)
	WriteLine(f, Sprite_Name$[spr])
	WriteLine(f, Str$(Actor_CurrentAnimation[spr]))
	FileClose(f)
	
End Function

Function GetActorID(a_name$)
	For i = 0 to MAX_ACTORS-1
		If Actor_Name$[i] = a_name$ Then
			Return i
		End If
	Next
	Return -1
End Function

Function GetSpriteID(s_name$)
	For i = 0 to MAX_SPRITES-1
		If Sprite_Name$[i] = s_name$ Then
			Return i
		End If
	Next
	Return -1
End Function

Function LoadActor(a_name$)
	actor = -1
	For i = 0 to MAX_ACTORS-1
		If Not Actor_inUse[i] Then
			actor = i
			Exit For
		End If
	Next
	
	If actor = -1 Then
		Return -1
	End If
	
	a_file$ = Actor_Name$[actor] + ".actor"
	
	If FileExists(ACTOR_PATH$ + a_file$) Then
		RemoveFile(ACTOR_PATH$ + a_file$)
	End If
	
	f = FreeFile
	
	FileOpen(f, ACTOR_PATH$ + a_file$, TEXT_INPUT)
	s_name$ = ReadLine(f)
	s_anim = Val(ReadLine(f))
	FileClose(f)
	
	Actor_Sprite[actor] = GetSpriteID(s_name$)
	Actor_CurrentAnimation[actor] = s_anim
	Actor_inUse[actor] = True
	Actor_Layer[actor] = -1
	Actor_LayerPosition[actor] = -1
	Actor_Active[actor] = true
	Actor_Visible[actor] = true
	Actor_AnimationSync[actor] = false
	Actor_Collision[actor] = true
	Return actor
End Function

Sub RemoveActor(actor)
	a_layer = Actor_Layer[actor]
	a_pos = Actor_LayerPosition[actor]
	
	If a_layer >= 0 Then
		If Stage_Layer_NumActors[a_layer] > 0 Then
			
			num_to_sort = Stage_Layer_NumActors[a_layer] - a_pos - 1
			
			'Print "apos = ";a_pos
			'Print "num to sort = ";num_to_sort
			'Print Stage_Layer_Actor[a_layer, a_pos];" should be ";actor
			
			For i = a_pos to a_pos + num_to_sort
				Stage_Layer_Actor[a_layer, i] = Stage_Layer_Actor[a_layer, i+1]
				Actor_LayerPosition[ Stage_Layer_Actor[a_layer, i] ] = i
			Next
			
			Stage_Layer_NumActors[a_layer] = Stage_Layer_NumActors[a_layer] - 1
			Actor_Layer[actor] = -1
			Actor_LayerPosition[actor] = -1
			Actor_AnimationSync[actor] = false
		End If
	End If
End Sub

Sub DestroyActor(actor)
	RemoveActor(actor)
	Actor_inUse[actor] = False
	Actor_AnimationSync[actor] = false
End Sub

Function Actor_SetLayer(actor, layer)
	If layer < 0 Then
		Return False
	End If
	If Stage_Layer_NumActors[layer] >= MAX_ACTORS Then
		Return False
	End If
	
	If Actor_Layer[actor] <> layer Then
		RemoveActor(actor)
		pos = Stage_Layer_NumActors[layer]
		Stage_Layer_NumActors[layer] = pos + 1
		Stage_Layer_Actor[layer, pos] = actor
	
		Actor_Layer[actor] = layer
		Actor_LayerPosition[actor] = pos
	End If
		
	Return True
End Function

Function Actor_SetAnimation(actor, anim)
	If anim >= Sprite_NumAnimations[Actor_Sprite[actor]] Then
		Return False
	End If
	If anim = Actor_CurrentAnimation[actor] Then
		Return True
	End If
	Actor_CurrentAnimation[actor] = anim
	sprite = Actor_Sprite[actor]
	Actor_CurrentFrameDelay[actor] = 1000 / Max(1, Sprite_Animation_FPS[sprite, anim])
	Actor_CurrentFrameTime[actor] = Timer
	Return True
End Function

Function Actor_SetAnimationByName(actor, a_name$)
	s = Actor_Sprite[actor]
	If Sprite_NumAnimations[s] <= 0 Then
		Return False
	End If
	anim = -1
	For i = 0 to Sprite_NumAnimations[s]-1
		If Sprite_Animation_Name$[s, i] = a_name$ Then
			anim = i
			Exit For
		End If
	Next
	If anim = -1 Then
		Return False
	End If
	If anim = Actor_CurrentAnimation[actor] Then
		Return True
	End If
	Actor_CurrentAnimation[actor] = anim
	sprite = Actor_Sprite[actor]
	Actor_CurrentFrameDelay[actor] = 1000 / Max(1, Sprite_Animation_FPS[sprite, anim])
	Actor_CurrentFrameTime[actor] = Timer
	Return True
End Function

Function Actor_GetAnimationName$(actor, n)
	Return Sprite_Animation_Name$[ Actor_Sprite[actor], n]
End Function

Sub Actor_SetAnimationFrame(actor, frame)
	Actor_CurrentFrame[actor] = frame
	Actor_CurrentFrameDelay[actor] = 1000 / Max(1, Sprite_Animation_FPS[Actor_Sprite[actor], Actor_CurrentAnimation[actor]])
	Actor_CurrentFrameTime[actor] = Timer
End Sub

Sub Actor_SetVisible(actor, flag)
	Actor_Visible[actor] = flag
End Sub

Function Actor_isVisible(actor)
	Return Actor_Visible[actor]
End Function

Sub Actor_SetActive(actor, flag)
	Actor_Active[actor] = flag
End Sub

Function Actor_isActive(actor)
	Return Actor_Active[actor]
End Function

Function Actor_GetDistance(actor1, actor2)
	Return getDistance(Actor_X[actor1], Actor_Y[actor1], Actor_X[actor2], Actor_Y[actor2])
End Function

Sub DrawActor(actor)
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
	DrawImage_Blit_Ex(img, x, y, w, h, src_x, src_y, src_w, src_h)
End Sub

Dim COLLISION_DIR_RIGHT
Dim COLLISION_DIR_LEFT
Dim COLLISION_DIR_TOP
Dim COLLISION_DIR_BOTTOM
Dim COLLISION_DIR_LINE
Dim COLLISION_LINE_P1[MAX_STAGE_COLLISIONS]
Dim COLLISION_LINE_P2[MAX_STAGE_COLLISIONS]
Dim COLLISION_LINE_P3[MAX_STAGE_COLLISIONS]
Dim COLLISION_LINE_P4[MAX_STAGE_COLLISIONS]

Dim COLLISION_LINE_LEFT
Dim COLLISION_LINE_RIGHT
Dim COLLISION_LINE_TOP
Dim COLLISION_LINE_BOTTOM

COLLISION_DIR_LEFT = 1
COLLISION_DIR_RIGHT = 2
COLLISION_DIR_TOP = 3
COLLISION_DIR_BOTTOM = 4
COLLISION_DIR_LINE = 5
COLLISION_LINE_LEFT = 6
COLLISION_LINE_RIGHT = 7
COLLISION_LINE_TOP = 8
COLLISION_LINE_BOTTOM = 9

Include "lines.bas"

Function Actor_isOnScreen(actor)
	x = Actor_X[actor] + Sprite_Frame_Bound_X[ Actor_Sprite[actor], 0 ]
	y = Actor_Y[actor] + Sprite_Frame_Bound_Y[ Actor_Sprite[actor], 0 ]
	w = Sprite_Frame_Bound_Param[ Actor_Sprite[actor], 0, 0]
	h = Sprite_Frame_Bound_Param[ Actor_Sprite[actor], 0, 1]
	
	'If Actor_Name[actor] = "graizor_blaster" Then
	'	Print "BLASTER: ";x;", ";y;", ";w;", ";h
	'	Print "Stage: ";Stage_offset_x;", ";Stage_offset_y;", ";STAGE_SCREEN_WIDTH;", ";STAGE_SCREEN_HEIGHT
	'End If
	
	If (x+w) >= Stage_offset_x And x < (Stage_offset_x + STAGE_SCREEN_WIDTH) And (y+h) >= Stage_offset_y And y < (Stage_offset_y + STAGE_SCREEN_HEIGHT) Then
		Return True
	End If
	
	x = Actor_NewX[actor] + Sprite_Frame_Bound_X[ Actor_Sprite[actor], 0 ]
	y = Actor_NewY[actor] + Sprite_Frame_Bound_Y[ Actor_Sprite[actor], 0 ]
	
	If (x+w) >= Stage_offset_x And x < (Stage_offset_x + STAGE_SCREEN_WIDTH) And (y+h) >= Stage_offset_y And y < (Stage_offset_y + STAGE_SCREEN_HEIGHT) Then
		Return True
	End If
	
	Return False
End Function

Function World_Actor_Collision(actor, old_frame, old_x, old_y, new_frame, new_x, new_y)
	'ax = Actor_X[actor]
	'ay = Actor_Y[actor]
	s = Actor_Sprite[actor]
	'frame = Actor_CurrentFrame[actor]
	layer = Actor_Layer[actor]
	layer_index = Actor_LayerPosition[actor]
	
	'diff_x = new_x - ax
	'diff_y = new_y - ay
	
	Dim sect_x[9]
	Dim sect_y[9]
	
	Dim collide_x
	Dim collide_y
	
	Actor_DynaRect_SpeedAdjust[actor, 0] = 0
	Actor_DynaRect_SpeedAdjust[actor, 1] = 0
	
	Actor_Collision_Inside_Shape[actor] = -1
	
	
	Select Case Sprite_Frame_Bound_Shape[s]
	Case SHAPE_TYPE_RECT 'Sprite Bound is a Rect
		a_lx1 = old_x + Sprite_Frame_Bound_X[s, old_frame]
		a_ly1 = old_y + Sprite_Frame_Bound_Y[s, old_frame]
		
		a_lx2 = old_x + Sprite_Frame_Bound_Param[s, old_frame, 0]
		a_ly2 = a_ly1
		
		a_lx3 = a_lx2
		a_ly3 = old_y + Sprite_Frame_Bound_Param[s, old_frame, 1]
		
		a_lx4 = a_lx1
		a_ly4 = a_ly3
		
		n_lx1 = new_x + Sprite_Frame_Bound_X[s, new_frame]
		n_ly1 = new_y + Sprite_Frame_Bound_Y[s, new_frame]
		
		n_lx2 = new_x + Sprite_Frame_Bound_Param[s, new_frame, 0]
		n_ly2 = n_ly1
		
		n_lx3 = n_lx2
		n_ly3 = new_y + Sprite_Frame_Bound_Param[s, new_frame, 1]
		
		n_lx4 = n_lx1
		n_ly4 = n_ly3
		
		''''''''''''
		sect_x[0] = Int(old_x / Stage_Sector_Width)
		sect_y[0] = Int(old_y / Stage_Sector_Height)
		
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
		
		num_collisions = 0
		
		'a_dn_shape = Actor_Shape[actor]
		
		For i = 0 to 8
			sector_x = sect_x[i]
			sector_y = sect_y[i]
			If sector_x >= 0 And sector_y >= 0 Then
				If Stage_Sector_NumShapes[sector_x, sector_y] > 0 Then
					
					For shape_num = 0 to Stage_Sector_NumShapes[sector_x, sector_y]-1
						
						If Stage_Sector_Shape_Layer[sector_x, sector_y, shape_num] = layer Then
							shape_index = Stage_Sector_Shape_Index[sector_x, sector_y, shape_num]
							shape_x = Stage_Layer_Shape_X[layer, shape_index]
							shape_y = Stage_Layer_Shape_Y[layer, shape_index]
							shape_p1 = Stage_Layer_Shape_Param[layer, shape_index, 0]
							shape_p2 = Stage_Layer_Shape_Param[layer, shape_index, 1]
							Select Case Stage_Layer_Shape_Type[layer, shape_index]
							Case SHAPE_TYPE_LINE
								'need to do line collision
								lx1 = shape_x
								ly1 = shape_y
								lx2 = shape_p1
								ly2 = shape_p2
								
								If lx1 = lx2 Then
									lx2 = lx2 + 2
								End If
								
								If ly1 = ly2 Then
									ly2 = ly2 + 2
								End If
								
								If lx1 < lx2 Then
									lx1 = lx1 - 1
									lx2 = lx2 + 1
								Else
									lx1 = lx1 + 1
									lx2 = lx2 + 1
								End If
								
								
								in_vt_left_mv_right = (lx1 > a_lx1) And (lx1 < n_lx1) And (lx2 > a_lx1) And (lx2 < n_lx1)
								
								in_ht_top_mv_down = (ly1 > a_ly1) And (ly1 < n_ly1) And (ly2 > a_ly1) And (ly2 < n_ly1)
								
								in_vt_left_mv_left = (lx1 > n_lx1) And (lx1 < a_lx1) And (lx2 > n_lx1) And (lx2 < a_lx1)
								
								in_ht_top_mv_up = (ly1 > n_ly1) And (ly1 < a_ly1) And (ly2 > n_ly1) And (ly2 < a_ly1)
								
								in_vt_right_mv_right = (lx1 > a_lx2) And (lx1 < n_lx2) And (lx2 > a_lx2) And (lx2 < n_lx2)
								
								in_ht_bottom_mv_down = (ly1 > a_ly4) And (ly1 < n_ly4) And (ly2 > a_ly4) And (ly2 < n_ly4)
								
								in_vt_right_mv_left = (lx1 > n_lx2) And (lx1 < a_lx2) And (lx2 > n_lx2) And (lx2 < a_lx2)
								
								in_ht_bottom_mv_up = (ly1 > n_ly4) And (ly1 < a_ly4) And (ly2 > n_ly4) And (ly2 < a_ly4)
								
								
								h_collide = false
								v_collide = false
								
								If in_vt_left_mv_right Or in_vt_left_mv_left Then
									adj_x = lx1 + ((lx2-lx1)/2)
									If GetLineCollision(lx1, ly1, lx2, ly2, adj_x, n_ly1, adj_x, n_ly4, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_RIGHT
										num_collisions = num_collisions+1
										h_collide = true
									End If
								ElseIf in_vt_right_mv_right Or in_vt_right_mv_left Then
									adj_x = lx1 + ((lx2-lx1)/2)
									If GetLineCollision(lx1, ly1, lx2, ly2, adj_x, n_ly2, adj_x, n_ly3, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_LEFT
										num_collisions = num_collisions+1
										h_collide = true
									End If
								End If
								
								If in_ht_top_mv_up Or in_ht_top_mv_down Then
									adj_y = ly1 + ((ly2-ly1)/2)
									If GetLineCollision(lx1, ly1, lx2, ly2, n_lx1, adj_y, n_lx2, adj_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_BOTTOM
										num_collisions = num_collisions+1
										v_collide = true
									End If
								ElseIf in_ht_bottom_mv_up Or in_ht_bottom_mv_down Then
									adj_y = ly1 + ((ly2-ly1)/2)
									If GetLineCollision(lx1, ly1, lx2, ly2, n_lx4, adj_y, n_lx3, adj_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_TOP
										num_collisions = num_collisions+1
										v_collide = true
									End If
								End If
								
								
								'Regular collision
								If Not h_collide Then
									py1 = a_ly1
									py4 = a_ly4
									ny1 = n_ly1
									ny4 = n_ly4
									If (shape_y > py1) And (shape_y < py4) And (shape_p2 > py1) And (shape_p2 < py4) Then
										py1 = shape_y
										py4 = shape_p2
										ny1 = py1 + (n_ly1 - a_ly1)
										ny4 = py4 + (n_ly4 - a_ly4)
									End If
									py2 = py1
									py3 = py4
									ny2 = ny1
									ny3 = ny4
									
									'left of actor bounds against right of shape
									If GetLineCollision(a_lx1, py1, n_lx1, ny1, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_RIGHT
										num_collisions = num_collisions+1
										'print "condition 1 = ";collide_x;", ";collide_y
									ElseIf GetLineCollision(a_lx4, py4, n_lx4, ny4, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_RIGHT
										num_collisions = num_collisions+1
										'print "condition 2 = ";collide_x;", ";collide_y
									'right of actor bounds against left of shape
									ElseIf GetLineCollision(a_lx2, py2, n_lx2, ny2, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_LEFT
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(a_lx3, py3, n_lx3, ny3, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_LEFT
										num_collisions = num_collisions+1
									End If
								End If
								
								If Not v_collide Then
									px1 = a_lx1
									px2 = a_lx2
									nx1 = n_lx1
									nx2 = n_lx2
									If (shape_x > px1) And (shape_x < px2) And (shape_p1 > px1) And (shape_p1 < px2) Then
										px1 = shape_x
										px2 = shape_p1
										nx1 = px1 + (n_lx1 - a_lx1)
										nx2 = px2 + (n_lx2 - a_lx2)
									End If
									px4 = px1
									px3 = px2
									nx4 = nx1
									nx3 = nx2
									
									'top of actor bounds against bottom of shape
									If GetLineCollision(px1, a_ly1, nx1, n_ly1, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_BOTTOM
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(px2, a_ly2, nx2, n_ly2, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_BOTTOM
										num_collisions = num_collisions+1
									'bottom of actor bounds against top of shape
									ElseIf GetLineCollision(px4, a_ly4, nx4, n_ly4, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_TOP
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(px3, a_ly3, nx3, n_ly3, lx1, ly1, lx2, ly2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_LINE_TOP
										num_collisions = num_collisions+1
									End If
								End If
								
								
							Case SHAPE_TYPE_RECT
								py1 = a_ly1
								py4 = a_ly4
								ny1 = n_ly1
								ny4 = n_ly4
								If (shape_y > py1) And (shape_y < py4) And (shape_p2 > py1) And (shape_p2 < py4) Then
									py1 = shape_y
									py4 = shape_p2
									ny1 = py1 + (n_ly1 - a_ly1)
									ny4 = py4 + (n_ly4 - a_ly4)
								End If
								
								py2 = py1
								py3 = py4
								ny2 = ny1
								ny3 = ny4
								
								'left of actor bounds against right of shape
								If num_collisions < MAX_STAGE_COLLISIONS Then
									If GetLineCollision(a_lx1, py1, n_lx1, ny1, shape_p1, shape_y, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_RIGHT
										num_collisions = num_collisions+1
										'print "condition 1 = ";collide_x;", ";collide_y
									ElseIf GetLineCollision(a_lx4, py4, n_lx4, ny4, shape_p1, shape_y, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_RIGHT
										num_collisions = num_collisions+1
										'print "condition 2 = ";collide_x;", ";collide_y
									'right of actor bounds against left of shape
									ElseIf GetLineCollision(a_lx2, py2, n_lx2, ny2, shape_x, shape_y, shape_x, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_LEFT
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(a_lx3, py3, n_lx3, ny3, shape_x, shape_y, shape_x, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_LEFT
										num_collisions = num_collisions+1
									End If
								End If
								
								px1 = a_lx1
								px2 = a_lx2
								nx1 = n_lx1
								nx2 = n_lx2
								
								If (shape_x > px1) And (shape_x < px2) And (shape_p1 > px1) And (shape_p1 < px2) Then
									px1 = shape_x
									px2 = shape_p1
									nx1 = px1 + (n_lx1 - a_lx1)
									nx2 = px2 + (n_lx2 - a_lx2)
								End If
								
								px4 = px1
								px3 = px2
								nx4 = nx1
								nx3 = nx2
								
								'top of actor bounds against bottom of shape
								If num_collisions < MAX_STAGE_COLLISIONS Then
									If GetLineCollision(px1, a_ly1, nx1, n_ly1, shape_x, shape_p2, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_BOTTOM
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(px2, a_ly2, nx2, n_ly2, shape_x, shape_p2, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_BOTTOM
										num_collisions = num_collisions+1
									'bottom of actor bounds against top of shape
									ElseIf GetLineCollision(px4, a_ly4, nx4, n_ly4, shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
									ElseIf GetLineCollision(px3, a_ly3, nx3, n_ly3, shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
									End If
								End If
								
								If (n_lx1 >= shape_x) And (n_lx1 < shape_p1) And (n_ly1 >= shape_y) And (n_ly1 < shape_p2) Then
									Actor_Collision_Inside_Shape[actor] = shape_index
									'If actor = 25 Then
									'	Print "Actor[25] = ";n_lx1;", ";n_ly1
									'	Print "Shape[";shape_index;"]  = ";shape_x;", ";shape_y;", ";shape_p1;", ";shape_p2
									'End If
								End If
								
							Case SHAPE_TYPE_DYNARECT
								'Print "DT"
								
								speed_x = Stage_Layer_Shape_Attribute[layer, shape_index, 0]
								speed_y = Stage_Layer_Shape_Attribute[layer, shape_index, 1]
								
								s_lx1 = n_lx1 - speed_x
								s_lx2 = n_lx2 - speed_x
								s_lx3 = n_lx3 - speed_x
								s_lx4 = n_lx4 - speed_x
								
								s_ly1 = n_ly1 - speed_y
								s_ly2 = n_ly2 - speed_y
								s_ly3 = n_ly3 - speed_y
								s_ly4 = n_ly4 - speed_y
								
								py1 = a_ly1
								py4 = a_ly4
								ny1 = s_ly1
								ny4 = s_ly4
								
								If (shape_y > py1) And (shape_y < py4) And (shape_p2 > py1) And (shape_p2 < py4) Then
									py1 = shape_y
									py4 = shape_p2
									ny1 = py1 + (s_ly1 - a_ly1)
									ny4 = py4 + (s_ly4 - a_ly4)
								End If
								
								py2 = py1
								py3 = py4
								ny2 = ny1
								ny3 = ny4
								
								sp_adj = false
								
								'left of actor bounds against right of shape
								If num_collisions < MAX_STAGE_COLLISIONS Then
									If GetLineCollision(a_lx1, py1, s_lx1, ny1, shape_p1, shape_y, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x + speed_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_RIGHT
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										'print "condition 1 = ";collide_x;", ";collide_y
									ElseIf GetLineCollision(a_lx4, py4, s_lx4, ny4, shape_p1, shape_y, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x + speed_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_RIGHT
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										'print "condition 2 = ";collide_x;", ";collide_y
									'right of actor bounds against left of shape
									ElseIf GetLineCollision(a_lx2, py2, s_lx2, ny2, shape_x, shape_y, shape_x, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x + speed_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_LEFT
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
									ElseIf GetLineCollision(a_lx3, py3, s_lx3, ny3, shape_x, shape_y, shape_x, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x + speed_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_LEFT
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
									End If
								End If
								
								px1 = a_lx1
								px2 = a_lx2
								nx1 = s_lx1
								nx2 = s_lx2
								
								If (shape_x > px1) And (shape_x < px2) And (shape_p1 > px1) And (shape_p1 < px2) Then
									px1 = shape_x
									px2 = shape_p1
									nx1 = px1 + (s_lx1 - a_lx1)
									nx2 = px2 + (s_lx2 - a_lx2)
								End If
								
								'If Actor_Contact_Shape[actor] = shape_index Then
								'	px1 = px1 + speed_x
								'	px2 = px2 + speed_x
								'	nx1 = nx1 + speed_x
								'	nx2 = nx2 + speed_x
								'End If
								
								px4 = px1
								px3 = px2
								nx4 = nx1
								nx3 = nx2
								
								sp = speed_y
								
								if sp > 0 then
									sp = speed_y
								end if
								
								'top of actor bounds against bottom of shape
								If num_collisions < MAX_STAGE_COLLISIONS Then
									If GetLineCollision(px1, a_ly1, nx1, s_ly1, shape_x, shape_p2, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y + speed_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_BOTTOM
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
									ElseIf GetLineCollision(px2, a_ly2, nx2, s_ly2, shape_x, shape_p2, shape_p1, shape_p2, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y + speed_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_BOTTOM
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
									'bottom of actor bounds against top of shape
									ElseIf GetLineCollision(px4, a_ly4+sp, nx4, s_ly4+abs(speed_y), shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y + speed_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										sp_adj = true
									ElseIf GetLineCollision(px3, a_ly3+sp, nx3, s_ly3+abs(speed_y), shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] = collide_y + speed_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										sp_adj = true
									End If
								End If
								
								
								If Not sp_adj And num_collisions < MAX_STAGE_COLLISIONS Then
								If (a_ly1 <= shape_y) And (n_lx1 >= shape_x) And (n_lx1 < shape_p1) And (n_ly4-speed_y >= shape_y) And (n_ly4-speed_y < shape_p2) Then
									If GetLineCollision(px3, shape_y-1, nx3, shape_y+1, shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] =  collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										sp_adj = true
									ElseIf GetLineCollision(px3, a_ly3+sp, nx3, s_ly3+abs(speed_y), shape_x, shape_y, shape_p1, shape_y, collide_x, collide_y) Then
										Actor_Stage_Collision_X[actor, num_collisions] = collide_x
										Actor_Stage_Collision_Y[actor, num_collisions] =  collide_y
										Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
										num_collisions = num_collisions+1
										Actor_Contact_Shape[actor] = shape_index
										sp_adj = true
									End If
									'Actor_Stage_Collision_X[actor, num_collisions] = n_lx1
									'Actor_Stage_Collision_Y[actor, num_collisions] =  collide_y
									'Actor_Stage_Collision_From_Direction[actor, num_collisions] = COLLISION_DIR_TOP
									'num_collisions = num_collisions+1
									'Actor_Contact_Shape[actor] = shape_index
									'sp_adj = true
								End If
								End If
									
								
								If sp_adj Then
									Actor_DynaRect_SpeedAdjust[actor, 0 ] = speed_x
									Actor_DynaRect_SpeedAdjust[actor, 1 ] = speed_y
									actor2 = Stage_Layer_Shape_Actor[layer, shape_index]
									If actor2 >= 0 Then
										If Actor_NumActorCollisions[actor2] < MAX_ACTOR_COLLISIONS Then
											Actor_CollisionActor[actor2, Actor_NumActorCollisions[actor2]] = actor
											Actor_NumActorCollisions[actor2] = Actor_NumActorCollisions[actor2] + 1
										End If
										If Actor_NumActorCollisions[actor] < MAX_ACTOR_COLLISIONS Then
											Actor_CollisionActor[actor, Actor_NumActorCollisions[actor]] = actor2
											Actor_NumActorCollisions[actor] = Actor_NumActorCollisions[actor] + 1
										End If
									End If
									'Actor_NewX[actor] = Actor_NewX[actor] + speed_x
									'Actor_NewY[actor] = Actor_NewY[actor] - speed_y
									'print "Speed Adj: ";Actor_Name$[actor];" -> (";speed_x;", ";speed_y;")"
								End If
							End Select
						End If
					Next
				
				End If
			End If
		Next
		Actor_NumStageCollisions[actor] = num_collisions
	End Select
End Function



Sub ClearActorCollisions(LAYER)
	For i = 0 to Stage_Layer_NumActors[layer]
		Actor_NumActorCollisions[ Stage_Layer_Actor[LAYER,i] ] = 0
	Next
End Sub

Sub World_ActorToActor_Collisions(actor1, a1_old_frame, a1_old_x, a1_old_y, a1_new_frame, a1_new_x, a1_new_y)
	Dim collide_x
	Dim collide_y
	s1 = Actor_Sprite[actor1]
		
	ax1 = a1_old_x + Sprite_Frame_Bound_X[s1, a1_old_frame]
	ay1 = a1_old_y + Sprite_Frame_Bound_Y[s1, a1_old_frame]
		
	ax2 = a1_old_x + Sprite_Frame_Bound_Param[s1, a1_old_frame, 0]
	ay2 = ay1
		
	ax3 = ax2
	ay3 = a1_old_y + Sprite_Frame_Bound_Param[s1, a1_old_frame, 1]
		
	ax4 = ax1
	ay4 = ay3
	
	
	layer = Actor_Layer[actor1]
	
	
	If (Stage_Layer_NumActors[layer]-1) > Actor_LayerPosition[actor1] Then
		For at2 = Actor_LayerPosition[actor1]+1 to Stage_Layer_NumActors[layer] - 1
			actor2= Stage_Layer_Actor[layer, at2]
			If Actor_ParentActor[actor1] <> actor2 And Actor_ParentActor[actor2] <> actor1 Then
			If Actor_Active[actor2] Then
				'Print "Check: ";Actor_Name$[actor2];" - ";Actor_Name$[actor1]
				b_sprite = Actor_Sprite[actor2]
				b_frame = Sprite_Animation_Frame[b_sprite, Actor_CurrentAnimation[actor2], Actor_CurrentFrame[actor2]]
				
				bx1 = Actor_X[actor2] + Sprite_Frame_Bound_X[b_sprite, b_frame]
				by1 = Actor_Y[actor2] + Sprite_Frame_Bound_Y[b_sprite, b_frame]
				
				bx2 = Actor_X[actor2] + Sprite_Frame_Bound_Param[b_sprite, b_frame, 0]
				by2 = Actor_Y[actor2] + Sprite_Frame_Bound_Param[b_sprite, b_frame, 1]
				
				is_collision = false
				
				If ax1 >= bx1 And ax1 <= bx2 And ay1 >= by1 And ay1 <= by2 Then
					'print ""
					'Print "1LR:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf ax2 >= bx1 And ax2 <= bx2 And ay2 >= by1 And ay2 <= by2 Then
					'Print "2RL:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf ax3 >= bx1 And ax3 <= bx2 And ay3 >= by1 And ay3 <= by2 Then
					'Print "3RL:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf ax4 >= bx1 And ax4 <= bx2 And ay4 >= by1 And ay4 <= by2 Then
					'Print "4LR:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf bx1 >= ax1 And bx1 <= ax2 And by1 >= ay1 And by1 <= ay3 Then
					'print ""
					'Print "5RL:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf bx2 >= ax1 And bx2 <= ax2 And by1 >= ay1 And by1 <= ay3 Then
					'Print "6LR:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf bx2 >= ax1 And bx2 <= ax2 And by2 >= ay1 And by2 <= ay3 Then
					'Print "7LR:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				ElseIf bx1 >= ax1 And bx1 <= ax2 And by2 >= ay1 And by2 <= ay3 Then
					'Print "8RL:"; Actor_Name$[actor1]; " --- ";Actor_Name$[actor2]
					'Print "Actor 1: "; ax1;", ";ay1
					'Print "Actor 2: "; bx1;", ";by1;", ";bx2;", ";by2
					is_collision = true
				Else
					is_collision = is_collision Or GetLineIntersect(ax1, ay1, ax2, ay1, bx1, by1, bx1, by2, collide_x, collide_y)
					is_collision = is_collision Or GetLineIntersect(ax1, ay3, ax2, ay3, bx1, by1, bx1, by2, collide_x, collide_y)
					
					is_collision = is_collision Or GetLineIntersect(ax1, ay1, ax2, ay1, bx2, by1, bx2, by2, collide_x, collide_y)
					is_collision = is_collision Or GetLineIntersect(ax1, ay3, ax2, ay3, bx2, by1, bx2, by2, collide_x, collide_y)
					
					is_collision = is_collision Or GetLineIntersect(ax1, ay1, ax1, ay3, bx1, by1, bx2, by1, collide_x, collide_y)
					is_collision = is_collision Or GetLineIntersect(ax2, ay1, ax2, ay3, bx1, by1, bx2, by1, collide_x, collide_y)
				
					is_collision = is_collision Or GetLineIntersect(ax1, ay1, ax1, ay3, bx1, by2, bx2, by2, collide_x, collide_y)
					is_collision = is_collision Or GetLineIntersect(ax2, ay1, ax2, ay3, bx1, by2, bx2, by2, collide_x, collide_y)
				End If
				
				If is_collision Then
					If Actor_NumActorCollisions[actor1] < MAX_ACTOR_COLLISIONS Then
						Actor_CollisionActor[actor1, Actor_NumActorCollisions[actor1]] = actor2
						Actor_NumActorCollisions[actor1] = Actor_NumActorCollisions[actor1] + 1
					End If
					If Actor_NumActorCollisions[actor2] < MAX_ACTOR_COLLISIONS Then
						Actor_CollisionActor[actor2, Actor_NumActorCollisions[actor2]] = actor1
						Actor_NumActorCollisions[actor2] = Actor_NumActorCollisions[actor2] + 1
					End If
				End If
			End If
			End If
		Next
	End If
End Sub

Sub Actor_SetParent(child, parent)
	Actor_ParentActor[child] = parent
	Actor_ChildActor[parent] = child
End Sub

Sub Actor_EnableCollisions(actor, flag)
	Actor_Collision[actor] = flag
End Sub

Dim EFFECT_NONE
Dim EFFECT_FLASH
EFFECT_NONE = 0
EFFECT_FLASH = 1

Dim Actor_Effect_Active[MAX_ACTORS]
Dim Actor_Effect_Type[MAX_ACTORS]
Dim Actor_Effect_Timer[MAX_ACTORS]
Dim Actor_Effect_Time[MAX_ACTORS] 'Total time for one iteration of the effect
Dim Actor_Effect_Value[MAX_ACTORS]
Dim Actor_Effect_Increment[MAX_ACTORS]

Sub Actor_SetEffect(actor, effect_type, effect_time)
	If effect_type = EFFECT_NONE Then
		Actor_Effect_Active[actor] = False
		Actor_Effect_Type[actor] = 0
		If ImageExists(Sprite_Image[Actor_Sprite[actor]]) Then
			SetImageAlpha(Sprite_Image[Actor_Sprite[actor]], 255)
		End If
	End If
	If effect_time < 10 Then
		effect_time = 10
	End If
	Actor_Effect_Active[actor] = True
	Actor_Effect_Type[actor] = effect_type
	Actor_Effect_Value[actor] = 0
	Actor_Effect_Timer[actor] = Timer
	Actor_Effect_Time[actor] = effect_time 'one second
	Actor_Effect_Increment[actor] = 255/effect_time
End Sub

Function Actor_GetCollision(actor1, actor2)
	If Not (Actor_Active[actor1] And Actor_Active[actor2]) Then
		Return False
	ElseIf Not (Actor_Collision[actor1] And Actor_Collision[actor2]) Then
		Return False
	End If
	
	For i = 0 to MAX_ACTOR_COLLISIONS-1
		If (Actor_CollisionActor[actor1, i] = actor2 And i < Actor_NumActorCollisions[actor1])  Or (Actor_CollisionActor[actor2, i] = actor1 And i < Actor_NumActorCollisions[actor2]) Then
			'Print "\nGraizor -> "; actor1; " = ";Actor_NumActorCollisions[actor1];" -- ";Actor_CollisionActor[actor1, i]
			'Print "Claw -> ";actor2; " = ";Actor_NumActorCollisions[actor2];" -- ";Actor_CollisionActor[actor2, i]
			'Print""
			Return True
		End If
	Next
	Return False
End Function

Sub Actor_SetPosition(actor, x, y)
	Actor_X[actor] = x
	Actor_Y[actor] = y
	Actor_NewX[actor] = x
	Actor_NewY[actor] = y
	
	If Actor_Shape[actor] >= 0 Then
		spr = Actor_Sprite[actor]
	
		px = Sprite_Frame_Bound_X[spr, 0]
		py = Sprite_Frame_Bound_Y[spr, 0]
		
		p1 = Sprite_Frame_Bound_Param[spr, 0, 0]+1
		p2 = Sprite_Frame_Bound_Param[spr, 0, 1]
		
		Stage_Layer_Shape_X[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewX[actor] + px
		Stage_Layer_Shape_Y[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewY[actor] + px
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = Actor_NewX[actor] + p1
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = Actor_NewY[actor] + p2
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = 0
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = 0
	End If
End Sub

Sub Actor_SetScreenPosition(actor, x, y)
	Actor_X[actor] = Stage_offset_x + x
	Actor_Y[actor] = Stage_offset_y + y
	Actor_NewX[actor] = Actor_X[actor]
	Actor_NewY[actor] = Actor_Y[actor]
	
	If Actor_Shape[actor] >= 0 Then
		spr = Actor_Sprite[actor]
	
		px = Sprite_Frame_Bound_X[spr, 0]
		py = Sprite_Frame_Bound_Y[spr, 0]
		
		p1 = Sprite_Frame_Bound_Param[spr, 0, 0]+1
		p2 = Sprite_Frame_Bound_Param[spr, 0, 1]
		
		Stage_Layer_Shape_X[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewX[actor] + px
		Stage_Layer_Shape_Y[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewY[actor] + px
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = Actor_NewX[actor] + p1
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = Actor_NewY[actor] + p2
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = 0
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = 0
	End If
End Sub

Sub Actor_Move(actor, x, y)
	Actor_NewX[actor] = Actor_NewX[actor] + x
	Actor_NewY[actor] = Actor_NewY[actor] + y
	Actor_Move_Flag[actor] = True
	If Actor_Shape[actor] >= 0 Then
		spr = Actor_Sprite[actor]
	
		px = Sprite_Frame_Bound_X[spr, 0]
		py = Sprite_Frame_Bound_Y[spr, 0]
		
		Stage_Layer_Shape_X[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewX[actor] + px
		Stage_Layer_Shape_Y[Actor_Shape_Layer[actor], Actor_Shape[actor]] = Actor_NewY[actor] + px
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] + x
		Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = Stage_Layer_Shape_Param[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] + y
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = x
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = y
	End If
	'ax = Actor_X[actor] + x
	'ay = Actor_Y[actor] + y
	'World_Actor_Collision(actor, ax, ay)
	'If Actor_NumStageCollisions[actor] = 0 Then
	'	Actor_X[actor] = ax
	'	Actor_Y[actor] = ay
	'End If
End Sub

'SPRITE FUNCTIONS
Function LoadSprite(spr_name$)
	sprite = -1
	
	s_name$ = spr_name$
	
	For i = 0 to MAX_SPRITES-1
		If Sprite_Name$[i] = s_name$ Then
			sprite = i
			If Sprite_inUse[i] Then
				DeleteImage(Sprite_Image[i])
			End If
			Sprite_inUse[i] = False
			Exit For
		End If
	Next
	
	For i = 0 to MAX_SPRITES-1
		If Not Sprite_inUse[i] Then
			sprite = i
			Exit For
		End If
	Next
	If sprite = -1 Then
		Return -1
	End If
	
	Sprite_Image[sprite] = GetFreeImage
	If Sprite_Image[sprite] < 0 Then
		Return -1
	End If
	
	spr_file$ = ""
	
	If FileExists(SPRITE_PATH$ + spr_name$ + ".png") Then
		spr_file$ = spr_name$ + ".png"
	ElseIf FileExists(SPRITE_PATH$ + spr_name$ + ".bmp") Then
		spr_file$ = spr_name$ + ".bmp"
	Else
		Return -1
	End If
	
	If Not FileExists(SPRITE_PATH$ + spr_name$ + ".sprite") Then
		Return -1
	End If
	
	LoadImage(Sprite_Image[sprite], SPRITE_PATH$ + spr_file$)
	
	If Not ImageExists(Sprite_Image[sprite]) Then
		Return -1
	End If
	
	dim w
	dim h
	GetImageSize(Sprite_Image[sprite], w, h)
	Sprite_Image_W[sprite] = w
	Sprite_Image_H[sprite] = h
	
	f = FreeFile
	
	FileOpen(f, SPRITE_PATH$ + spr_name$ + ".sprite", BINARY_INPUT)
	Sprite_Version[sprite] = Read32(f)
	Sprite_Frame_Width[sprite] = Read32(f)
	Sprite_Frame_Height[sprite] = Read32(f)
	Sprite_NumFrames[sprite] = Read32(f)
	Sprite_NumAnimations[sprite] = Read32(f)
	Sprite_Frame_Bound_Shape[sprite] = ReadByte(f)
	
	If Sprite_NumFrames[sprite] > 0 Then
		For i = 0 to Sprite_NumFrames[sprite]-1
			Sprite_Frame_Bound_X[sprite, i] = Read32(f)
			Sprite_Frame_Bound_Y[sprite, i] = Read32(f)
			Sprite_Frame_Bound_Param[sprite, i, 0] = Read32(f)
			Sprite_Frame_Bound_Param[sprite, i, 1] = Read32(f)
		Next
	End If
	
	If Sprite_NumAnimations[sprite] > 0 Then
		For anim = 0 to Sprite_NumAnimations[sprite]-1
			c = ReadByte(f)
			a_name$ = ""
			While c <> 0
				a_name$ = a_name$ + Chr$(c)
				c = ReadByte(f)
			Wend
			Sprite_Animation_Name$[sprite, anim] = a_name$
			Sprite_Animation_NumFrames[sprite, anim] = Read32(f)
			Sprite_Animation_FPS[sprite, anim] = Read32(f)
			If Sprite_Animation_NumFrames[sprite, anim] > 0 Then
				For frame = 0 to Sprite_Animation_NumFrames[sprite, anim]-1
					Sprite_Animation_Frame[sprite, anim, frame] = Read32(f)
				Next
			End If
		Next
	End If
	
	FileClose(f)
	
	Sprite_Name$[sprite] = spr_name$
	
	Sprite_Animation_Delay[sprite] = 1000 / Max(1, Sprite_Animation_FPS[sprite, 0])
	
	Sprite_Image_WidthInFrames[sprite] = Int(Sprite_Image_W[sprite] / Sprite_Frame_Width[sprite])
	Sprite_Image_HeightInFrames[sprite] = Int(Sprite_Image_H[sprite] / Sprite_Frame_Height[sprite])
	
	'Change Sprite_NumFrames to new image size if it changed
	Sprite_NumFrames[sprite] = Sprite_Image_WidthInFrames[sprite] * Sprite_Image_HeightInFrames[sprite]
	
	Sprite_inUse[sprite] = True
	
	Return sprite
End Function

Function LoadSprite_Ex(spr_name$, overwrite_flag)
	sprite = -1
	
	s_name$ = spr_name$
	
	For i = 0 to MAX_SPRITES-1
		If Sprite_Name$[i] = s_name$ Then
			sprite = i
			If Sprite_inUse[i] And (Not overwrite_flag) Then
				Return sprite
			End If
			If Sprite_inUse[i] Then
				DeleteImage(Sprite_Image[i])
			End If
			Sprite_inUse[i] = False
			Exit For
		End If
	Next
	
	For i = 0 to MAX_SPRITES-1
		If Not Sprite_inUse[i] Then
			sprite = i
			Exit For
		End If
	Next
	If sprite = -1 Then
		Return -1
	End If
	
	Sprite_Image[sprite] = GetFreeImage
	If Sprite_Image[sprite] < 0 Then
		Return -1
	End If
	
	spr_file$ = ""
	
	If FileExists(SPRITE_PATH$ + spr_name$ + ".png") Then
		spr_file$ = spr_name$ + ".png"
	ElseIf FileExists(SPRITE_PATH$ + spr_name$ + ".bmp") Then
		spr_file$ = spr_name$ + ".bmp"
	Else
		Return -1
	End If
	
	If Not FileExists(SPRITE_PATH$ + spr_name$ + ".sprite") Then
		Return -1
	End If
	
	LoadImage(Sprite_Image[sprite], SPRITE_PATH$ + spr_file$)
	
	If Not ImageExists(Sprite_Image[sprite]) Then
		Return -1
	End If
	
	dim w
	dim h
	GetImageSize(Sprite_Image[sprite], w, h)
	Sprite_Image_W[sprite] = w
	Sprite_Image_H[sprite] = h
	
	f = FreeFile
	
	FileOpen(f, SPRITE_PATH$ + spr_name$ + ".sprite", BINARY_INPUT)
	Sprite_Version[sprite] = Read32(f)
	Sprite_Frame_Width[sprite] = Read32(f)
	Sprite_Frame_Height[sprite] = Read32(f)
	Sprite_NumFrames[sprite] = Read32(f)
	Sprite_NumAnimations[sprite] = Read32(f)
	Sprite_Frame_Bound_Shape[sprite] = ReadByte(f)
	
	If Sprite_NumFrames[sprite] > 0 Then
		For i = 0 to Sprite_NumFrames[sprite]-1
			Sprite_Frame_Bound_X[sprite, i] = Read32(f)
			Sprite_Frame_Bound_Y[sprite, i] = Read32(f)
			Sprite_Frame_Bound_Param[sprite, i, 0] = Read32(f)
			Sprite_Frame_Bound_Param[sprite, i, 1] = Read32(f)
		Next
	End If
	
	If Sprite_NumAnimations[sprite] > 0 Then
		For anim = 0 to Sprite_NumAnimations[sprite]-1
			c = ReadByte(f)
			a_name$ = ""
			While c <> 0
				a_name$ = a_name$ + Chr$(c)
				c = ReadByte(f)
			Wend
			Sprite_Animation_Name$[sprite, anim] = a_name$
			Sprite_Animation_NumFrames[sprite, anim] = Read32(f)
			Sprite_Animation_FPS[sprite, anim] = Read32(f)
			If Sprite_Animation_NumFrames[sprite, anim] > 0 Then
				For frame = 0 to Sprite_Animation_NumFrames[sprite, anim]-1
					Sprite_Animation_Frame[sprite, anim, frame] = Read32(f)
				Next
			End If
		Next
	End If
	
	FileClose(f)
	
	Sprite_Name$[sprite] = spr_name$
	
	Sprite_Animation_Delay[sprite] = 1000 / Max(1, Sprite_Animation_FPS[sprite, 0])
	
	Sprite_Image_WidthInFrames[sprite] = Int(Sprite_Image_W[sprite] / Sprite_Frame_Width[sprite])
	Sprite_Image_HeightInFrames[sprite] = Int(Sprite_Image_H[sprite] / Sprite_Frame_Height[sprite])
	
	'Change Sprite_NumFrames to new image size if it changed
	Sprite_NumFrames[sprite] = Sprite_Image_WidthInFrames[sprite] * Sprite_Image_HeightInFrames[sprite]
	
	Sprite_inUse[sprite] = True
	
	Return sprite
End Function

Function SaveSprite(sprite)
	If sprite < 0 Or sprite >= MAX_SPRITES Then
		Return 0
	End If
	
	spr_file$ = Sprite_Name$[sprite] + ".sprite"
	
	If FileExists(SPRITE_PATH$ + spr_file$) Then
		RemoveFile(SPRITE_PATH$ + spr_file$)
	End If
	
	f = FreeFile
	
	FileOpen(f, SPRITE_PATH$ + spr_file$, BINARY_OUTPUT)
	Write32(f, Sprite_Version[sprite])
	Write32(f, Sprite_Frame_Width[sprite])
	Write32(f, Sprite_Frame_Height[sprite])
	Write32(f, Sprite_NumFrames[sprite])
	Write32(f, Sprite_NumAnimations[sprite])
	WriteByte(f, Sprite_Frame_Bound_Shape[sprite])
	
	If Sprite_NumFrames[sprite] > 0 Then
		For i = 0 to Sprite_NumFrames[sprite]-1
			Write32(f, Sprite_Frame_Bound_X[sprite, i])
			Write32(f, Sprite_Frame_Bound_Y[sprite, i])
			Write32(f, Sprite_Frame_Bound_Param[sprite, i, 0])
			Write32(f, Sprite_Frame_Bound_Param[sprite, i, 1])
		Next
	End If
	
	If Sprite_NumAnimations[sprite] > 0 Then
		For anim = 0 to Sprite_NumAnimations[sprite]-1
			a_name$ = Sprite_Animation_Name$[sprite, anim]
			For n = 0 to Length(a_name$)-1
				WriteByte(f, Asc(Mid$(a_name$, n, 1)))
			Next
			WriteByte(f, 0)
			Write32(f, Sprite_Animation_NumFrames[sprite, anim])
			Write32(f, Sprite_Animation_FPS[sprite, anim])
			If Sprite_Animation_NumFrames[sprite, anim] > 0 Then
				For frame = 0 to Sprite_Animation_NumFrames[sprite, anim]-1
					Write32(f, Sprite_Animation_Frame[sprite, anim, frame])
				Next
			End If
		Next
	End If
	
	FileClose(f)
End Function

Function NewSprite(spr_file$, frame_w, frame_h)
	sprite = -1
	
	s_name$ = Mid$(spr_file$, 0, FindLastOf(".", spr_file$))
	
	For i = 0 to MAX_SPRITES-1
		If Sprite_Name$[i] = s_name$ Then
			sprite = i
			If Sprite_inUse[i] Then
				DeleteImage(Sprite_Image[i])
			End If
			Sprite_inUse[i] = False
			Exit For
		End If
	Next
	
	If sprite = -1 Then
		For i = 0 to MAX_SPRITES-1
			If Not Sprite_inUse[i] Then
				sprite = i
				Exit For
			End If
		Next
	End If
	
	If sprite = -1 Then
		Return -1
	End If
	
	Sprite_Image[sprite] = GetFreeImage
	If Sprite_Image[sprite] < 0 Then
		Return -1
	End If
	
	LoadImage(Sprite_Image[sprite], SPRITE_PATH$ + spr_file$)
	If Not ImageExists(Sprite_Image[sprite]) Then
		Return -1
	End If
	
	dim w
	dim h
	GetImageSize(Sprite_Image[sprite], w, h)
	Sprite_Image_W[sprite] = w
	Sprite_Image_H[sprite] = h
	
	Sprite_inUse[sprite] = True
	Sprite_Name$[sprite] = Mid$(spr_file$, 0, FindLastOf(".", spr_file$))
	Sprite_Frame_Width[sprite] = frame_w
	Sprite_Frame_Height[sprite] = frame_h
	Sprite_NumAnimations[sprite] = 0
	Sprite_Version[sprite] = ENGINE_VERSION
	Sprite_Frame_Bound_Shape[sprite] = SHAPE_TYPE_RECT
	For i = 0 to MAX_SPRITE_FRAMES-1
		Sprite_Frame_Bound_X[sprite, i] = 0
		Sprite_Frame_Bound_Y[sprite, i] = 0
		Sprite_Frame_Bound_Param[sprite, i, 0] = frame_w
		Sprite_Frame_Bound_Param[sprite, i, 1] = frame_h
	Next
	Sprite_Image_WidthInFrames[sprite] = Int(Sprite_Image_W[sprite] / Sprite_Frame_Width[sprite])
	Sprite_Image_HeightInFrames[sprite] = Int(Sprite_Image_H[sprite] / Sprite_Frame_Height[sprite])
	Sprite_NumFrames[sprite] = Sprite_Image_WidthInFrames[sprite] * Sprite_Image_HeightInFrames[sprite]
	Return sprite
End Function

Function NullSprite(spr_name$, frame_w, frame_h)
	sprite = -1
	
	For i = 0 to MAX_SPRITES-1
		If Not Sprite_inUse[i] Then
			sprite = i
			Exit For
		End If
	Next
	
	If sprite = -1 Then
		Return -1
	End If
	
	Sprite_Image[sprite] = -1
	
	Sprite_Image_W[sprite] = frame_w
	Sprite_Image_H[sprite] = frame_h
	
	Sprite_inUse[sprite] = True
	Sprite_Name$[sprite] = spr_name$
	Sprite_Frame_Width[sprite] = frame_w
	Sprite_Frame_Height[sprite] = frame_h
	Sprite_NumAnimations[sprite] = 1
	Sprite_Version[sprite] = ENGINE_VERSION
	Sprite_Frame_Bound_Shape[sprite] = SHAPE_TYPE_RECT
	For i = 0 to MAX_SPRITE_FRAMES-1
		Sprite_Frame_Bound_X[sprite, i] = 0
		Sprite_Frame_Bound_Y[sprite, i] = 0
		Sprite_Frame_Bound_Param[sprite, i, 0] = frame_w
		Sprite_Frame_Bound_Param[sprite, i, 1] = frame_h
	Next
	
	Sprite_Image_WidthInFrames[sprite] = 1
	Sprite_Image_HeightInFrames[sprite] = 1
	Sprite_NumFrames[sprite] = 1
	Return sprite
End Function

Function CopySprite(sprite)
	new_sprite = -1
	
	
	For i = 0 to MAX_SPRITES-1
		If Not Sprite_inUse[i] Then
			new_sprite = i
			Exit For
		End If
	Next
	
	If new_sprite = -1 Then
		Return -1
	End If
	
	Sprite_Image[new_sprite] = GetFreeImage
	
	spr_name$ = Sprite_Name$[sprite]
	spr_file$ = ""
	
	If FileExists(SPRITE_PATH$ + spr_name$ + ".png") Then
		spr_file$ = spr_name$ + ".png"
	ElseIf FileExists(SPRITE_PATH$ + spr_name$ + ".bmp") Then
		spr_file$ = spr_name$ + ".bmp"
	Else
		Return -1
	End If
	
	If Sprite_Image[new_sprite] >= 0 Then
		LoadImage(Sprite_Image[new_sprite], SPRITE_PATH$ + spr_file$)
	End If
	
	Sprite_Image_W[new_sprite] = Sprite_Image_W[sprite]
	Sprite_Image_H[new_sprite] = Sprite_Image_H[sprite]
	
	Sprite_Version[new_sprite] = Sprite_Version[sprite]
	Sprite_Frame_Width[new_sprite] = Sprite_Frame_Width[sprite]
	Sprite_Frame_Height[new_sprite] = Sprite_Frame_Height[sprite]
	Sprite_NumFrames[new_sprite] = Sprite_NumFrames[sprite]
	Sprite_NumAnimations[new_sprite] = Sprite_NumAnimations[sprite]
	Sprite_Frame_Bound_Shape[new_sprite] = Sprite_Frame_Bound_Shape[sprite]
	
	If Sprite_NumFrames[new_sprite] > 0 Then
		For i = 0 to Sprite_NumFrames[new_sprite]-1
			Sprite_Frame_Bound_X[new_sprite, i] = Sprite_Frame_Bound_X[sprite, i]
			Sprite_Frame_Bound_Y[new_sprite, i] = Sprite_Frame_Bound_Y[sprite, i]
			Sprite_Frame_Bound_Param[new_sprite, i, 0] = Sprite_Frame_Bound_Param[sprite, i, 0]
			Sprite_Frame_Bound_Param[new_sprite, i, 1] = Sprite_Frame_Bound_Param[sprite, i, 1]
		Next
	End If
	
	If Sprite_NumAnimations[new_sprite] > 0 Then
		For anim = 0 to Sprite_NumAnimations[new_sprite]-1
			Sprite_Animation_Name$[new_sprite, anim] = Sprite_Animation_Name$[sprite, anim]
			Sprite_Animation_NumFrames[new_sprite, anim] = Sprite_Animation_NumFrames[sprite, anim]
			Sprite_Animation_FPS[new_sprite, anim] = Sprite_Animation_FPS[sprite, anim]
			If Sprite_Animation_NumFrames[new_sprite, anim] > 0 Then
				For frame = 0 to Sprite_Animation_NumFrames[new_sprite, anim]-1
					Sprite_Animation_Frame[new_sprite, anim, frame] = Sprite_Animation_Frame[sprite, anim, frame]
				Next
			End If
		Next
	End If
	
	Sprite_Name$[new_sprite] = Sprite_Name$[sprite]
	
	Sprite_Animation_Delay[new_sprite] = 1000 / Max(1, Sprite_Animation_FPS[new_sprite, 0])
	
	Sprite_Image_WidthInFrames[new_sprite] = Sprite_Image_WidthInFrames[sprite]
	Sprite_Image_HeightInFrames[new_sprite] = Sprite_Image_HeightInFrames[sprite]
	
	Sprite_inUse[new_sprite] = True
	
	Return new_sprite
End Function

Sub DestroySprite(sprite)
	If sprite < 0 Or sprite >= MAX_SPRITES Then
		Return
	End If
	
	If Sprite_inUse[sprite] And Sprite_Image[sprite] > 0 Then
		DeleteImage(Sprite_Image[sprite])
	End If
	
	Sprite_inUse[sprite] = False
	Sprite_Name$[sprite] = ""
	Sprite_NumAnimations[sprite] = 0
	Sprite_NumFrames[sprite] = 0
End Sub

Function Sprite_CreateAnimation(sprite, anim_name$)
	anim = Sprite_NumAnimations[sprite]
	If anim >= MAX_SPRITE_ANIMATIONS Then
		Return -1
	End If
	Sprite_Animation_Name$[sprite, anim] = anim_name$
	Sprite_NumAnimations[sprite] = anim + 1
	Sprite_Animation_NumFrames[sprite, anim] = 0
	Return anim
End Function

Sub Sprite_RemoveAnimation(sprite, anim)
	If anim < 0 Or anim >= Sprite_NumAnimations[sprite] Then
		Return
	End If
	
	num_anim_to_sort = Sprite_NumAnimations[sprite] - anim - 1
	
	If num_anim_to_sort > 0 Then
		For i = anim to anim + num_anim_to_sort
			Sprite_Animation_NumFrames[sprite, i] = Sprite_Animation_NumFrames[sprite, i+1]
			Sprite_Animation_FPS[sprite, i] = Sprite_Animation_FPS[sprite, i+1]
			Sprite_Animation_Name$[sprite, i] = Sprite_Animation_Name$[sprite, i+1]
			If Sprite_Animation_NumFrames[sprite, i] > 0 Then
				For frame = 0 to Sprite_Animation_NumFrames[sprite, i]-1
					Sprite_Animation_Frame[sprite, i, frame] = Sprite_Animation_Frame[sprite, i+1, frame]
				Next
			End If
		Next
	End If
	
	Sprite_NumAnimations[sprite] = Sprite_NumAnimations[sprite] - 1
	If Sprite_NumAnimations[sprite] < 0 Then
		Sprite_NumAnimations[sprite] = 0
	End If
End Sub

Function Sprite_Animation_AddFrame(sprite, anim, frame_index)
	If Sprite_Animation_NumFrames[sprite, anim] < MAX_SPRITE_ANIMATION_FRAMES Then
		frame_num = Sprite_Animation_NumFrames[sprite, anim]
		Sprite_Animation_Frame[sprite, anim, frame_num] = frame_index
		Sprite_Animation_NumFrames[sprite, anim] = frame_num +1
		Return frame_num
	End If
	Return -1
End Function

Sub Sprite_Animation_RemoveFrame(sprite, anim)
	If Sprite_Animation_NumFrames[sprite, anim] > 0 Then
		Sprite_Animation_NumFrames[sprite, anim] = Sprite_Animation_NumFrames[sprite, anim] - 1
	End If
End Sub

Sub Sprite_SetAlpha(sprite, alpha)
	If alpha >= 0 And alpha <= 255 Then
		SetImageAlpha(Sprite_Image[sprite], alpha)
	End If
End Sub

Sub SaveTileSet(tset_num, tset_file$)
	If Stage_Tileset_NumTiles[tset_num] <= 0 Or tset_num < 0 Or tset_num >= MAX_TILESETS Then
		Return
	End If
	
	If FileExists(TILE_PATH$ + tset_file$) Then
		RemoveFile(TILE_PATH$ + tset_file$)
	End If
	
	f = FreeFile
	FileOpen(f, TILE_PATH$ + tset_file$, BINARY_OUTPUT)
	Write32(f, Stage_Tileset_Version[tset_num])
	Write32(f, Stage_Tileset_NumTiles[tset_num])
	For i = 0 to Stage_Tileset_NumTiles[tset_num]-1
		'frame count
		WriteByte(f, Stage_Tileset_Tile_NumFrames[tset_num, i])
		
		'frame indexes
		If Stage_Tileset_Tile_NumFrames[tset_num, i] > 0 Then
			For frame_num = 0 to Stage_Tileset_Tile_NumFrames[tset_num, i] - 1
				Write32(f, Stage_Tileset_Tile_Frame[tset_num, i, frame_num])
			Next
		End If
	Next
	FileClose(f)
End Sub

Sub ClearTilesetProperties(tset_num)
	Stage_Tileset_Version[tset_num] = ENGINE_VERSION
	Stage_Tileset_File$[tset_num] = ""
	For i = 0 to MAX_TILES-1
		Stage_Tileset_Tile_NumFrames[tset_num, i] = 1
		Stage_Tileset_Tile_Frame[tset_num, i, 0] = i
	Next
End Sub

Sub ClearTileset(tset_num)
	If Stage_Tileset_ImageIsLoaded[tset_num] Then
		DeleteImage(Stage_Tileset_Image[tset_num])
		Stage_Tileset_ImageIsLoaded[tset_num] = False
	End If
End Sub

Sub SetTileSize(w, h)
	Stage_Tileset_Tile_Width = w
	Stage_Tileset_Tile_Height = h
End Sub

Function LoadTileSet(tset_num, tset_file$)
	ClearTilesetProperties(tset_num)
	ClearTileset(tset_num)
	
	If tset_num < 0 Or tset_num >= MAX_TILESETS Or (Not FileExists(TILE_PATH$ + tset_file$)) Then
		'Print "Debug: ";Stage_Tileset_NumTiles[tset_num];", ";tset_num;", ";FileExists(TILE_PATH$+tset_file$)
		Return False
	End If
	
	Stage_Tileset_File$[tset_num] = tset_file$
	Stage_Tileset_Image[tset_num] = GetFreeImage
	If Stage_Tileset_Image[tset_num] < 0 Then
		Print "LoadTileSet Error: No available image slots"
		Return -1
	End If
	
	LoadImage(Stage_TileSet_Image[tset_num], TILE_PATH$ + tset_file$)
	w = 0
	h = 0
	GetImageSize(Stage_Tileset_Image[tset_num], w, h)
	Stage_Tileset_Image_Width[tset_num] = w
	Stage_Tileset_Image_Height[tset_num] = h
	Stage_Tileset_Image_WidthInTiles[tset_num] = Int(w / Stage_Tileset_Tile_Width)
	Stage_Tileset_Image_HeightInTiles[tset_num] = Int(h / Stage_Tileset_Tile_Height)
	
	Stage_Tileset_ImageIsLoaded[tset_num] = True
	
	If Not FileExists(TILE_PATH$ + Mid$(tset_file$, 0, FindLastOf(".", tset_file$)) + ".tset") Then
		Stage_Tileset_NumTiles[tset_num] = Stage_Tileset_Image_WidthInTiles[tset_num] * Stage_Tileset_Image_HeightInTiles[tset_num]
		Return True
	End If
	
	
	Dim byte_array[4]
	
	f = FreeFile
	FileOpen(f, TILE_PATH$ + Mid$(tset_file$, 0, FindLastOf(".", tset_file$)) + ".tset", BINARY_INPUT)
	Stage_Tileset_Version[tset_num] = Read32(f)
	Stage_Tileset_NumTiles[tset_num] = Read32(f)
	
	If Stage_Tileset_NumTiles[tset_num] <= 0 Then
		Stage_Tileset_NumTiles[tset_num] = Int(Stage_Tileset_Image_Width[tset_num]/Stage_Tileset_Tile_Width) * Int(Stage_Tileset_Image_Height[tset_num]/Stage_Tileset_Tile_Height)
		Return True
	End If
	
	For i = 0 to Stage_Tileset_NumTiles[tset_num]-1
		'frame count
		Stage_Tileset_Tile_NumFrames[tset_num, i] = ReadByte(f)
		'frame indexes
		If Stage_Tileset_Tile_NumFrames[tset_num, i] > 0 Then
			For frame_num = 0 to Stage_Tileset_Tile_NumFrames[tset_num, i] - 1
				Stage_Tileset_Tile_Frame[tset_num, i, frame_num] = Read32(f)
			Next
		End If
	Next
	FileClose(f)
End Function


Sub SaveStage(Stage_file$)
	f = FreeFile
	FileOpen(f, STAGE_PATH$ + Stage_file$, BINARY_OUTPUT)
	
	Write32(f, Stage_Version)
	Write32(f, Stage_Tile_Width)
	Write32(f, Stage_Tile_Height)
	Write32(f, Stage_Pixel_Width)
	Write32(f, Stage_Pixel_Height)
	Write32(f, Stage_Tileset_Tile_Width)
	Write32(f, Stage_Tileset_Tile_Height)
	WriteByte(f, Stage_Tileset_Tile_FPS)
	
	For tset_num = 0 to MAX_TILESETS-1
		If Stage_Tileset_File$[tset_num] <> "" Then
			For i = 0 to Length(Stage_Tileset_File$[tset_num]) - 1
				WriteByte(f, Asc(Mid$(Stage_Tileset_File$[tset_num], i, 1)) )
			Next
		End If
		WriteByte(f, 0)
	Next
	
	For layer_num = 0 to MAX_LAYERS-1
		WriteByte(f, Stage_Layer_Type[layer_num])
		WriteByte(f, Stage_Layer_Active[layer_num])
		WriteByte(f, Stage_Layer_ColDet[layer_num])
		Write32(f, Stage_Layer_Shape_Count[layer_num])
		Write32(f, Stage_Layer_NumActors[layer_num])
		
		Select Case Stage_Layer_Type[layer_num]
		Case STAGE_LAYER_TYPE_BKG
			'Background File Name
			If Stage_Layer_Bkg_File$[layer_num] <> "" Then
				For i = 0 to Length(Stage_Layer_Bkg_File$[layer_num])-1
					WriteByte(f, Asc(Mid$(Stage_Layer_Bkg_File$[layer_num], i, 1)))
				Next
			End If
			WriteByte(f, 0)
			
			'Type and Flag
			WriteByte(f, Stage_Layer_Bkg_Type[layer_num])
			WriteByte(f, Stage_Layer_Bkg_Flag[layer_num])
			
			'Zoom
			Write32(f, Stage_Layer_Bkg_ZoomX[layer_num])
			Write32(f, Stage_Layer_Bkg_ZoomY[layer_num])
			
			'Angle
			Write32(f, Stage_Layer_Bkg_Angle[layer_num])
			
			'Blit
			Write32(f, Stage_Layer_Bkg_BlitX[layer_num])
			Write32(f, Stage_Layer_Bkg_BlitY[layer_num])
			Write32(f, Stage_Layer_Bkg_BlitW[layer_num])
			Write32(f, Stage_Layer_Bkg_BlitH[layer_num])
			
			Write32(f, Stage_Layer_Bkg_Scroll_HSpeed[layer_num]*1000)
			Write32(f, Stage_Layer_Bkg_Scroll_VSpeed[layer_num]*1000)
			
			'Color
			WriteByte(f, Stage_Layer_Bkg_Color[layer_num, 0])
			WriteByte(f, Stage_Layer_Bkg_Color[layer_num, 1])
			WriteByte(f, Stage_Layer_Bkg_Color[layer_num, 2])
			WriteByte(f, Stage_Layer_Bkg_Alpha[layer_num])
			
		Case STAGE_LAYER_TYPE_TILE
			For y = 0 to Stage_Tile_Height-1
				For x = 0 to Stage_Tile_Width-1
					WriteByte(f, Stage_Layer_Tile_Tileset[layer_num, y, x])
					Write32(f, Stage_Layer_Tile_Data[layer_num, y, x] + 1) 'Add one so that I don't store -1
				Next
			Next
		End Select
		
		If Stage_Layer_Shape_Count[layer_num] > 0 Then
			For i = 0 to Stage_Layer_Shape_Count[layer_num]-1
				WriteByte(f, Stage_Layer_Shape_Type[layer_num, i])
				Write32(f, Stage_Layer_Shape_X[layer_num, i])
				Write32(f, Stage_Layer_Shape_Y[layer_num, i])
				Write32(f, Stage_Layer_Shape_Param[layer_num, i, 0])
				Write32(f, Stage_Layer_Shape_Param[layer_num, i, 1])
			Next
		End If
		
		If Stage_Layer_NumActors[layer_num] > 0 Then
			For i = 0 to Stage_Layer_NumActors[layer_num]-1
				a = Stage_Layer_Actor[layer_num, i]
				a_name$ = Actor_Name$[a]
				c = 0
				While c < Length(a_name$)
					WriteByte(f, Asc(Mid$(a_name$, c, 1)))
					c = c + 1
				Wend
				WriteByte(f, 0)
				spr = Actor_Sprite[a]
				s_name$ = Sprite_Name$[spr]
				c = 0
				While c < Length(s_name$)
					WriteByte(f, Asc(Mid$(s_name, c, 1)))
					c = c + 1
				Wend
				WriteByte(f, 0)
				Write32(f, Actor_CurrentAnimation[a])
				Write32(f, Actor_X[a])
				Write32(f, Actor_Y[a])
				Write32(f, Actor_ZX[a])
				Write32(f, Actor_ZY[a])
				Write32(f, Actor_Angle[a])
				Write32(f, Actor_Physics[a])
			Next
		End If
	Next
	
	Write32(f, Stage_Sector_Width)
	Write32(f, Stage_Sector_Height)
	
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 to MAX_SECTORS_DOWN-1
			Write32(f, Stage_Sector_X[s_across, s_down])
			Write32(f, Stage_Sector_Y[s_across, s_down])
			Write32(f, Stage_Sector_NumShapes[s_across, s_down])
			If Stage_Sector_NumShapes[s_across, s_down] > 0 Then
				For shape_num = 0 to Stage_Sector_NumShapes[s_across, s_down]-1
					Write32(f, Stage_Sector_Shape_Layer[s_across, s_down, shape_num])
					Write32(f, Stage_Sector_Shape_Index[s_across, s_down, shape_num])
				Next
			End If
		Next
	Next
	
	FileClose(f)
	
	For spr = 0 to MAX_SPRITES-1
		If Sprite_inUse[spr] Then
			SaveSprite(spr)
		End If
	Next
	
End Sub

Function ClearStage(tw, th)
	For i = 0 to MAX_TILESETS-1
		ClearTilesetProperties(i)
		ClearTileset(i)
	Next
	Stage_Version = ENGINE_VERSION
	Stage_offset_x = 0
	Stage_offset_y = 0
	Stage_Tile_Width = tw
	Stage_Tile_Height = th
	Stage_Pixel_Width = 640
	Stage_Pixel_Height = 480
	Stage_Tileset_Tile_FPS = 8
	Stage_Tileset_Tile_Delay = 1000 / Stage_Tileset_Tile_FPS
	For tset_num = 0 to MAX_TILESETS-1
		Stage_Tileset_File$[tset_num] = ""
		If Stage_Tileset_ImageIsLoaded[tset_num] And ImageExists(Stage_Tileset_Image[tset_num]) Then
			DeleteImage(Stage_Tileset_Image[tset_num])
			Stage_Tileset_ImageIsLoaded[tset_num] = False
		End If
		ClearTilesetProperties(tset_num)
	Next
	
	For layer_num = 0 to MAX_LAYERS-1
		If Not ENGINE_EDITOR_USE Then
			CanvasClose(layer_num)
		End If
		Stage_Layer_Type[layer_num] = STAGE_LAYER_TYPE_NONE
		Stage_Layer_Active[layer_num] = False
		Stage_Layer_ColDet[layer_num] = False
		Stage_Layer_Shape_Count[layer_num] = 0
		
		Stage_Layer_Type[layer_num] = 0
		'Background File Name
		Stage_Layer_Bkg_File$[layer_num] = ""
			
		If Stage_Layer_Bkg_ImageIsLoaded[layer_num] And ImageExists(Stage_Layer_Bkg_Image[layer_num]) Then
			DeleteImage(Stage_Layer_Bkg_Image[layer_num])
			Stage_Layer_Bkg_ImageIsLoaded[layer_num] = False
		End If
			
		Stage_Layer_Bkg_Image[layer_num] = MAX_IMAGES
		Stage_Layer_Bkg_ImageIsLoaded[layer_num] = False
			
		'Flag
		Stage_Layer_Bkg_Type[layer_num] = STAGE_LAYER_BKG_TYPE_SURFACE
		Stage_Layer_Bkg_Flag[layer_num] = STAGE_LAYER_BKG_FLAG_NONE
			
		'Zoom
		Stage_Layer_Bkg_ZoomX[layer_num] = 1
		Stage_Layer_Bkg_ZoomY[layer_num] = 1
			
		'Angle
		Stage_Layer_Bkg_Angle[layer_num] = 0
			
		'Blit
		Stage_Layer_Bkg_BlitX[layer_num] = 0
		Stage_Layer_Bkg_BlitY[layer_num] = 0
		Stage_Layer_Bkg_BlitW[layer_num] = 0
		Stage_Layer_Bkg_BlitH[layer_num] = 0
			
		'Color
		Stage_Layer_Bkg_Color[layer_num, 0] = 0
		Stage_Layer_Bkg_Color[layer_num, 1] = 0
		Stage_Layer_Bkg_Color[layer_num, 2] = 0
		Stage_Layer_Bkg_Alpha[layer_num] = 255
			
		For y = 0 to MAX_STAGE_WIDTH-1
			For x = 0 to MAX_STAGE_HEIGHT-1
				Stage_Layer_Tile_Tileset[layer_num, y, x] = -1
				Stage_Layer_Tile_Data[layer_num, y, x] = -1
			Next
		Next
		
		For i = 0 to MAX_SHAPES_PER_LAYER-1
			Stage_Layer_Shape_Type[layer_num, i] = 0
			Stage_Layer_Shape_X[layer_num, i] = 0
			Stage_Layer_Shape_Y[layer_num, i] = 0
			Stage_Layer_Shape_Param[layer_num, i, 0] = 0
			Stage_Layer_Shape_Param[layer_num, i, 1] = 0
			Stage_Layer_Shape_Actor[layer_num, i] = -1
		Next
		Stage_Layer_NumActors[layer_num] = 0
	Next
	
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 to MAX_SECTORS_DOWN-1
			Stage_Sector_NumShapes[s_across, s_down] = 0
		Next
	Next
	
	For i = 0 to MAX_SPRITES-1
		DestroySprite(i)
	Next
	
	For i = 0 to MAX_ACTORS-1
		Actor_inUse[i] = 0
		Actor_Name$[i] = ""
		Actor_X[i] = 0
		Actor_Y[i] = 0
		Actor_Force_Speed[i] = 0
		Actor_Force_X[i] = 0
		Actor_Force_Y[i] = 0
		Actor_Force_Acceleration[i] = 0
		Actor_NewX[i] = 0
		Actor_NewY[i] = 0
		Actor_ZX[i] = 0
		Actor_ZY[i] = 0
		Actor_Momentum[i] = 0
		Actor_Jump[i] = 0
		Actor_Momentum[i] = 0
		Actor_Persistent[i] = 0
		Actor_Collision_Inside_Shape[i] = -1
	Next
	
End Function

Function NewStage(s_name$, stage_w, stage_h, tile_w, tile_h)
	ClearStage(stage_w, stage_h)
	Stage_Tileset_Tile_Width = tile_w
	Stage_Tileset_Tile_Height = tile_h
	Stage_Pixel_Width = Int(stage_w * tile_w)
	Stage_Pixel_Height = Int(stage_h * tile_h)
	Stage_Name$ = s_name$
End Function

Function LoadBkg(layer_num, bkg_file$)
	If Stage_Layer_Bkg_ImageIsLoaded[layer_num] Then
		DeleteImage(Stage_Layer_Bkg_Image[layer_num])
		Stage_Layer_Bkg_ImageIsLoaded[layer_num] = False
	Else
		Stage_Layer_Bkg_Image[layer_num] = GetFreeImage
	End If
	
	If Not FileExists(BKG_PATH$ + bkg_file$) Then
		Return 0
	End If
	
	LoadImage(Stage_Layer_Bkg_Image[layer_num], BKG_PATH$ + bkg_file$)
	SetImageAlpha(Stage_Layer_Bkg_Image[layer_num], Stage_Layer_Bkg_Alpha[layer_num])
	
	Dim w
	Dim h
	GetImageSize(Stage_Layer_Bkg_Image[layer_num], w, h)
	Stage_Layer_Bkg_Image_W[layer_num] = w
	Stage_Layer_Bkg_Image_H[layer_num] = h
	
	Stage_Layer_Bkg_ImageIsLoaded[layer_num] = True
	Stage_Layer_Bkg_File$[layer_num] = bkg_file$
	
	Return True
End Function

Function ClearBkg(layer_num)
	If layer_num < 0 Or layer_num >= MAX_LAYERS Then
		Return False
	End If
	If Stage_Layer_Bkg_ImageIsLoaded[layer_num] Then
		DeleteImage(Stage_Layer_Bkg_Image[layer_num])
		Stage_Layer_Bkg_ImageIsLoaded[layer_num] = False
	End If
	Return True
End Function

Sub Bkg_SetScrollSpeed(layer_num, h, v)
	Stage_Layer_Bkg_Scroll_HSpeed[layer_num] = h
	Stage_Layer_Bkg_Scroll_VSpeed[layer_num] = v
End Sub

Sub Bkg_SetAlpha(layer_num, a)
	If Stage_Layer_Bkg_ImageIsLoaded[layer_num] Then
		SetImageAlpha(Stage_Layer_Bkg_Image[layer_num], a)
	End If
	Stage_Layer_Bkg_Alpha[layer_num] = a
End Sub

Sub Bkg_SetType(layer_num, t)
	Stage_Layer_Bkg_Type[layer_num] = t
End Sub

Sub Bkg_SetFlag(layer_num, flag)
	Stage_Layer_Bkg_Flag[layer_num] = flag
End Sub

Sub Bkg_SetClearColor(layer_num, r, g, b)
	Stage_Layer_Bkg_Color[layer_num, 0] = r
	Stage_Layer_Bkg_Color[layer_num, 1] = g
	Stage_Layer_Bkg_Color[layer_num, 2] = b
End Sub

Sub Bkg_SetZoom(layer_num, zx, zy)
	Stage_Layer_Bkg_ZoomX[layer_num] = zx
	Stage_Layer_Bkg_ZoomY[layer_num] = zy
End Sub

Sub Bkg_SetAngle(layer_num, angle)
	Stage_Layer_Bkg_Angle[layer_num] = angle
End Sub

Sub Bkg_SetBlit(layer_num, x, y, w, h)
	Stage_Layer_Bkg_BlitX[layer_num] = x
	Stage_Layer_Bkg_BlitY[layer_num] = y
	Stage_Layer_Bkg_BlitW[layer_num] = w
	Stage_Layer_Bkg_BlitH[layer_num] = h
End Sub

Function LoadStage(Stage_file$)
	ClearStage(100, 100)
	
	f = FreeFile
	
	If Not FileExists(STAGE_PATH$ + Stage_File$) Then
		Return False
	End If
	
	Stage_Name$ = Mid$(Stage_file$, 0, FindLastOf(".", Stage_File$))
	
	FileOpen(f, STAGE_PATH$ + Stage_file$, BINARY_INPUT)
	
	Stage_Version = Read32(f)
	Stage_Tile_Width = Read32(f)
	Stage_Tile_Height = Read32(f)
	Stage_Pixel_Width = Read32(f)
	Stage_Pixel_Height = Read32(f)
	Stage_Tileset_Tile_Width = Read32(f)
	Stage_Tileset_Tile_Height = Read32(f)
	Stage_Tileset_Tile_FPS = ReadByte(f)
	
	Stage_Tileset_Tile_Delay = 1000 / Stage_Tileset_Tile_FPS
	
	For tset_num = 0 to MAX_TILESETS-1
		Stage_Tileset_File$[tset_num] = ""
		c = ReadByte(f)
		While c <> 0
			Stage_Tileset_File$[tset_num] = Stage_Tileset_File$[tset_num] + Chr$(c)
			c = ReadByte(f)
		Wend
		
		If Stage_Tileset_File$[tset_num] <> "" And FileExists(TILE_PATH$ + Stage_Tileset_File$[tset_num]) Then
			LoadTileSet(tset_num, Stage_Tileset_File$[tset_num])
		End If
	Next
	
	For layer_num = 0 to MAX_LAYERS-1
		
		If Not ENGINE_EDITOR_USE Then
			CanvasClose(layer_num)
			CanvasOpen(layer_num, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT, STAGE_SCREEN_POS_X, STAGE_SCREEN_POS_Y, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT, 1)
			SetCanvasZ(layer_num, (MAX_LAYERS-1)-layer_num)
		End If
	
		Stage_Layer_Type[layer_num] = ReadByte(f)
		Stage_Layer_Active[layer_num] = ReadByte(f)
		Stage_Layer_ColDet[layer_num] = ReadByte(f)
		Stage_Layer_Shape_Count[layer_num] = Read32(f)
		Stage_Layer_NumActors[layer_num] = Read32(f)
		
		Select Case Stage_Layer_Type[layer_num]
		Case STAGE_LAYER_TYPE_BKG
			'Background File Name
			Stage_Layer_Bkg_File$[layer_num] = ""
			c = ReadByte(f)
			While c <> 0
				Stage_Layer_Bkg_File$[layer_num] = Stage_Layer_Bkg_File$[layer_num] + Chr$(c)
				c = ReadByte(f)
			Wend
			
			If FileExists(BKG_PATH$ + Stage_Layer_Bkg_File$[layer_num]) And Stage_Layer_Bkg_File$[layer_num] <> "" Then
				LoadBkg(layer_num, Stage_Layer_Bkg_File$[layer_num])
				'Stage_Layer_Bkg_Image[layer_num] = GetFreeImage
				'LoadImage(Stage_Layer_Bkg_Image[layer_num], BKG_PATH$ + Stage_Layer_Bkg_File$[layer_num])
			Else
				Print "Could not find bkg_image: ";Stage_Layer_Bkg_File$[layer_num]
			End If
			
			'Type and Flag
			Stage_Layer_Bkg_Type[layer_num] = ReadByte(f)
			Stage_Layer_Bkg_Flag[layer_num] = ReadByte(f)
			
			'Zoom
			Stage_Layer_Bkg_ZoomX[layer_num] = Read32(f)
			Stage_Layer_Bkg_ZoomY[layer_num] = Read32(f)
			
			'Angle
			Stage_Layer_Bkg_Angle[layer_num] = Read32(f)
			
			'Blit
			Stage_Layer_Bkg_BlitX[layer_num] = Read32(f)
			Stage_Layer_Bkg_BlitY[layer_num] = Read32(f)
			Stage_Layer_Bkg_BlitW[layer_num] = Read32(f)
			Stage_Layer_Bkg_BlitH[layer_num] = Read32(f)
			
			Stage_Layer_Bkg_Scroll_HSpeed[layer_num] = Read32(f) / 1000
			Stage_Layer_Bkg_Scroll_VSpeed[layer_num] = Read32(f) / 1000
			
			'Print "H = "; Stage_Layer_Bkg_Scroll_HSpeed[layer_num]
			'Print "V = "; Stage_Layer_Bkg_Scroll_VSpeed[layer_num]
			
			'Color
			Stage_Layer_Bkg_Color[layer_num, 0] = ReadByte(f)
			Stage_Layer_Bkg_Color[layer_num, 1] = ReadByte(f)
			Stage_Layer_Bkg_Color[layer_num, 2] = ReadByte(f)
			Stage_Layer_Bkg_Alpha[layer_num] = ReadByte(f)
			
			If ImageExists(Stage_Layer_Bkg_Image[layer_num]) Then
				SetImageAlpha(Stage_Layer_Bkg_Image[layer_num], Stage_Layer_Bkg_Alpha[layer_num])
			End If
			
		Case STAGE_LAYER_TYPE_TILE
			For y = 0 to Stage_Tile_Height-1
				For x = 0 to Stage_Tile_Width-1
					Stage_Layer_Tile_Tileset[layer_num, y, x] = ReadByte(f)
					Stage_Layer_Tile_Data[layer_num, y, x] = Read32(f) - 1 'Subtract one because I added one on save
				Next
			Next
		End Select
		
		If Stage_Layer_Shape_Count[layer_num] > 0 Then
			For i = 0 to Stage_Layer_Shape_Count[layer_num]-1
				Stage_Layer_Shape_Type[layer_num, i] = ReadByte(f)
				Stage_Layer_Shape_X[layer_num, i] = Read32(f)
				Stage_Layer_Shape_Y[layer_num, i] = Read32(f)
				Stage_Layer_Shape_Param[layer_num, i, 0] = Read32(f)
				Stage_Layer_Shape_Param[layer_num, i, 1] = Read32(f)
			Next
		End If
		
		If Stage_Layer_NumActors[layer_num] > 0 Then
			For i = 0 to Stage_Layer_NumActors[layer_num]-1
				
				a_name$ = ""
				c = ReadByte(f)
				
				While c <> 0
					a_name$ = a_name$ + Chr$(c)
					c = ReadByte(f)
				Wend
				
				s_name$ = ""
				c = ReadByte(f)
				While c <> 0
					s_name$ = s_name$ + Chr$(c)
					c = ReadByte(f)
				Wend
				spr = LoadSprite_Ex(s_name$, False)
				a = NewActor(a_name$, spr)
				Actor_CurrentAnimation[a] = Read32(f)
				Actor_X[a] = Read32(f)
				Actor_Y[a] = Read32(f)
				'Actor New Pos
				Actor_NewX[a] = Actor_X[a]
				Actor_NewY[a] = Actor_Y[a]
				
				Actor_ZX[a] = Read32(f)
				Actor_ZY[a] = Read32(f)
				Actor_Angle[a] = Read32(f)
				Actor_Physics[a] = Read32(f)
				Stage_Layer_Actor[layer_num, i] = a
				Actor_LayerPosition[a] = i
				Actor_Layer[a] = layer_num
				Actor_SetAnimationFrame(a, 0)
			Next
		End If
		
	Next
	
	Stage_Sector_Width = Read32(f)
	Stage_Sector_Height = Read32(f)
	
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 to MAX_SECTORS_DOWN-1
			Stage_Sector_X[s_across, s_down] = Read32(f)
			Stage_Sector_Y[s_across, s_down] = Read32(f)
			Stage_Sector_NumShapes[s_across, s_down] = Read32(f)
			If Stage_Sector_NumShapes[s_across, s_down] > 0 Then
				For shape_num = 0 to Stage_Sector_NumShapes[s_across, s_down]-1
					Stage_Sector_Shape_Layer[s_across, s_down, shape_num] = Read32(f)
					Stage_Sector_Shape_Index[s_across, s_down, shape_num] = Read32(f)
				Next
			End If
		Next
	Next
	
	FileClose(f)
End Function

Sub Stage_Layer_SetTile(layer, tset, tile_index, x, y)
	x = Int(x/Stage_Tileset_Tile_Width)
	y = Int(y/Stage_Tileset_Tile_Height)
	Stage_Layer_Tile_Data[layer, y, x] = tile_index
	Stage_Layer_Tile_Tileset[layer, y, x] = tset
End Sub

Sub Stage_Layer_RemoveTile(layer, x, y)
	x = Int(x/Stage_Tileset_Tile_Width)
	y = Int(y/Stage_Tileset_Tile_Height)
	Stage_Layer_Tile_Data[layer, y, x] = -1
	Stage_Layer_Tile_Tileset[layer, y, x] = 0
End Sub

Sub Stage_Layer_DrawBkg(layer)
	If Not Stage_Layer_Bkg_ImageIsLoaded[layer] And Not Stage_Layer_Bkg_Type[layer] = STAGE_LAYER_BKG_TYPE_SURFACE Then
		Return
	End If
	
	Select Case Stage_Layer_Bkg_Type[layer]
	Case STAGE_LAYER_BKG_TYPE_IMAGE
		Select Case Stage_Layer_Bkg_Flag[layer]
		Case STAGE_LAYER_BKG_FLAG_NONE
			DrawImage(Stage_Layer_Bkg_Image[layer], 0, 0)
		Case STAGE_LAYER_BKG_FLAG_STRETCHED
			DrawImage_Blit_Ex(Stage_Layer_Bkg_Image[layer], 0, 0, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT, 0, 0, Stage_Layer_Bkg_Image_W[layer], Stage_Layer_Bkg_Image_H[layer])
		Case STAGE_LAYER_BKG_FLAG_BLIT
			DrawImage_Blit(Stage_Layer_Bkg_Image[layer], 0, 0, Stage_Layer_Bkg_BlitX[layer], Stage_Layer_Bkg_BlitY[layer], Stage_Layer_Bkg_BlitW[layer], Stage_Layer_Bkg_BlitH[layer])
		Case STAGE_LAYER_BKG_FLAG_TILED
			If Stage_Layer_Bkg_Image_H[layer] > 0 And Stage_Layer_Bkg_Image_W[layer] > 0 Then
				For y = 0 to STAGE_SCREEN_HEIGHT-1 Step Stage_Layer_Bkg_Image_H[layer]
					For x = 0 to STAGE_SCREEN_WIDTH-1 Step Stage_Layer_Bkg_Image_W[layer]
						DrawImage(Stage_Layer_Bkg_Image[layer], x, y)
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
						DrawImage(Stage_Layer_Bkg_Image[layer], x, y)
					Next
				Next
			End If
		End Select
	Case STAGE_LAYER_BKG_TYPE_SURFACE
		SetColor(RGBA(Stage_Layer_Bkg_Color[layer,0], Stage_Layer_Bkg_Color[layer,1], Stage_Layer_Bkg_Color[layer, 2], Stage_Layer_Bkg_Alpha[layer]))
		RectFill(0, 0, STAGE_SCREEN_WIDTH, STAGE_SCREEN_HEIGHT)
		'Need to add surface draw commands here
	End Select
End Sub

Sub SetShapeSector(layer, shape)
	shape_type = Stage_Layer_Shape_Type[layer, shape]
	shape_x1 = Stage_Layer_Shape_X[layer, shape]
	shape_y1 = Stage_Layer_Shape_Y[layer, shape]
	shape_x2 = Stage_Layer_Shape_Param[layer, shape, 0]
	shape_y2 = Stage_Layer_Shape_Param[layer, shape, 1]
	Dim condition1
	Dim condition2
	Dim condition3
	Dim condition4
	
	start_sector_x = 0
	start_sector_y = 0
	end_sector_x = 0
	end_sector_y = 0
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 to MAX_SECTORS_DOWN-1
			sector_x1 = s_across * Stage_Sector_Width
			sector_y1 = s_down * Stage_Sector_Height
			sector_x2 = sector_x1 + Stage_Sector_Width
			sector_y2 = sector_y1 + Stage_Sector_Height
			
			'point x1, y1 in sector
			condition1 = (shape_x1 >= sector_x1) And (shape_x1 < sector_x2) And (shape_y1 >= sector_y1) And (shape_y1 < sector_y2)
			
			'point x2, y2 in sector
			condition2 = (shape_x2 >= sector_x1) And (shape_x2 < sector_x2) And (shape_y2 >= sector_y1) And (shape_y2 < sector_y2)
			
			If condition1 Then
				start_sector_x = s_across
				start_sector_y = s_down
			End If
			
			If condition2 Then
				end_sector_x = s_across
				end_sector_y = s_down
			End If
			
		Next
	Next
	'print "s dimx: ";end_sector_x;", ";start_sector_x
	'print "s dimy: ";end_sector_y;", ";start_sector_y
	If start_sector_x > end_sector_x Then
		Push_N(start_sector_x)
		start_sector_x = end_sector_x
		end_sector_x = Pop_N
	End If
	
	If start_sector_y > end_sector_y Then
		Push_N(start_sector_y)
		start_sector_y = end_sector_y
		end_sector_y = Pop_N
	End If
	
	If start_sector_x >= 0 And start_sector_y >= 0 Then
		For s_across = start_sector_x to end_sector_x
			For s_down = start_sector_y to end_sector_y
				n = Stage_Sector_NumShapes[s_across, s_down]
				'Print "Sector: ";s_across;", ";s_down
				If n+1 >= MAX_SHAPES_PER_SECTOR Then
					Print "Too many shapes in sector ";s_across;", ";s_down
				Else
					'print "sect = ";s_across;", ";s_down
					Stage_Sector_Shape_Index[s_across, s_down, n] = shape
					Stage_Sector_Shape_Layer[s_across, s_down, n] = layer
					Stage_Sector_NumShapes[s_across, s_down] = n + 1
				End If
			Next
		Next
	End If
End Sub

Sub SetShapeSector_All(layer, shape)
	shape_type = Stage_Layer_Shape_Type[layer, shape]
	shape_x1 = Stage_Layer_Shape_X[layer, shape]
	shape_y1 = Stage_Layer_Shape_Y[layer, shape]
	shape_x2 = Stage_Layer_Shape_Param[layer, shape, 0]
	shape_y2 = Stage_Layer_Shape_Param[layer, shape, 1]
	
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 To MAX_SECTORS_DOWN-1
			n = Stage_Sector_NumShapes[s_across, s_down]
			'Print "Sector: ";s_across;", ";s_down
			If n+1 >= MAX_SHAPES_PER_SECTOR Then
				Print "Too many shapes in sector ";s_across;", ";s_down
			Else
				'print "sect = ";s_across;", ";s_down
				Stage_Sector_Shape_Index[s_across, s_down, n] = shape
				Stage_Sector_Shape_Layer[s_across, s_down, n] = layer
				Stage_Sector_NumShapes[s_across, s_down] = n + 1
			End If
		Next
	Next
End Sub

Function Stage_Layer_AddShape(layer, shape_type, x, y, p1, p2)
	If Stage_Layer_Shape_Count[layer]+1 >=  MAX_SHAPES_PER_LAYER Then
		Return -1
	End If
	
	shape_num = Stage_Layer_Shape_Count[layer]
	Stage_Layer_Shape_Count[layer] = shape_num + 1
	
	Stage_Layer_Shape_X[layer, shape_num] = x
	Stage_Layer_Shape_Y[layer, shape_num] = y
	Stage_Layer_Shape_Param[layer, shape_num, 0] = p1
	Stage_Layer_Shape_Param[layer, shape_num, 1] = p2
	Stage_Layer_Shape_Type[layer, shape_num] = shape_type
	
	SetShapeSector(layer, shape_num)
	
	Return shape_num
End Function

Function Stage_Layer_AddShape_AllSectors(layer, shape_type, x, y, p1, p2)
	If Stage_Layer_Shape_Count[layer]+1 >=  MAX_SHAPES_PER_LAYER Then
		Return -1
	End If
	
	shape_num = Stage_Layer_Shape_Count[layer]
	Stage_Layer_Shape_Count[layer] = shape_num + 1
	
	Stage_Layer_Shape_X[layer, shape_num] = x
	Stage_Layer_Shape_Y[layer, shape_num] = y
	Stage_Layer_Shape_Param[layer, shape_num, 0] = p1
	Stage_Layer_Shape_Param[layer, shape_num, 1] = p2
	Stage_Layer_Shape_Type[layer, shape_num] = shape_type
	
	SetShapeSector_All(layer, shape_num)
	
	Return shape_num
End Function

Sub Stage_Layer_AddActorDynaRec(actor, layer)
	spr = Actor_Sprite[actor]
	p1 = Sprite_Frame_Bound_Param[spr, 0, 0]+1
	p2 = Sprite_Frame_Bound_Param[spr, 0, 1]
	
	px = Sprite_Frame_Bound_X[spr, 0]
	py = Sprite_Frame_Bound_Y[spr, 0]
	
	'Print "P -> ";px;", ";py
	
	'Print "Actor = ";Actor_X[actor]+px;", ";Actor_Y[actor]+py;", ";p1;", ";p2
	
	Actor_Shape[actor] = Stage_Layer_AddShape(layer, SHAPE_TYPE_DYNARECT, Actor_X[actor]+px, Actor_Y[actor]+py, Actor_X[actor] + p1, Actor_Y[actor] + p2)
	Stage_Layer_Shape_Actor[layer, Actor_Shape[actor]] = actor
	Actor_Physics[actor] = False
	Actor_Shape_Layer[actor] = layer
	Actor_Persistent[actor] = True
End Sub

Sub Stage_Layer_AddActorDynaRec_AllSectors(actor, layer)
	spr = Actor_Sprite[actor]
	p1 = Sprite_Frame_Bound_Param[spr, 0, 0]+1
	p2 = Sprite_Frame_Bound_Param[spr, 0, 1]
	
	px = Sprite_Frame_Bound_X[spr, 0]
	py = Sprite_Frame_Bound_Y[spr, 0]
	
	'Print "P -> ";px;", ";py
	
	'Print "Actor = ";Actor_X[actor]+px;", ";Actor_Y[actor]+py;", ";p1;", ";p2
	
	Actor_Shape[actor] = Stage_Layer_AddShape_AllSectors(layer, SHAPE_TYPE_DYNARECT, Actor_X[actor]+px, Actor_Y[actor]+py, Actor_X[actor] + p1, Actor_Y[actor] + p2)
	Stage_Layer_Shape_Actor[layer, Actor_Shape[actor]] = actor
	Actor_Physics[actor] = False
	Actor_Shape_Layer[actor] = layer
	Actor_Persistent[actor] = True
End Sub

Function Stage_Layer_RemoveShape(layer, shape_num)
	If shape_num >= Stage_Layer_Shape_Count[layer] Then
		Return 0
	End If
	
	shape_type = Stage_Layer_Shape_Type[layer, shape_num]
	shape_x1 = Stage_Layer_Shape_X[layer, shape_num]
	shape_y1 = Stage_Layer_Shape_Y[layer, shape_num]
	shape_x2 = Stage_Layer_Shape_Param[layer, shape_num, 0]
	shape_y2 = Stage_Layer_Shape_Param[layer, shape_num, 1]
	
	For s_across = 0 to MAX_SECTORS_ACROSS-1
		For s_down = 0 to MAX_SECTORS_DOWN-1
			If Stage_Sector_NumShapes[s_across, s_down] > 0 Then
				For s_index = 0 to Stage_Sector_NumShapes[s_across, s_down]-1
					If Stage_Sector_Shape_Layer[s_across, s_down, s_index] = layer And Stage_Sector_Shape_Index[s_across, s_down, s_index] = shape_num Then
						For s_index2 = s_index to Stage_Sector_NumShapes[s_across, s_down]-1
							Stage_Sector_Shape_Index[s_across, s_down, s_index2] = Stage_Sector_Shape_Index[s_across, s_down, s_index2 + 1]
							Stage_Sector_Shape_Layer[s_across, s_down, s_index2] = Stage_Sector_Shape_Layer[s_across, s_down, s_index2 + 1]
						Next
						Stage_Sector_NumShapes[s_across, s_down] = Stage_Sector_NumShapes[s_across, s_down] - 1
						'Print "Removed From Sector: ";s_across;", ";s_down
						Exit For
					End If
				Next
			End If
		Next
	Next
	
	num_shapes_to_sort = Stage_Layer_Shape_Count[layer] - shape_num - 1
	
	If num_shapes_to_sort > 0 Then
		For i = shape_num to shape_num + num_shapes_to_sort
			Stage_Layer_Shape_Type[layer, i] = Stage_Layer_Shape_Type[layer, i+1]
			Stage_Layer_Shape_X[layer, i] = Stage_Layer_Shape_X[layer, i+1]
			Stage_Layer_Shape_Y[layer, i] = Stage_Layer_Shape_Y[layer, i+1]
			Stage_Layer_Shape_Param[layer, i, 0] = Stage_Layer_Shape_Param[layer, i+1, 0]
			Stage_Layer_Shape_Param[layer, i, 1] = Stage_Layer_Shape_Param[layer, i+1, 1]
		Next
	End If
	
	
	Stage_Layer_Shape_Count[layer] = Stage_Layer_Shape_Count[layer] - 1
	If Stage_Layer_Shape_Count[layer] < 0 Then
		Stage_Layer_Shape_Count[layer] = 0
	End If
	return True
End Function


Sub Actor_SetOffsetFrom(actor, offset_actor, x, y)
	Actor_OffsetActor[actor,0] = offset_actor
	Actor_OffsetActor[actor,1] = x
	Actor_OffsetActor[actor,2] = y
End Sub

'Render
Sub Actor_SyncAnimationTo(actor, parent)
	Actor_AnimationSync[actor] = true
	Actor_AnimationParent[actor] = parent
End Sub

Sub Actor_UnSyncAnimation(actor)
	Actor_AnimationSync[actor] = false
End Sub

Sub Actor_Force(actor, fx, fy)
	If Actor_Physics_State[actor] = PHYSICS_STATE_RISE Then
		Actor_Force_X[actor] = fx + fx/2
		If fy > 0 Then
			Actor_Force_Y[actor] = fy/4
		End If
	ElseIf Actor_Physics_State[actor] = PHYSICS_STATE_FALL Then
		Actor_Force_X[actor] = fx + fx/4
		If fy > 0 Then
			Actor_Force_Y[actor] = fy
		End If
	Else
		Actor_Force_X[actor] = fx
		Actor_Force_Y[actor] = fy
		Actor_Move(actor, fx, fy)
	End If
	'Actor_Physics_State[0] = PHYSICS_STATE_RISE
End Sub

Dim Actor_AnimationEnded[MAX_ACTORS]

Sub Stage_DrawActor(actor)
	Actor_AnimationEnded[actor] = False
	If (Not Actor_Active[actor]) Then
		'print Actor_Name$[actor];" is not active"
		Return
	ElseIf (Not Actor_isOnScreen(actor)) And (Actor_OffsetActor[actor, 0] < 0) And (Not Actor_Persistent[actor])  Then
		'print Actor_Name$[actor];" is not onscreen"
		Return
	End If
	sprite = Actor_Sprite[actor]
	anim = Actor_CurrentAnimation[actor]
	dx = 0
	new_frame= Actor_CurrentFrame[actor]
	
	'debug = (actor = GetActorID("guard_death"))
	
	If Actor_AnimationSync[actor] Then
		Actor_CurrentFrame[actor] = Actor_CurrentFrame[Actor_AnimationParent[actor]]
	ElseIf Sprite_Animation_NumFrames[sprite, anim] > 1 Then
		t = Timer
		
		'if debug then
		'	print "dbg1: "; t
		'	print "cframe time = ";Actor_CurrentFrameTime[actor]
		'	print "delay = ";Actor_CurrentFrameDelay[actor]
		'end if
		
		
		If t - Actor_CurrentFrameTime[actor] > Actor_CurrentFrameDelay[actor] Then
			Actor_CurrentFrameTime[actor] = t
			old_frame = Actor_CurrentFrame[actor]
			new_frame = 0
			
			'if debug then
			'	print "dbg2:";Actor_CurrentFrame[actor]
			'End If
			
			If Actor_CurrentFrame[actor]+1 < Sprite_Animation_NumFrames[sprite, anim] Then
				'Actor_CurrentFrame[actor] = Actor_CurrentFrame[actor] + 1
				new_frame = Actor_CurrentFrame[actor] + 1
			Else
				'Actor_CurrentFrame[actor] = 0
				new_frame = 0
				Actor_AnimationEnded[actor] = True
			End If
			current_frame = Actor_CurrentFrame[actor]
			dx = sign(Sprite_Frame_Bound_X[sprite, new_frame] - Sprite_Frame_Bound_X[sprite, old_frame])
			dx = dx * abs( (Sprite_Frame_Bound_X[sprite, new_frame] - Sprite_Frame_Bound_X[sprite, old_frame]) -1 )
		End If
	End If
	
	'dx = 0
	If Actor_OffsetActor[actor, 0] >= 0 Then
		Actor_X[actor] = Actor_X[ Actor_OffsetActor[actor, 0] ] + Actor_OffsetActor[actor, 1]
		Actor_Y[actor] = Actor_Y[ Actor_OffsetActor[actor, 0] ] + Actor_OffsetActor[actor, 2]
	ElseIf Stage_Layer_ColDet[ Actor_Layer[actor] ] Then
		aw = 0
		If Actor_Physics[actor] Then
			If Stage_Layer_Physics[ Actor_Layer[actor] ] Then
				If Actor_Physics_State[actor] = PHYSICS_STATE_RISE Then
					'print "DRec: "; Actor_DynaRect_SpeedAdjust[actor, 1]
					'print "YF: "; Actor_Force_Y[actor]
					Actor_Y[actor] = Actor_Y[actor] - 1
					If Actor_DynaRect_SpeedAdjust[actor, 1] < 0 Then
						Actor_Force_Y[actor] = Actor_Force_Y[actor] + Actor_DynaRect_SpeedAdjust[actor, 1]
						Actor_NewY[actor] = Actor_NewY[actor] + Actor_Force_Y[actor]
						Actor_Y[actor] = Actor_Y[actor] + Actor_Force_Y[actor]
					End If
					Actor_Move(actor, Actor_Force_X[actor], Actor_Force_Y[actor])
					'Actor_Move(actor, 2, 2)
					If Actor_Jump[actor] > 0 Then
						Actor_Jump[actor] = Actor_Jump[actor] + Actor_Force_Y[actor]
					Else
						Actor_Physics_State[actor] = PHYSICS_STATE_FALL
					End If
				ElseIf Actor_Physics_State[actor] = PHYSICS_STATE_FALL Then
					Actor_Move(actor, Actor_Force_X[actor], Actor_Weight[actor])
					aw = Actor_Weight[actor]
				Else
					Actor_Move(actor, Actor_DynaRect_SpeedAdjust[actor, 0], Actor_DynaRect_SpeedAdjust[actor, 1])
				End If
			End If
		End If
		
		old_f = Sprite_Animation_Frame[ sprite, anim, Actor_CurrentFrame[actor]]
		new_f = Sprite_Animation_Frame[ sprite, anim, new_frame]
		
		If Actor_isOnScreen(actor) Then
			World_ActorToActor_Collisions(actor, old_f, Actor_X[actor], Actor_Y[actor], new_f, Actor_NewX[actor], Actor_NewY[actor])
		End If
		'World_Actor_Collision(actor, old_f, Actor_X[actor], Actor_Y[actor], new_f, Actor_NewX[actor], Actor_NewY[actor])
		
		
		'World_ActorToActor_Collisions(actor, Actor_CurrentFrame[actor], Actor_X[actor], Actor_Y[actor], new_frame, Actor_NewX[actor], Actor_NewY[actor])
		If Actor_Physics[actor] Then
			If Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
				'Actor_Move(actor, Actor_DynaRect_SpeedAdjust[actor, 0], 2)
				World_Actor_Collision(actor, Actor_CurrentFrame[actor], Actor_X[actor], Actor_Y[actor]-aw, new_frame, Actor_NewX[actor], Actor_NewY[actor])
				'Actor_Move(actor, Actor_DynaRect_SpeedAdjust[actor, 0],  0)
			Else
				'Actor_Move(actor, Actor_DynaRect_SpeedAdjust[actor, 0], 0)
				World_Actor_Collision(actor, Actor_CurrentFrame[actor], Actor_X[actor], Actor_Y[actor]-aw, new_frame, Actor_NewX[actor], Actor_NewY[actor])
				'Actor_Move(actor, Actor_DynaRect_SpeedAdjust[actor, 0],  0)
			End If
		
		
			If Actor_NumStageCollisions[actor] = 0 Then
				Actor_CurrentFrame[actor] = new_frame
				Actor_X[actor] = Actor_NewX[actor]
				Actor_Y[actor] = Actor_NewY[actor]
				If Actor_Physics_State[actor] = PHYSICS_STATE_GROUND Then
					Actor_Physics_State[actor] = PHYSICS_STATE_FALL
				End If
				'print "test: ";Actor_X[actor]
			Else
				'print "dx = ";dx
				'print "num collisions = ";Actor_NumStageCollisions[actor]
				b_width = Sprite_Frame_Bound_Param[sprite, new_frame, 0] ' - Sprite_Frame_Bound_X[sprite, new_frame]
				b_height = Sprite_Frame_Bound_Param[sprite, new_frame, 1]
				old_frame = Actor_CurrentFrame[actor]
				Actor_CurrentFrame[actor] = new_frame
				h_collide = false
				v_collide = false
				lh_collide = false
				lv_collide = false
				'l_collide = false
				For c = 0 to Actor_NumStageCollisions[actor]-1
					Select Case Actor_Stage_Collision_From_Direction[actor, c]
					Case COLLISION_DIR_RIGHT
						If Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND Then
							Actor_Speed[actor] = 0
						End If
						
						If Not h_collide Then 
							Actor_X[actor] = (Actor_Stage_Collision_X[actor, c] + 1) - Sprite_Frame_Bound_X[sprite, new_frame]
						End If
						h_collide = True
						'print "right collide"
					Case COLLISION_DIR_LEFT
						If Actor_Physics_State[actor] <> PHYSICS_STATE_GROUND Then
							Actor_Speed[actor] = 0
						End If
						
						If Not h_collide Then 
							Actor_X[actor] = (Actor_Stage_Collision_X[actor, c] - 1) - b_width
						End If
						h_collide = True
						'print "left collide"
					Case COLLISION_DIR_TOP
						If Actor_Physics_State[actor] = PHYSICS_STATE_FALL Then
							Actor_Physics_State[actor] = PHYSICS_STATE_GROUND
						End If
						
						If Not v_collide Then
							Actor_Y[actor] = (Actor_Stage_Collision_Y[actor, c] - 1) - b_height + 1
						End If
						v_collide = True
						'print "top collide"
					Case COLLISION_DIR_BOTTOM
						If Actor_Physics_State[actor] = PHYSICS_STATE_RISE Then
							Actor_Physics_State[actor] = PHYSICS_STATE_FALL
						End If
					
						If Not v_collide Then
							Actor_Y[actor] = ((Actor_Stage_Collision_Y[actor, c] + 1) - Sprite_Frame_Bound_Y[sprite, new_frame] ) + Actor_Weight[actor]
							'print Actor_Y[actor]
						End If
						v_collide = True
						'print "bottom collide"
					Case COLLISION_LINE_RIGHT
						If Not lh_collide Then 
							Actor_X[actor] = (Actor_Stage_Collision_X[actor, c] + 1) - Sprite_Frame_Bound_X[sprite, new_frame]
						End If
						lh_collide = True
					Case COLLISION_LINE_LEFT
						If Not lh_collide Then 
							Actor_X[actor] = (Actor_Stage_Collision_X[actor, c] - 1) - b_width
						End If
						lh_collide = True
						'print "left collide"
					Case COLLISION_LINE_TOP
						If Not lv_collide Then
							Actor_Y[actor] = (Actor_Stage_Collision_Y[actor, c] - 1) - b_height
						End If
						lv_collide = True
						'print "top collide"
					Case COLLISION_LINE_BOTTOM
						If Not lv_collide Then
							Actor_Y[actor] = (Actor_Stage_Collision_Y[actor, c] + 1) - Sprite_Frame_Bound_Y[sprite, new_frame]
						End If
						lv_collide = True
						'print "bottom collide"
					End Select
				Next
				If Not (h_collide Or lh_collide) Then
					Actor_X[actor] = Actor_NewX[actor]
				Else
					Actor_X[actor] = Actor_X[actor] + Actor_DynaRect_SpeedAdjust[actor, 0]
				End If
				If Not (v_collide Or lv_collide) Then
					Actor_Y[actor] = Actor_NewY[actor]
				Else
					Actor_Y[actor] = Actor_Y[actor] - Actor_DynaRect_SpeedAdjust[actor, 1]
				End If
			End If
		Else
			If Actor_Move_Flag[actor] Then
				Actor_X[actor] = Actor_NewX[actor]
				Actor_Y[actor] = Actor_NewY[actor]
			End If
			Actor_CurrentFrame[actor] = new_frame
		End If
	Else
		Actor_CurrentFrame[actor] = new_frame
		Actor_X[actor] = Actor_NewX[actor]
		Actor_Y[actor] = Actor_NewY[actor]
	End If
	
	Actor_NewX[actor] = Actor_X[actor]
	Actor_NewY[actor] = Actor_Y[actor]
	Actor_Move_Flag[actor] = False
	
	frame = Actor_CurrentFrame[actor]
	
	Dim x
	Dim y
	Dim w
	Dim h
	
	If Actor_Visible[actor] And Actor_isOnScreen(actor) Then
		src_x = Int(Sprite_Animation_Frame[sprite, anim, frame] Mod Sprite_Image_WidthInFrames[sprite]) * Sprite_Frame_Width[sprite]
		src_y = Int(Sprite_Animation_Frame[sprite, anim, frame] / Sprite_Image_WidthInFrames[sprite]) * Sprite_Frame_Height[sprite]
		src_w = Sprite_Frame_Width[sprite]
		src_h = Sprite_Frame_Height[sprite]
		img = Sprite_Image[sprite]
		x = Actor_X[actor]
		y = Actor_Y[actor] '- Actor_DynaRect_SpeedAdjust[actor, 1]
		
		'if actor = GetActorID("beam_sword") then
		'	print "current frame = ";frame
		'End If
		
		If Actor_Effect_Active[actor] Then
			Select Case Actor_Effect_Type[actor]
			Case EFFECT_FLASH 'DOES NOT WORK CURRENTLY
				If (Timer - Actor_Effect_Timer[actor]) > (Actor_Effect_Time[actor]) Then
					Actor_Effect_Timer[actor] = Timer
					Actor_Effect_Value[actor] = Not Actor_Effect_Value[actor]
					alpha_value = Actor_Effect_Value[actor]
					If alpha_value Then
						alpha_value = 255
					Else
						alpha_value = 160
					End If
					'print "DEBUG:  Effect_Time=";Actor_Effect_Time[actor];"  Effect_Value=";Actor_Effect_Value[actor];"   Effect_Increment=";Actor_Effect_Increment[actor]
					SetImageAlpha(img, alpha_value)
				End If
			Default
				'Do nothing
			End Select
		End If
					
		
		w = Sprite_Frame_Width[sprite] * Actor_ZX[actor]
		h = Sprite_Frame_Height[sprite] * Actor_ZY[actor]
		DrawImage_Blit_Ex(img, x-Stage_offset_x, y-Stage_offset_y, w, h, src_x, src_y, src_w, src_h)
		
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 0] = 0
		Stage_Layer_Shape_Attribute[Actor_Shape_Layer[actor], Actor_Shape[actor], 1] = 0
		
		Return
		'Draw Hit box
		SetColor(rgb(255,0,0))
		
		sprite_f = Sprite_Animation_Frame[sprite, anim, frame]
		
		x = Sprite_Frame_Bound_X[sprite, sprite_f] + (x-Stage_offset_x)
		y = Sprite_Frame_Bound_Y[sprite, sprite_f] + (y-Stage_offset_y)
		w = Sprite_Frame_Bound_Param[sprite, sprite_f, 0] - Sprite_Frame_Bound_X[sprite, sprite_f]
		h = Sprite_Frame_Bound_Param[sprite, sprite_f, 1] - Sprite_Frame_Bound_Y[sprite, sprite_f]
		Rect(x, y, w, h)
	Else
		Return
		SetColor(rgb(255,0,0))
		
		sprite_f = Sprite_Animation_Frame[sprite, anim, frame]
		
		x = Sprite_Frame_Bound_X[sprite, sprite_f] + (x-Stage_offset_x)
		y = Sprite_Frame_Bound_Y[sprite, sprite_f] + (y-Stage_offset_y)
		w = Sprite_Frame_Bound_Param[sprite, sprite_f, 0] - Sprite_Frame_Bound_X[sprite, sprite_f]
		h = Sprite_Frame_Bound_Param[sprite, sprite_f, 1] - Sprite_Frame_Bound_Y[sprite, sprite_f]
		Rect(x, y, w, h)
	End If
	
End Sub

Sub DrawShapes(layer)
	Dim sect_x[9]
	Dim sect_y[9]
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
		
	SetColor(rgb(0,255,0))
		
	For i = 0 to 8
		sector_x = sect_x[i]
		sector_y = sect_y[i]
		If sector_x >= 0 And sector_y >= 0 Then
			If Stage_Sector_NumShapes[sector_x, sector_y] > 0 Then
				For shape_num = 0 to Stage_Sector_NumShapes[sector_x, sector_y]-1
					If Stage_Sector_Shape_Layer[sector_x, sector_y, shape_num] = layer Then
						shape_index = Stage_Sector_Shape_Index[sector_x, sector_y, shape_num]
						x = Stage_Layer_Shape_X[layer, shape_index] - Stage_offset_x
						y = Stage_Layer_Shape_Y[layer, shape_index] - Stage_offset_y
						p1 = Stage_Layer_Shape_Param[layer, shape_index, 0] - Stage_offset_x
						p2 = Stage_Layer_Shape_Param[layer, shape_index, 1] - Stage_offset_y
						Select Case Stage_Layer_Shape_Type[layer, shape_index]
						Case SHAPE_TYPE_LINE
							Line(x, y, p1, p2)
						Case SHAPE_TYPE_RECT
							Box(x, y, p1, p2)
						Case SHAPE_TYPE_DYNARECT
							Box(x, y, p1, p2)
						End Select
					End If
				Next
			End If
		End If
	Next
End Sub	

Function Game_Render()
	If Stage_Tile_Width <= 0 And Stage_Tile_Height <= 0 Then
		Return 0
	End If
	
	t = timer
	
	
	off_x = Stage_offset_x Mod Stage_Tileset_Tile_Width * -1
	off_y = Stage_offset_y Mod Stage_Tileset_Tile_Height * -1
	
	draw_w = STAGE_SCREEN_WIDTH
	draw_h = STAGE_SCREEN_HEIGHT
	
	If (off_x + draw_w + Stage_Tileset_Tile_Width) < Stage_Pixel_Width Then
		draw_w = draw_w + Stage_Tileset_Tile_Width
	End If
	
	If (off_y + draw_h + Stage_Tileset_Tile_Height) < Stage_Pixel_Height Then
		draw_h = draw_h + Stage_Tileset_Tile_Height
	End If
	
	
	For layer = 0 to MAX_LAYERS-1
		Canvas(layer)
		ClearCanvas
		If Stage_Layer_Physics[layer] Then
			ClearActorCollisions(layer)
		End If
		
		If Stage_Layer_Type[layer] = STAGE_LAYER_TYPE_TILE Then
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
						DrawImage_Blit(Stage_Tileset_Image[tset], off_x + sx, off_y + sy, src_x, src_y, Stage_Tileset_Tile_Width, Stage_Tileset_Tile_Height)
					End If
				Next
			Next
		ElseIf Stage_Layer_Type[layer] = STAGE_LAYER_TYPE_BKG Then
			Stage_Layer_DrawBkg(layer)
		End If
		
		'DrawShapes(layer)
		
		If Stage_Layer_NumActors[layer] > 0 Then
			For a = 0 to Stage_Layer_NumActors[layer]-1
				Stage_DrawActor(Stage_Layer_Actor[layer, a])
			Next
		End If
	Next
	
	'SetColor(RGB(255,255,255))
	'DrawText("FPS: " + Str(FPS), 10, 10)
	
	/'
	If OS$ = "ANDROID" Or OS$ = "IOS" Then
		For i = 0 to 7
			touch_button[i] = 20 + (i*touch_button_size) + (i*4)
			DrawImage_Blit(MOBILE_BUTTONS_IMAGE, touch_button[i], touch_button_y, i * touch_button_size, 0, touch_button_size, touch_button_size)
		Next
	End If
	'/
	Update
	Wait(0)
End Function

Function Game_WindowOpen(t$, w, h, flag)
	WindowOpen(0, t$, WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, w, h, flag, 1)
	STAGE_SCREEN_POS_X = 0
	STAGE_SCREEN_POS_Y = 0
	STAGE_SCREEN_WIDTH = w
	STAGE_SCREEN_HEIGHT = h
End Function

Function Stage_SetViewport(x, y, w, h)
	STAGE_SCREEN_POS_X = x
	STAGE_SCREEN_POS_Y = y
	STAGE_SCREEN_WIDTH = w
	STAGE_SCREEN_HEIGHT = h
	For i = 0 to MAX_LAYERS-1
		SetCanvasViewport(i, x, y, w, h)
	Next
End Function

Sub Stage_SetOffset(x, y)
	If x >= 0 And x + STAGE_SCREEN_WIDTH < Stage_Pixel_Width Then
		stage_offset_x = x
	End If
	If y >= 0 And y + STAGE_SCREEN_HEIGHT < Stage_Pixel_Height Then
		stage_offset_y = y
	End If
End Sub

Sub Stage_MoveOffset(x, y)
	move_x = stage_offset_x + x
	move_y = stage_offset_y + y
	If move_x >= 0 And move_x + STAGE_SCREEN_WIDTH < Stage_Pixel_Width Then
		stage_offset_x = move_x
	ElseIf move_x >= 0 Then
		stage_offset_x = Stage_Pixel_Width - STAGE_SCREEN_WIDTH - 1
	Else
		stage_offset_x = 0
	End If
	If move_y >= 0 And move_y + STAGE_SCREEN_HEIGHT < Stage_Pixel_Height Then
		stage_offset_y = move_y
	ElseIf move_y >= 0 Then
		stage_offset_y = Stage_Pixel_Height - STAGE_SCREEN_HEIGHT - 1
	Else
		stage_offset_y = 0
	End If
End Sub

Sub Stage_FadeOut()
	alpha = 0
	t = timer
	
	While alpha < 255
		If timer - t > 3 Then
			alpha = alpha + 2
			t = timer
		End If
		Canvas(5)
		SetColor( RGBA(0,0,0,alpha))
		RectFill(0,0,STAGE_SCREEN_WIDTH,STAGE_SCREEN_HEIGHT)
		Update
	Wend
End Sub

Sub Stage_FadeIn()
	alpha = 255
	t = timer
	
	Canvas(5)
	SetColor( RGBA(0,0,0,alpha))
	RectFill(0,0,640,480)
	
	While alpha > 0
		If timer - t > 3 Then
			alpha = alpha - 2
			t = timer
		End If
		
		SetCanvasAlpha(5, alpha)
		
		Game_Render
	Wend
	SetCanvasAlpha(5,255)
End Sub
