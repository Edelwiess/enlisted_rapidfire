#ifwinactive, Enlisted
;---------------------------------------
; Variables
;---------------------------------------

	wantsRbeforeL := 1 ; If wants to be aiming before autofire or compensation.
	comp := 12 ; Value for auto fire compensation.
    V_AutoFire := 0 ; Value for Autofire being on and off.
	V_Compensation := 0 ;Value for Compensation being on and off.
	V_Compensation_mode := 1 ;Value for Compensation mode. Fedrov, FG42 2:12 M2 Carbin 3:16 AVT 4:30 MP43 4:6
	currunt_gun := "FG42/Fedrov"
	V_reduce_comp_time := 2000 ; Value for how much time do the Compensation begin to reduce
	
;---------------------------------------
;Compensation
;---------------------------------------

	mouseXY(x,y) ;Moves the mouse down to compensate recoil (value in compVal var).
	{
  		DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
	}

	

;---------------------------------------
; Autofire Setup
;---------------------------------------

	~$*\::					; Swaps the state of Autofire with the press of "\".
		if V_AutoFire = 0
		{
			V_AutoFire = 1 
			tooltip, Autofire on, 930, 650 
			SetTimer, RemoveToolTip, 2000
		}
		else
		{
			V_AutoFire = 0 
			tooltip, Autofire off, 930, 650 
			SetTimer, RemoveToolTip, %V_reduce_comp_time%
		}
	Return

;---------------------------------------
; Compensation value Setup
;---------------------------------------

	~$*=::					; Swaps the Compensation value the press of "+".
		if V_Compensation_mode = 1 
		{
			V_Compensation_mode = 2
			comp = 16
			current_gun = "M2 Carbin"
			SetTimer, RemoveToolTip, 2000
		}
		else if V_Compensation_mode = 2 
		{
			V_Compensation_mode = 3
			comp = 30
			current_gun = "AVT40"
			SetTimer, RemoveToolTip, 2000
		}
		else if V_Compensation_mode = 3 
		{
			V_Compensation_mode = 4
			comp = 8
			current_gun = "MP43"
			SetTimer, RemoveToolTip, 2000
		}
		else if V_Compensation_mode = 4 
		{
			V_Compensation_mode = 5
			comp = 10
			current_gun = "FG42-2/Sniper MKB42(H)"
			SetTimer, RemoveToolTip, 2000
		}
		else
		{
			V_Compensation_mode = 1
			comp = 12
			current_gun = "FG42/Fedrov"
			SetTimer, RemoveToolTip, 2000
		}
		tooltip, Compensation %comp% mode %current_gun%, 930, 650 
	Return





;---------------------------------------
; Compensation ON/OFF Setup
;---------------------------------------

	~$*]::					; Swaps the state of Compensation with the press of "]".
		if V_Compensation = 0
		{
			V_Compensation = 1
			tooltip, Compensation on, 930, 650 
			SetTimer, RemoveToolTip, 2000
		}
		else
		{
			V_Compensation = 0 
			tooltip, Compensation off, 930, 650 
			SetTimer, RemoveToolTip, 2000
		}
	Return
	
	


;---------------------------------------
; Auto Firing
;---------------------------------------

	~$*LButton::			; Fires Automaticly when Autofire is on.
		if V_AutoFire = 1
	{
		Loop
	{
		GetKeyState, LButton, LButton, P
		if LButton = U
			Break
		MouseClick, Left,,, 1
		Gosub, RandomSleep
		
		if (GetKeyState("RButton")  &&  V_Compensation = 1)
			mouseXY(0, comp)
	
	}
	}
	Return 

;---------------------------------------
; Tooltips and Timers
;---------------------------------------
	
	RandomSleep:			; Random timing between Autofire shots
		Random, random, 5, 6
		Sleep %random%-5
	Return
	
	RemoveToolTip:			; Used to remove tooltips.
	   SetTimer, RemoveToolTip, Off
	   tooltip
	Return
   
	~$*RButton::			; Displays Autofire on tooltip when zooming in.
		if V_AutoFire = 1
		{	
			tooltip, Autofire on, 930, 650 
			SetTimer, RemoveToolTip, 800
		}
		else
			tooltip