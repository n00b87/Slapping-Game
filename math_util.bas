PI = 3.14159265359

Sub rotatePoint(pt_x, pt_y, center_x, center_y, angleDeg, ByRef x, Byref y)

    angleRad = (angleDeg/180)*PI
    cosAngle = Cos(angleRad)
    sinAngle = Sin(angleRad)
    dx = (pt_x-center_x)
    dy = (pt_y-center_y)

    x = center_x + int(dx*cosAngle-dy*sinAngle)
    y = center_y + int(dx*sinAngle+dy*cosAngle)
End Sub

Function getDistance(x1, y1, x2, y2)
	Return Sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
End Function
