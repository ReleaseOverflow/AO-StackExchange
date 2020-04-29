#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; https://autohotkey.com/board/topic/3470-checkbox-example/










GLOBAL MultiSelectErrorStringGfx := "You checked too many graphics options.  The system will only accept one graphical preset input at a time, please try again."



        if FileExist("gui\settings_bg.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, gui\settings_bg.png, %A_ScriptDir%\gui\settings_bg.png, 0
    Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

        if FileExist("gui\settings_x.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, gui\settings_x.png, %A_ScriptDir%\gui\settings_x.png, 0
    Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }
    Progress, Off





Gui, -Caption +ToolWindow
Notepad = Somepath on your drive goes here (C:\WINDOWS) 
Gui, Add, Checkbox, x16 y337 w107 h30 vOpt00, ADMINISTRATOR
Opt00_TT := "Plugin 00 Information."
Gui, Add, Checkbox, x16 y42 w100 h30 vOpt01,  EARLY LOCK
Opt01_TT := "Plugin 01 Information."
Gui, Add, Checkbox, x16 y82 w100 h30 vOpt02,  ALT+TAB
Opt02_TT := "Plugin 02 Information."
Gui, Add, Checkbox, x16 y122 w100 h30 vOpt03, MOUSE LOCK
Opt03_TT := "Plugin 03 Information."
Gui, Add, Checkbox, x16 y162 w105 h30 vOpt04, STEADY WINDOW FOCUS
Opt04_TT := "Plugin 04 Information."
Gui, Add, Checkbox, x16 y202 w105 h30 vOpt05, STEADY WINDOW FOCUS
Opt05_TT := "Plugin 05 Information."
Gui, Add, Checkbox, x16 y242 w100 h30 vOpt06, HANG DETECT
Opt06_TT := "Plugin 06 Information."
Gui, Add, Checkbox, x392 y52 w120 h30 vOpt07, Master Sound Switch
Opt07_TT := "Plugin 07 Information."
Gui, Add, Checkbox, x16 y367 w107 h30 vOpt08, HUD-LEFT
Opt07_TT := "Plugin 08 Information."
; Gui, Add, Checkbox, x392 y82 w15 h30 vOpt08,
; Gui, Add, Checkbox, x16 y253 w100 h30 vOpt3 gResetOther3, LOW
; Opt3_TT := "The LOW Preset is the lowest graphical option preset available."
; Gui, Add, Checkbox, x16 y293 w100 h30 vOpt2 gResetOther2, MEDIUM
; Opt2_TT := "The MEDIUM Preset is the moderate graphical option preset."
; Gui, Add, Checkbox, x16 y333 w100 h30 vOpt1 gResetOther1, ULTRA
; Opt1_TT := "The ULTRA Preset is the highest graphical option preset available."

Gui, Add, Text, x136 y337 w130 h30, Run With Administrator (On/Off)
Gui, Add, Text, x136 y42 w190 h30, Toggle Early Mouse Lock (On/Off)
Gui, Add, Text, x136 y82 w190 h30, Toggle Auto Alt-Tab (On/Off)
Gui, Add, Text, x136 y122 w190 h30, Toggle Auto Mouse Lock (On/Off)
Gui, Add, Text, x136 y162 w190 h30, Persistent Window Focus (Coffee)
Gui, Add, Text, x136 y202 w190 h30, Persistent Window Focus (Extruder)
Gui, Add, Text, x136 y242‬ w190 h30, Auto Mouse Lock Hang Detection
Gui, Add, Text, x136 y367 w130 h30, Display Loop State on the screen while active 
; Gui, Add, Text, gToggleSoundMaster x415 y62‬ w190 h30 vMasterSoundLink, Master Sound Switch
; Gui, Add, Text, x415 y92‬ w190 h30, Master Sound Switch


; Gui, Add, Text, x58 y230 w200 h50 vGraphicalPresets,   GRAPHICAL OPTIONS
; Gui, Add, Text, x136 y293 w100 h30, LOW Graphical Options Preset
; Gui, Add, Text, x136 y257 w100 h30, MEDIUM Graphical Options Preset
; Gui, Add, Text, x136 y333 w100 h30, ULTRA Graphical Options Preset

Gui, Add, Button, gResetDefaults x502 y280 w80 h50 vDefaultsBtn, RESTORE DEFAULTS
Gui, Add, Button, gLabel x491 y340 w100 h60 vSumbitBtn, SAVE AND EXIT
SumbitBtn_TT := "Submit Changes to stack_core.ini."
Gui, Add, Picture,  x0 y0 vBgVar, %A_ScriptDir%\gui\settings_bg.png
Gui, Add, Picture,  x563 y0 gGuiClose vXBtnVar, %A_ScriptDir%\gui\settings_x.png
; Gui, Add, Picture, gMyOtherLabel x275 y15 w50 h50, cut.ico ;Click on your image to run notepad.
Gui, Show, h409 w600, %ProjectName% %engine_version% %engine_terms% %ENGINEAPIs%  3.4 

; Sleep, 50
IniRead, ENGINEtate_00, %A_ScriptDir%\stack_core.ini, ENGINE, RunWithAdmin, KEY ERROR @ ENGINETATE_00
IniRead, ENGINEtate_01, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Early_InputLock, KEY ERROR @ ENGINETATE_01
IniRead, ENGINEtate_02, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Auto_AltTab, KEY ERROR @ ENGINETATE_02
IniRead, ENGINEtate_03, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_LockInput, KEY ERROR @ ENGINETATE_03
IniRead, ENGINEtate_04, %A_ScriptDir%\stack_core.ini, ENGINE, Coffee_Persistent_Window_Activation, KEY ERROR @ ENGINETATE_04
IniRead, ENGINEtate_05, %A_ScriptDir%\stack_core.ini, ENGINE, Extruder_Persistent_Window_Activation, KEY ERROR @ ENGINETATE_05
IniRead, ENGINEtate_06, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_Handle_InputHang, KEY ERROR @ ENGINETATE_06
IniRead, SOUNDState_07, %A_ScriptDir%\stack_core.ini, SOUND, Sound_Master_Switch, KEY ERROR @ ENGINETATE_07
IniRead, SOUNDState_08, %A_ScriptDir%\stack_core.ini, CLIENT, Left_HeadsUp_Display, KEY ERROR @ ENGINETATE_08
;-----
; IniRead, GfxPreset_LOW, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW, KEY ERROR @ GRAPHICS PRESET LOW
; IniRead, GfxPreset_MEDIUM, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM, KEY ERROR @ GRAPHICS PRESET MEDIUM
; IniRead, GfxPreset_ULTRA, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA, KEY ERROR @ GRAPHICS PRESET ULTRA
; Sleep, 50

; MsgBox, %ENGINEtate_01%
; If GfxPreset_LOW = 1
; {
;     GuiControl,, Opt3, 1
; }
; If GfxPreset_MEDIUM = 1
; {
;     GuiControl,, Opt2, 1
; }
; If GfxPreset_ULTRA = 1
; {
;     GuiControl,, Opt1, 1
; }
; If (GfxPreset_LOW = 0) and (GfxPreset_MEDIUM = 0) and (GfxPreset_ULTRA = 0)
; {
;     MsgBox, you have not selected a graphics presets, defaulting to MEDIUM GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
;     GuiControl,, Opt2, 1
; }

If ENGINEtate_00 = 1
{
    GuiControl,, Opt00, 1
}
If ENGINEtate_01 = 1
{
    GuiControl,, Opt01, 1
}
If ENGINEtate_02 = 1
{
    GuiControl,, Opt02, 1
}
If ENGINEtate_03 = 1
{
    GuiControl,, Opt03, 1
}
If ENGINEtate_04 = 1
{
    GuiControl,, Opt04, 1
}
If ENGINEtate_05 = 1
{
    GuiControl,, Opt05, 1
}
If ENGINEtate_06 = 1
{
    GuiControl,, Opt06, 1
}
If SOUNDState_07 = 1
{
    GuiControl,, Opt07, 1
}
If SOUNDState_08 = 1
{
    GuiControl,, Opt08, 1
}
OnMessage(0x200, "WM_MOUSEMOVE")  ;;; https://www.autohotkey.com/docs/commands/Gui.htm#ExToolTip
Return 

Label: 
Gui, Submit, NoHide ;this command submits the guis' datas' state 
If (Opt00 = 1)
{
    ; MsgBox, you selected plugin 0
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, RunWithAdmin
}
If (Opt00 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, RunWithAdmin
}
;;;;;;;
If (Opt01 = 1)
{
    ; MsgBox, you selected plugin 1
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Early_InputLock
}
If (Opt01 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Early_InputLock
}
;;;;;;;
If (Opt02 = 1)
{
    ; MsgBox, you selected plugin 2
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Auto_AltTab
}
If (Opt02 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Auto_AltTab
}
;;;;;;;
If (Opt03 = 1)
{
    ; MsgBox, you selected plugin 3
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_LockInput
}
If (Opt03 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_LockInput
}
;;;;;;;
If (Opt04 = 1)
{
    ; MsgBox, you selected plugin 4
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Coffee_Persistent_Window_Activation
}
If (Opt04 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Coffee_Persistent_Window_Activation
}





If (Opt05 = 1)
{
    ; MsgBox, you selected plugin 5
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Extruder_Persistent_Window_Activation
}
If (Opt05 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Extruder_Persistent_Window_Activation
}






If (Opt06 = 1)
{
    ; MsgBox, you selected plugin 6
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_Handle_InputHang
}
If (Opt06 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_Handle_InputHang
}


If (Opt07 = 1)
{
    ; MsgBox, you selected plugin 7
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Sound_Master_Switch
}
If (Opt07 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, SOUND, Sound_Master_Switch
}


If (Opt08 = 1)
{
    ; MsgBox, you selected plugin 8
    ; Resets_forOpt2()
    ; Return
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, CLIENT, Left_HeadsUp_Display
}
If (Opt08 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, CLIENT, Left_HeadsUp_Display
}

SOUNDcloseSettings()
ExitApp
Return

MyOtherLabel:
run, notepad.exe 
Return ;Should you comment this line by placing a semicolon (;) in front of it this script will 
;exit because it will encounter the exitapp command below. Get it?

; GuiClose: 
; ExitApp


; Resets_forConflictingOpts()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }

