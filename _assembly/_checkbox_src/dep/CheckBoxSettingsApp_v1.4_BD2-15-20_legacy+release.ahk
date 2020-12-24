#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; https://autohotkey.com/board/topic/3470-checkbox-example/


; Generated using SmartGUI Creator 3.4 
Notepad = Somepath on your drive goes here (C:\WINDOWS) 
Gui, Add, Checkbox, x16 y17 w100 h30 vOpt8, Opt8
Gui, Add, Checkbox, x16 y57 w100 h30 vOpt7, Opt7
Gui, Add, Checkbox, x16 y97 w100 h30 vOpt6, Opt6
Gui, Add, Checkbox, x16 y137 w100 h30 vOpt5, Opt5
Gui, Add, Checkbox, x16 y177 w100 h30 vOpt4, Opt4
Gui, Add, Checkbox, x16 y217 w100 h30 vOpt3, Opt3
Gui, Add, Checkbox, x16 y257 w100 h30 vOpt2, Opt2
Gui, Add, Checkbox, x16 y297 w100 h30 vOpt1, Opt1

Gui, Add, Text, x206 y337 w190 h30, If either 'Opt1' and 'Opt2' boxes are checked and submitted - returns each action action
Gui, Add, Text, x136 y17 w100 h30, Text 
Gui, Add, Text, x136 y57 w100 h30, Text 
Gui, Add, Text, x136 y97 w100 h30, Text 
Gui, Add, Text, x136 y137 w100 h30, Text 
Gui, Add, Text, x136 y177 w100 h30, Text 
Gui, Add, Text, x136 y217 w100 h30, Text 
Gui, Add, Text, x136 y257 w100 h30, Text 
Gui, Add, Text, x136 y297 w100 h30, Text 
Gui, Add, Button, gLabel x260 y90 w100 h60, Click this button to submit and exe the "Label" label 
Gui, Add, Picture, gMyOtherLabel x275 y15 w50 h50, cut.ico ;Click on your image to run notepad.
Gui, Show, x159 y116 h379 w400, Generated using SmartGUI Creator 3.4 
Return 

Label: 
Gui, Submit, NoHide ;this command submits the guis' datas' state 
If Opt1 = 1
{
    MsgBox, you checked the box that has the assigned var of Opt1.  
    ; Resets_forOpt1()
}
If Opt2 = 1
{
    MsgBox, you checked the box that has the assigned var of Opt2.  
}
Return

MyOtherLabel:
run, notepad.exe 
Return ;Should you comment this line by placing a semicolon (;) in front of it this script will 
;exit because it will encounter the exitapp command below. Get it?

GuiClose: 
ExitApp




Resets_forOpt1()
{
    ; GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt2()
{
    GuiControl,, Opt1, 0
    ; GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt3()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    ; GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt4()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt5()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt6()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt7()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    GuiControl,, Opt8, 0
}

Resets_forOpt8()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    GuiControl,, Opt4, 0
    GuiControl,, Opt5, 0
    GuiControl,, Opt6, 0
    GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}