Sub Engine_Init() 'Initializes

Function GetFreeImage() 'Get a free image slot

Function NewActor(a_name$, spr) 'Create a new actor from a loaded sprite

Function SaveActor(actor) 'Save a actor to a file (Not currently used)

Function GetActorID(a_name$) 'Returns the actor with the given name or -1 on failure

Function GetSpriteID(s_name$) 'Returns the sprite with the given name for -1 on failure

Function LoadActor(a_name$) 'Load a actor from a file (Not currently used)

Sub RemoveActor(actor) 'Remove an actor from the stage

Sub DestroyActor(actor) 'Remove an actor from the game

Function Actor_SetLayer(actor, layer) 'Sets an actors layer

Function Actor_SetAnimation(actor, anim) 'Sets an actors animation

Function Actor_SetAnimationByName(actor, a_name$) 'Sets an actors animation by the given name

Sub Actor_SetPosition(actor, x, y) 'Sets the position of the actor within the stage

Function LoadSprite(spr_name$) 'Loads a sprite from a file

Function LoadSprite_Ex(spr_name$, overwrite_flag) 'Loads a sprite from a file; overwrite_flag determines if the sprite should overwrite a sprite with the same name if one exists

Function SaveSprite(sprite) 'Save a sprites settings to a file

Function NewSprite(spr_file$, frame_w, frame_h) 'Create a new sprite from the given image file; frame_w, frame_h are the size of the frames in the image file

Sub DestroySprite(sprite) 'Removes a sprite from the game

Function Sprite_CreateAnimation(sprite, anim_name$) 'Returns the number of the new animation for the sprite

Sub Sprite_RemoveAnimation(sprite, anim) 'Remove the given animation from the sprite

Function Sprite_Animation_AddFrame(sprite, anim, frame_index) 'Add a frame to a sprite animation; frame_index references the frame number in the image

Sub Sprite_Animation_RemoveFrame(sprite, anim) 'Remove the given animation from the sprite

Sub SaveTileSet(tset_num, tset_file$) 'Save a tileset to a file

Sub ClearTilesetProperties(tset_num) 'Clears a tileset properties (used by loadStage)

Sub ClearTileset(tset_num) 'Clears a tileset (used by loadStage)

Sub SetTileSize(w, h) 'Sets the tile size for the stage

Function LoadTileSet(tset_num, tset_file$) 'loads a tileset from a file; tset_num must be less than MAX_TILESETS

Sub SaveStage(Stage_file$) 'save a stage to a file

Function ClearStage(tw, th) 'Clears the contents of the current stage (used by loadStage)

Function NewStage(s_name$, stage_w, stage_h, tile_w, tile_h) 'Create a new stage

Function LoadBkg(layer_num, bkg_file$) 'load a background to a layer from an image file

Function ClearBkg(layer_num) 'Clear a background from a layer

Sub Bkg_SetAlpha(layer_num, a) 'Sets the alpha of a background

Sub Bkg_SetType(layer_num, t) 'Sets the type of content displayed in the layer (STAGE_LAYER_TYPE_NONE, STAGE_LAYER_TYPE_BKG, STAGE_LAYER_TYPE_TILE)

Sub Bkg_SetFlag(layer_num, flag) 'Sets a flag for the background (STAGE_LAYER_BKG_FLAG_TILED, STAGE_LAYER_BKG_FLAG_STRETCHED, STAGE_LAYER_BKG_FLAG_BLIT, STAGE_LAYER_BKG_FLAG_NONE)

Sub Bkg_SetClearColor(layer_num, r, g, b) 'Sets the clear color for the background

Sub Bkg_SetZoom(layer_num, zx, zy) 'Sets the zoom values used to draw the background

Sub Bkg_SetAngle(layer_num, angle) 'Sets the angle to rotate the background when drawing it

Sub Bkg_SetBlit(layer_num, x, y, w, h) 'Sets the portion of the background to draw

Function LoadStage(Stage_file$) 'Load a stage from a file

Sub Stage_Layer_SetTile(layer, tset, tile_index, x, y) 'places a tile in the current stage

Sub Stage_Layer_RemoveTile(layer, x, y) 'Remove a tile from the stage

Sub Stage_Layer_DrawBkg(layer) 'Draws the background in the layer (used by Game_Render)

Function Stage_Layer_AddShape(layer, shape_type, x, y, p1, p2) 'Add a shape to a layer

Function Stage_Layer_RemoveShape(layer, shape_num) 'Remove a shape from a layer

Sub Stage_DrawActor(actor) 'Draws an actor (used by Game_Render)

Function Game_Render() 'Renders the game screen

Function Game_WindowOpen(t$, w, h, flag) 'Opens a new game screen

Function Stage_SetViewport(x, y, w, h) 'Sets the viewport of the stage

Sub Stage_SetOffset(x, y) 'Sets the offset of the stage

Sub Stage_MoveOffset(x, y) 'Sets the offset of the stage relative to the current offset