; Resets_forDefaultingOpts()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 1
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }


; ResetOther1:
; Resets_ForOpt1()
; Return

; ResetOther2:
; Resets_ForOpt2()
; Return

; ResetOther3:
; Resets_ForOpt3()
; Return




; Resets_forOpt1()
; {
;     ; GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }

; Resets_forOpt2()
; {
;     GuiControl,, Opt1, 0
;     ; GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }

; Resets_forOpt3()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     ; GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }






;; old logic

; Resets_forOpt1()
; {
;     ; GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt2()
; {
;     GuiControl,, Opt1, 0
;     ; GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt3()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     ; GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt05()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt04()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt03()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt02()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt01()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
; }



; ToggleSoundMaster:
; Gui, Submit, NoHide
; If(SOUNDState_07 = 1)
; {
;     GuiControl,, Opt07, 0
;     Return
; }
; Else If(SOUNDState_07 = 0)
; {
;     GuiControl,, Opt07, 1
;     Return
; }
; Return






ResetDefaults:
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, RunWithAdmin
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Early_InputLock 
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_Handle_InputHang
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Coffee_Persistent_Window_Activation
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Extruder_Persistent_Window_Activation
    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Early_InputLock
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Auto_LockInput
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, ENGINE, Do_Auto_AltTab

    IniWrite, %A_Space%0, %A_ScriptDir%\stack_core.ini, CLIENT, Left_HeadsUp_Display

    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Sound_Master_Switch
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Help_Start
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, About_Start
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Save_Current_Crat
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Save_Current_Trader
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Coffee_Module_Start
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Coffee_Module_Stop
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Extruder_Module_Start
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Extruder_Module_Stop
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Settings_Config_Start
    IniWrite, %A_Space%1, %A_ScriptDir%\stack_core.ini, SOUND, Bug_Reporter_Start

SOUNDcloseSettings()
ExitApp
Return


WM_MOUSEMOVE()
{
    static CurrControl, PrevControl, _TT  ; _TT is kept blank for use by the ToolTip command below.
    CurrControl := A_GuiControl
    if (CurrControl != PrevControl and not InStr(CurrControl, " "))
    {
        ToolTip  ; Turn off any previous tooltip.
        SetTimer, DisplayToolTip, 1000
        PrevControl := CurrControl
    }
    return

    DisplayToolTip:
    SetTimer, DisplayToolTip, Off
    ToolTip % %CurrControl%_TT  ; The leading percent sign tell it to use an expression.
    SetTimer, RemoveToolTip, 3000
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}


GuiClose:
SOUNDcloseSettings()
ExitApp




SOUNDcloseSettings()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDLaunchSettings, stack_core.ini, SOUND, Settings_Config_Start, Default
    if(SNDLaunchSettings = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\combine_x.wav, WAIT
    Return
    }
    if(SNDLaunchSettings = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDLaunchSettings = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}
