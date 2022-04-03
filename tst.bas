print env("SYSTEMROOT")

end
PI = 3.14159265359

Function rotateX(center_x, half_width, rot)
	rot = rot * PI/180
	H = Cos(rot) * half_width
	x = center_x + H
	Return x
End Function

Function rotateY(center_y, half_height, rot)
	rot = rot * PI/180
	V = Sin(rot) * half_height
	y = center_y + V
	Return y
End Function

Function distance(x1, y1, x2, y2)
	Return Sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
End Function


Sub rotatePoint(pt_x, pt_y, center_x, center_y, angleDeg, ByRef x, Byref y)

    angleRad = (angleDeg/180)*PI
    cosAngle = Cos(angleRad)
    sinAngle = Sin(angleRad)
    dx = (pt_x-center_x)
    dy = (pt_y-center_y)

    x = center_x + int(dx*cosAngle-dy*sinAngle)
    y = center_y + int(dx*sinAngle+dy*cosAngle)
End Sub


WindowOpen(0, "tst", windowpos_Centered, windowpos_centered, 640, 480, 0, 0)
CanvasOpen(0, 640, 480, 0, 0, 640, 480, 0)
SetColor(rgb(255,0,0))
obj_x = 250
obj_y = 250
obj_width = 50
obj_height = 150
Rect(obj_x, obj_y, obj_width, obj_height)
SetColor(rgb(0,255,0))

Dim x1
Dim y1
Dim x2
Dim y2
Dim x3
Dim y3
Dim x4
Dim y4

h_width = obj_width/2
h_height = obj_height/2

For i = 0 to  45
	ClearCanvas
	
	SetColor(rgb(255,0,0))
	Rect(obj_x, obj_y, obj_width, obj_height)
	
	SetColor(rgb(0,255,0))
	rotatePoint(obj_x, obj_y, obj_x + h_width, obj_y + h_height, i, x1, y1)
	
	rotatePoint(obj_x + obj_width, obj_y, obj_x + h_width, obj_y + h_height, i, x2, y2)
	
	rotatePoint(obj_x + obj_width, obj_y + obj_height, obj_x + h_width, obj_y + h_height, i, x3, y3)
	
	rotatePoint(obj_x, obj_y + obj_height, obj_x + h_width, obj_y + h_height, i, x4, y4)
	
	'w = distance(obj_x, obj_y, obj_x + obj_width/2, obj_y + obj_height/2)
	'x1 = rotateX( obj_x + (obj_width/2), obj_width/2, i )
	'y1 = rotateY( obj_y + (obj_height/2), obj_height/2, i)
	'x2 = rotateX( obj_x + (obj_width/2), obj_width/2, i + 90 )
	'y2 = rotateY( obj_y + (obj_height/2), obj_height/2, i + 90)
	'x3 = rotateX( obj_x + (obj_width/2), obj_width/2, i + 180 )
	'y3 = rotateY( obj_y + (obj_height/2), obj_height/2, i + 180)
	'x4 = rotateX( obj_x + (obj_width/2), obj_width/2, i + 270 )
	'y4 = rotateY( obj_y + (obj_height/2), obj_height/2, i + 270)
	'pset(x1, y2)
	'print x2;" ";x3
	'print y2;" ";y3
	line(x1, y1, x2, y2)
	line(x2, y2, x3, y3)
	line(x3, y3, x4, y4)
	line(x4, y4, x1, y1)
	update
	wait(10)
Next
update()
waitkey()
