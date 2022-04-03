'FLOATING PLATFORMS
Dim platform[8]
Dim platform_active[8]
Dim platform_path[8, 12, 2] 'x, y
Dim platform_path_num_waypoints[8]
Dim platform_current_waypoint[8]
Dim platform_speed_x[8]
Dim platform_speed_y[8]
Dim num_platforms
Dim platform_sprite
Dim platform_create_timer

Sub Init_Platforms()
	num_platforms = 0
	platform_sprite = LoadSprite("platform_float")
	'Print "ps = ";platform_sprite
End Sub

Sub Add_Platform(num_waypoints, ByRef x, ByRef y, speed_x, speed_y)
	
	n = num_platforms
	num_platforms = num_platforms + 1
	
	platform[n] = NewActor("platform_float_"+str(n), platform_sprite)
	Actor_SetLayer(platform[n], 2)
	platform_speed_x[n] = speed_x
	platform_speed_y[n] = speed_y
	platform_path_num_waypoints[n] = num_waypoints
	platform_active[n] = False
	
	For i = 0 to num_waypoints-1
		platform_path[n, i, 0] = x[i]
		platform_path[n, i, 1] = y[i]
	Next
	
	Actor_SetPosition(platform[n], x[0], y[0])
	platform_current_waypoint[n] = 1
	
	Stage_Layer_AddActorDynaRec_AllSectors(platform[n], 2)
	
End Sub

Sub Platforms_Act()
	sx = 0
	sy = 0
	If num_platforms > 0 Then
		For n = 0 to num_platforms-1
			If (Timer - platform_create_timer) > 2500 And platform_active[n] = False Then
				platform_active[n] = True
				platform_create_timer = Timer
				'Actor_SetActive(platform[n], True)
				Actor_SetPosition(platform[n], platform_path[n, 0, 0], platform_path[n, 0, 1])
				platform_current_waypoint[n] = 1
			End If
			
			If platform_active[n] Then
				wp_x = platform_path[n, platform_current_waypoint[n], 0]
				wp_y = platform_path[n, platform_current_waypoint[n], 1]
				sx = platform_speed_x[n]
				sy = platform_speed_y[n]
				'Print "p = ";Actor_X[platform[n]];", ";Actor_Y[platform[n]]
				If Actor_X[platform[n]] > wp_x Then
					If (Actor_X[platform[n]] - sx) < wp_x Then
						sx = wp_x - Actor_X[platform[n]]
					Else
						sx = -1 * platform_speed_x[n]
					End If
				ElseIf Actor_X[platform[n]] < wp_x Then
					If (Actor_X[platform[n]] + sx) > wp_x Then
						sx = wp_x - Actor_X[platform[n]]
					Else
						sx = platform_speed_x[n]
					End If
				Else
					sx = 0
				End If
				
				If Actor_Y[platform[n]] > wp_y Then
					If (Actor_Y[platform[n]] - sy) < wp_y Then
						sy = wp_y - Actor_Y[platform[n]]
					Else
						sy = -1 * platform_speed_y[n]
					End If
				ElseIf Actor_Y[platform[n]] < wp_y Then
					If (Actor_Y[platform[n]] + sy) > wp_y Then
						sy = wp_y - Actor_Y[platform[n]]
					Else
						sy = platform_speed_y[n]
					End If
				Else
					sy = 0
					'Print "Y is 0"
				End If
				
				If sx = 0 And sy = 0 Then
					platform_current_waypoint[n] = platform_current_waypoint[n] + 1
					If platform_current_waypoint[n] >= platform_path_num_waypoints[n] Then
						platform_active[n] = False
						'Actor_SetActive(platform[n], False)
					End If
				End If
				
				Actor_Move(platform[n], sx, sy)
			End If
		Next
	End If
End Sub
