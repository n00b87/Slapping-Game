'line1 = p0_x, p0_y  -  p1_x, p1_y
'line2 = p2_x, p2_y  -  p3_x, p3_y
Function GetLineIntersect(p0_x, p0_y, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, ByRef i_x, ByRef i_y)
    'Return 0
	
	s1_x = p1_x - p0_x
	s1_y = p1_y - p0_y
    s2_x = p3_x - p2_x
	s2_y = p3_y - p2_y
	
	n = ( (-1 * s2_x) * s1_y + s1_x * s2_y)
	
	If n = 0 Then
		Return 0
	End If
	
    s = ( (-1 * s1_y) * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / n
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / n

    If s >= 0 And s <= 1 And t >= 0 And t <= 1 Then
        ' Collision detected
        i_x = p0_x + (t * s1_x)
        
        i_y = p0_y + (t * s1_y)
        return 1
    End If
	
	' No collision
    return 0
End Function

Function GetLineCollision(p0_x, p0_y, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, ByRef i_x, ByRef i_y)
	Dim collide_x
	Dim collide_y
	
	HV_FLAG_HORIZONTAL = (p0_y = p2_y)
	HV_FLAG_VERTICAL = (p0_x = p2_x)
	
	If GetLineIntersect(p0_x, p0_y, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, collide_x, collide_y) Then
		i_x = collide_x
		i_y = collide_y
		'print "Line 1 = ";p0_x;", ";p0_y;" to ";p1_x;", ";p1_y
		'print "Line 1 = ";p2_x;", ";p2_y;" to ";p3_x;", ";p3_y
		Return True
	ElseIf HV_FLAG_VERTICAL Then
		line1_p1_check = (p0_y >= p2_y) And (p0_y <= p3_y)
		line1_p2_check = (p1_y >= p2_y) And (p1_y <= p3_y)
		line2_p1_check = (p2_y >= p0_y) And (p2_y <= p1_y)
		line2_p2_check = (p3_y >= p0_y) And (p3_y <= p1_y)
		i_x = -1
		i_y = -1
		If line1_p1_check Then
			i_x = p0_x
			i_y = p0_y
		ElseIf line1_p2_check Then
			i_x = p1_x
			i_y = p1_y
		ElseIf line2_p1_check Then
			i_x = p2_x
			i_y = p2_y
		ElseIf line2_p2_check Then
			i_x = p3_x
			i_y = p3_y
		End If
		Return (line1_p1_check Or line1_p2_check Or line2_p1_check Or line2_p2_check)
	ElseIf HV_FLAG_HORIZONTAL Then
		line1_p1_check = (p0_x >= p2_x) And (p0_x <= p3_x)
		line1_p2_check = (p1_x >= p2_x) And (p1_x <= p3_x)
		line2_p1_check = (p2_x >= p0_x) And (p2_x <= p1_x)
		line2_p2_check = (p3_x >= p0_x) And (p3_x <= p1_x)
		i_x = -1
		i_y = -1
		If line1_p1_check Then
			i_x = p0_x
			i_y = p0_y
		ElseIf line1_p2_check Then
			i_x = p1_x
			i_y = p1_y
		ElseIf line2_p1_check Then
			i_x = p2_x
			i_y = p2_y
		ElseIf line2_p2_check Then
			i_x = p3_x
			i_y = p3_y
		End If
		Return (line1_p1_check Or line1_p2_check Or line2_p1_check Or line2_p2_check)
	End If
	Return False
End Function

