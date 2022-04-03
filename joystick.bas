dim button[30]
dim axis[30]
dim hat[30]

dim joy_hat_activity
dim joy_button_activity
dim joy_axis_activity

sub GetJoystick(joy_num)
	joy_hat_activity = false
	joy_button_activity = false
	joy_axis_activity = false
	
	if NumJoyHats(joy_num) > 0 then
		for i = 0 to NumJoyHats(joy_num)-1
			hat[i] = JoyHat(joy_num, i)
			if hat[i] <> HAT_CENTERED then
				joy_hat_activity = TRUE
			end if
		next
	End If
	
	If NumJoyButtons(joy_num) > 0 then
		for i = 0 to NumJoyButtons(joy_num) - 1
			button[i] = joybutton(joy_num, i)
			if button[i] then
				joy_button_activity = true
			end if
		next
	End If
	
	If NumJoyAxes(joy_num) > 0 then
		for i = 0 to NumJoyAxes(joy_num) - 1
			axis[i] = JoyAxis(joy_num, i)
			if axis[i] <> 0 then
				joy_axis_activity = true
			end if
		next
	End If
end sub

sub ClearJoysticks()
	For i = 0 to 29
		hat[i] = 0
		button[i] = 0
		axis[i] = 0
	Next
	joy_hat_activity = 0
	joy_button_activity = 0
	joy_axis_activity = 0
end sub
