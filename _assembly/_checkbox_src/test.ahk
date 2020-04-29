#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
ChoiceVar = 
	gui, OSLauncher: new
	gui,Default
	gui,+LastFound
	gui, add, groupbox, w300 h200,VM Selection...
	gui, add, text, xm12 ym20, 1) Android
	gui, add, text, xm12 yp+20, 2) Sierra
	gui, add, text, xm12 yp+20, 3) Leopard
	gui, add, text, xm12 yp+20, 4) Mint
	gui, add, text, xm12 yp+20, 5) Win 3.1
	gui, add, text, xm150 ym20, 6) XFCE
	gui, add, text, xm150 yp+20, 7) Win 7
	gui, add, text, xm150 yp+20, 8) XP sp3
	gui, add, text, xm150 yp+20, 9) Kali
	gui, add, text, xm150 yp+20, 0) Trails
	gui, add, text, xm12 ym120 section, Selection to load:
	gui, add, button, default xm12 yp+30 gDone, Launch
	gui, add, edit, xm150 ym120 vChoiceVar,
	gui, add, button, yp+30 gGuiclose, Exit
	gui, add, text, xm12 yp+30,(Enter a Number, Click LAUNCH or EXIT to close)
	gui, add, text, xm12 yp+30,(Press Ctrl+Win to return to this program)
	gui, show,, VM Launcher 0.07
	return 
	Done:
	
		gui,submit,hide
		;ListVars ;displays another window with inputed variables
		Send, ^%choiceVar%
		MsgBox, , , Starting `nProgram :%choiceVar%`nPlease hold,1
		goto guiclose
		return
		
	Guiclose:
		
		GroupClose, Gui, A
		ExitApp
		return
		
;}
^#x::
ExitApp
Return