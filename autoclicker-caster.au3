#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         manndadog


#ce ----------------------------------------------------------------------------

#include <GUIConstants.au3>
#include <Misc.au3>


Global $pos[2]
Global $acl_ss_key = "{F4}" ; Change this line for autoclick-Keybinding
Global $acs_ss_key = "{F3}" ; Change this line for autocast-Keybinding
Global $b_acl = False
Global $b_acs = False
Global $cast_timer = 0
Global $click_timer = 0

; Initial HotKeySet
HotKeySet($acl_ss_key, "_startClicks")
HotKeySet($acs_ss_key, "_startCasts")


$Form1 = GUICreate("Autoclicker - Autocaster", 300, 300, 100, 300)

; AutoClicker
$title1_Label	= GUICtrlCreateGroup("Autoclicker", 10,15,275,100)
; Labels
$cps_Label		= GUICtrlCreateLabel("Clicks/Sec", 25, 40, 60, 20)
; Inputs
$cps_Input	= GUICtrlCreateInput("30", 100, 37, 40, 20)
; Buttons
$start_acl = GUICtrlCreateButton("Start/Stop " & $acl_ss_key, 25, 70, 100, 30)
GUICtrlSetBkColor($start_acl, 0xFF0000)
; $define_acl = GUICtrlCreateButton("Define", 140, 70, 80, 30)


; AutoCaster
$title2_Label	= GUICtrlCreateGroup("Autocaster", 10, 120, 275, 175)
; Labels
$spells_Label	= GUICtrlCreateLabel("Spells2Cast", 25, 140, 60, 20)
$mps_Label		= GUICtrlCreateLabel("Mana/Sec", 25, 190, 60, 20)
$maxMana_Label	= GUICtrlCreateLabel("Max Mana", 25, 220, 60, 20)
; Inputs
$mps_Input	= GUICtrlCreateInput("4.0", 100, 187, 80, 20)
$mm_Input	= GUICtrlCreateInput("1000", 100, 217, 80, 20)
; Checkboxes
$spell1_CB	= GUICtrlCreateCheckbox("1", 25, 160, 30, 20)
$spell2_CB	= GUICtrlCreateCheckbox("2", 65, 160, 30, 20)
$spell3_CB	= GUICtrlCreateCheckbox("3", 105, 160, 30, 20)
$spell4_CB	= GUICtrlCreateCheckbox("4", 145, 160, 30, 20)
$spell5_CB	= GUICtrlCreateCheckbox("5", 185, 160, 30, 20)
; Buttons
$start_acs = GUICtrlCreateButton("Start/Stop " & $acs_ss_key, 25, 250, 100, 30)
GUICtrlSetBkColor($start_acs, 0xFF0000)
; $define_acs = GUICtrlCreateButton("Define", 140, 250, 80, 30)

GUISetState(@SW_SHOW)

; ================
; FUNCTIONS
; ================

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

func _startCasts()
	$b_acs = Not $b_acs
	If $b_acs Then
		GUICtrlSetBkColor($start_acs, 0x00FF00)
		$cast_timer = TimerInit()
		If _IsChecked($spell1_CB) Then
			Send("1")
		EndIf
		If _IsChecked($spell2_CB) Then
			Send("2")
		EndIf
		If _IsChecked($spell3_CB) Then
			Send("3")
		EndIf
		If _IsChecked($spell4_CB) Then
			Send("4")
		EndIf
		If _IsChecked($spell5_CB) Then
			Send("5")
		EndIf
	Else
		GUICtrlSetBkColor($start_acs, 0xFF0000)
		$cast_timer = 0
	EndIf
EndFunc


func _startClicks()
	$b_acl = Not $b_acl
	If $b_acl Then
		GUICtrlSetBkColor($start_acl, 0x00FF00)
		$click_timer = TimerInit()
	Else
		GUICtrlSetBkColor($start_acl, 0xFF0000)
		$click_timer = 0
	EndIf
EndFunc



While 1
	
	If $b_acl And TimerDiff($click_timer) > Round(1000/GUICtrlRead($cps_Input)) Then
		MouseClick("left")
		$click_timer = 0
		$click_timer = TimerInit()
	EndIf

	If $b_acs And TimerDiff($cast_timer) > (((Round(GUICtrlRead($mm_Input)/GUICtrlRead($mps_Input)))*1000)+500) Then
		If _IsChecked($spell1_CB) Then
			Send("1")
		EndIf
		If _IsChecked($spell2_CB) Then
			Send("2")
		EndIf
		If _IsChecked($spell3_CB) Then
			Send("3")
		EndIf
		If _IsChecked($spell4_CB) Then
			Send("4")
		EndIf
		If _IsChecked($spell5_CB) Then
			Send("5")
		EndIf
		$cast_timer = 0
		$cast_timer = TimerInit()
	EndIf
	
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit	
    EndSwitch
WEnd