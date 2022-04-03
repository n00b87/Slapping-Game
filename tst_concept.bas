Print Abs(7 - 9)

end


WindowOpen(0, "Sandbox", WINDOWPOS_CENTERED, WINDOWPOS_CENTERED, 640, 480, 0)

CanvasOpen(0, 640, 480, 0, 0, 640, 480, 0)

LoadImage(0, "sprite/m1.png")


While Not Key(K_ESCAPE)
	ClearCanvas
	SetColor(RGB(100,100,255))
	BoxFill(0,0,640,480)
	SetColor(RGBA(255,255,255,255))
	If key(K_Z) then
		RectFill(20, 20, 63, 63)
	end if
	
	if key(K_P) then
		SetImageBlendMode(0, BLENDMODE_ADD)
		'SetImageColorMod(0, RGBA(255,255,255,255))
	else
		SetImageBlendMode(0, BLENDMODE_BLEND)
	end if
	DrawImage_Blit(0, 20, 20, 0, 0, 64, 64)
	'SetColor(RGBA(255,255,255,128))
	'RectFill(20, 20, 64, 64)
	Update
Wend
