Include Once

Dim touch_button[8]
touch_button_size = 64
touch_button_y = 400

Dim cmod[2]

current_cmod = 0
cmod_timer = Timer

MOBILE_BUTTONS_IMAGE = 1


Dim touch_status
Dim touch_x
Dim touch_y
Dim touch_dx
Dim touch_dy

Dim ST_MB_UP : ST_MB_UP = 1
Dim ST_MB_DOWN : ST_MB_DOWN = 2
Dim ST_MB_LEFT : ST_MB_LEFT = 0
Dim ST_MB_RIGHT : ST_MB_RIGHT = 3

Dim ST_MB_W : ST_MB_W = 5
Dim ST_MB_A : ST_MB_A = 4
Dim ST_MB_S : ST_MB_S = 6
Dim ST_MB_D : ST_MB_D = 7

function touch_button_pressed(b)
	If touch_x >= touch_button[b] And touch_x < (touch_button[b] + touch_button_size) And touch_y >= touch_button_y And touch_y < (touch_button_y + touch_button_size) Then
		Return True
	End If
	Return False
end function


function mobile_button(b)
	GetTouch(touch_status, touch_x, touch_y, touch_dx, touch_dy)
	
	If touch_status Then
		return touch_button_pressed(b)
	End If
end function
