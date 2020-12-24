#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, .\_assembly\includes\_$ImageSearch.toolkit
#Include, .\_assembly\includes\_$ExtruderScan.toolkit
#Include, .\_assembly\includes\_$CoffeeScan.toolkit
#Include, .\_assembly\includes\_$IniLibrary.toolkit



;;; https://www.autohotkey.com/docs/Variables.htm  (for the math variable in the settimer below)



GLOBAL RebuildFileString1 := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      BUILDING CORE FILES  {SCAN}   IS   ('RUNNING')"
GLOBAL RebuildFileString2 := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      BUILDING CORE FILES  {GUI}   IS   ('RUNNING')"
GLOBAL RebuildFileString3 := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      BUILDING CORE FILES  {SOUND}   IS   ('RUNNING')"
GLOBAL RebuildFileString4 := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      BUILDING CORE FILES  {UTILITY}   IS   ('RUNNING')"

GLOBAL COFFEEScanPass := "0"
GLOBAL EXTRUDERScanPass := "0"
GLOBAL EXTRUDERPAS2 := "0"

GLOBAL CoffeeActive := "0"
GLOBAL ExtruderActive := "0"


GLOBAL INPUT_HANG_TIMEOUT := "2800"


GLOBAL ExtruderLoopOnString := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      AUTO-LOOP  {EXTRUDER  MACHINE}   IS   ('RUNNING')"
GLOBAL CoffeeLoopOnString := A_Space . A_Space . A_Space . A_Space . A_Space . "[StackExchange]:      AUTO-LOOP   { COFFEE  MACHINE }   IS   ('RUNNING')"



GLOBAL ExtruderSTATUS := "0"   ;; If 0, turned off.  If 1, turned on.  If 2, paused.
GLOBAL CoffeeSTATUS := "0"     ;; If 0, turned off.  If 1, turned on.  If 2, paused.


GLOBAL BarDelayInterval := "45000"
GLOBAL CoffeeDelayInterval := "35000"
; GLOBAL 


    if FileExist("stack_core.ini")
    {
    ; DebugConfigExist()
    Sleep, 50
    }
    Else {
    MsgBox, 48, %EngineTitle% - %EngineError0x0%, The stack_core.ini file doesn't exist.
    

Ini := new AhkIni(".\stack_core.ini")	;will create new ini if nothing exists
			Msgbox, 64, %EngineTitle% - %EngineInfo0x0%, Configuration File Is Now Being Constructed With Hardcoded Defaults.
Sleep, 500
ini.write("ENGINE", "Auto_Handle_InputHang", "0", "`n`    Auto Unlock Input Controls If system gets hung `n` `n` `n` `n` `n` `n`")
ini.write("ENGINE", "Extruder_Persistent_Window_Activation", "0", "`n`    Perform Persistent Window Activation (Extruder) `n` `n` `n`")
ini.write("ENGINE", "Coffee_Persistent_Window_Activation", "0", "`n`    Perform Persistent Window Activation (Coffee) `n` `n` `n`")
ini.write("ENGINE", "Auto_LockInput", "1", "`n`    Perform Auto Control InputLock during logical loop `n` `n` `n`")
ini.write("ENGINE", "Do_Auto_AltTab", "1", "`n`    Perform Auto Alt-Tab on logical loop iteration end `n` `n` `n`")
ini.write("ENGINE", "Do_Early_InputLock", "0", "`n`    Perform early inputlock on each logical loop `n` `n` `n`")
ini.write("ENGINE", "RunWithAdmin", "0", "`n`    Toggle Running With Administrator `n` `n`", "                   ENGINE OPTIONS (Mostly Ignore These) `n`")
ini.write("CLIENT", "Left_HeadsUp_Display", "0", "`n`    Display CurrentLoopState on the screen while active `n` `n` `n` `n` `n` `n`")
ini.write("CLIENT", "CurrentTrader", "YourTraderHere", "`n`    Current character that does extruders `n`    (CASE SENSITIVE) `n` `n` `n`")
ini.write("CLIENT", "Extruder_LOOP_Speed", "45000", "`n`    The speed your extruder module will operate at (In Milliseconds) `n` `n` `n`")
ini.write("CLIENT", "CurrentCrat", "YourCratHere", "`n`    Current character that does coffees `n`    (CASE SENSITIVE) `n` `n` `n` `n` `n`", "                   CLIENT OPTIONS (Configure these) `n` `n`")
ini.write("CLIENT", "Coffee_LOOP_Speed", "35000", "`n`    The speed your coffee module will operate at (In Milliseconds) `n` `n` `n`")
ini.write("SOUND", "Bug_Reporter_Start", "1", "`n`    Play A Sound on Bug Reporter Button Click `n` `n` `n` `n` `n` `n`")
ini.write("SOUND", "Settings_Config_Start", "1", "`n`    Play A Sound on Settings Button Click `n` `n` `n`")
ini.write("SOUND", "Extruder_Module_Stop", "1", "`n`    Play A Sound on Extruder Loop Stop `n` `n` `n`")
ini.write("SOUND", "Extruder_Module_Start", "1", "`n`    Play A Sound on Extruder Loop Start `n` `n` `n`")
ini.write("SOUND", "Coffee_Module_Stop", "1", "`n`    Play A Sound on Coffee Loop Stop `n` `n` `n`")
ini.write("SOUND", "Coffee_Module_Start", "1", "`n`    Play A Sound on Coffee Loop Start `n` `n` `n`")
ini.write("SOUND", "Save_Current_Trader", "1", "`n`    Play A Sound on Save Trader Button `n` `n` `n`")
ini.write("SOUND", "Save_Current_Crat", "1", "`n`    Play A Sound on Save Crat Button `n` `n` `n`")
ini.write("SOUND", "About_Start", "1", "`n`    Play A Sound on About Button Click `n` `n` `n`")
ini.write("SOUND", "Help_Start", "1", "`n`    Play A Sound on Help Button Click `n` `n` `n`")
ini.write("SOUND", "Sound_Master_Switch", "1", "`n`    Toggle All Sounds On/Off `n` `n`", "                   SOUND OPTIONS (Configure These) `n`")
ini.write("HOTKEY", "CoffeeStopKey", "DEL", "`n`    Default toggle Coffee routine 'OFF' Hotkey `n` Engine Default: DEL `n` `n`")
ini.write("HOTKEY", "CoffeeStartKey", "INS", "`n`    Default toggle Coffee routine 'ON' Hotkey `n` Engine Default: INS `n` `n`")
ini.write("HOTKEY", "ExtruderStopKey", "END", "`n`    Default toggle Extruder routine 'OFF' Hotkey `n` Engine Default: END `n` `n`")
ini.write("HOTKEY", "ExtruderStartKey", "HOME", "`n`    Default toggle Extruder routine 'ON' Hotkey `n` Engine Default: HOME `n`", "                   HOTKEY OPTIONS (Configure These) `n` AutoHotkey Keylist: `n` https://www.autohotkey.com/docs/KeyList.htm `n` `n` Example: `n` If I wanted to set the Extruder Start Button `n` to CTRL+HOME, I would enter the following: `n` ExtruderStartKey = ^HOME `n` `n` For a complete key list, see the link above. `n` `n`")
; ini.write("CLIENT", "RaidLeader", "Raidleader", "`n`    Current character that sends tabs `n`    (CASE SENSITIVE) `n` `n` `n` `n` `n`", "                   CLIENT OPTIONS (Configure these) `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOIA", "1", "`n`    Plays Sound when Quick Launching AOIA `n` `n` `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngineSteam", "1", "`n`    Plays Sound when Quick Launching AO STEAM `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngine", "1", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
; ini.write("SOUND", "LoopEnd", "1", "`n`    Plays Sound on loop end `n` `n` `n`")
; ini.write("SOUND", "LoopStart", "1", "`n`    Plays Sound on loop start `n` `n` `n`", "                   SOUND OPTIONS (Configure these) `n` `n`")
; ini.write("VELOCITY", "F7SpeedDefault", "8100", "`n`    F7 Key LoopRate Default Speed `n` `n` `n` `n` `n`")
; ini.write("VELOCITY", "MSpeedDefault", "8000", "`n`    M Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "TabSpeedDefault", "5000", "`n`    Tab Key LoopRate Default Speed (RaidLeader) `n` `n` `n`", "                   DEFAULT KEY LOOPING SPEEDS (MILLISECONDS)`n` `n`")
; ini.write("DEBUG", "AutoAOIDUpdateMsg", "0", "`n`    Output TrayBallon Message On Each Loop `n` `n` `n`", "                   FOR DEVELOPER TESTING (CAN SAFELY IGNORE)`n` `n`")
ini.Save()
Sleep, 500
Reload
        Return
    }





IniRead, ICvarElevate, stack_core.ini, ENGINE, RunWithAdmin, %IniKeyErrorElevate%
If ICvarElevate = 1
{
;                         {[
;;           ELEVATE TO ADMIN UAC PROMPT BELOW
; If the script is not elevated, relaunch as administrator and kill current instance:
 
full_command_line := DllCall("GetCommandLine", "str")
 
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
;
;                          ]}
}

;;;_____________________________;;;
;;;                             ;;;
;;;         _______  __   __  ___   ___      ______         _______  ___   ___      _______  _______ 
;;;        |  _    ||  | |  ||   | |   |    |      |       |       ||   | |   |    |       ||       |
;;;        | |_|   ||  | |  ||   | |   |    |  _    |      |    ___||   | |   |    |    ___||  _____|
;;;        |       ||  |_|  ||   | |   |    | | |   |      |   |___ |   | |   |    |   |___ | |_____ 
;;;        |  _   | |       ||   | |   |___ | |_|   |      |    ___||   | |   |___ |    ___||_____  |
;;;        | |_|   ||       ||   | |       ||       |      |   |    |   | |       ||   |___  _____| |
;;;        |_______||_______||___| |_______||______|       |___|    |___| |_______||_______||_______|
;;;                             ;;;
;;;                             ;;;
;;;                             ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; 1.            ;;; SCANLINE IMAGES

    if FileExist("$imgsrc_Bar4Stack.png")
    {
        Sleep, 10
    }
    Else {
                SplashTextOn, 470 , ,  %RebuildFileString1%
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Bar4Stack.png, %A_ScriptDir%\$imgsrc_Bar4Stack.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_Bar7Stack.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Bar7Stack.png, %A_ScriptDir%\$imgsrc_Bar7Stack.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_Bar67Stack.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Bar67Stack.png, %A_ScriptDir%\$imgsrc_Bar67Stack.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_BarSingle.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_BarSingle.png, %A_ScriptDir%\$imgsrc_BarSingle.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_cCupSingle.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_cCupSingle.png, %A_ScriptDir%\$imgsrc_cCupSingle.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_Coffee4Stack.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Coffee4Stack.png, %A_ScriptDir%\$imgsrc_Coffee4Stack.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_Coffee4Stack_2.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Coffee4Stack_2.png, %A_ScriptDir%\$imgsrc_Coffee4Stack_2.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_Coffee7Stack.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_Coffee7Stack.png, %A_ScriptDir%\$imgsrc_Coffee7Stack.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_CoffeeMachine.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_CoffeeMachine.png, %A_ScriptDir%\$imgsrc_CoffeeMachine.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("$imgsrc_ExtruderMachine.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\gfx\scan_image\$imgsrc_ExtruderMachine.png, %A_ScriptDir%\$imgsrc_ExtruderMachine.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    ;; end 1.









    
    ;; 2.            ;;; AUDIO FILES

    if FileExist("snd\about.wav")
    {
        Sleep, 10
    }
    Else {
        SplashTextOn, 470 , ,  %RebuildFileString3%  ; REBUILD SND FILES NOTIFY
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\about.wav, %A_ScriptDir%\snd\about.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\b_bug.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\b_bug.wav, %A_ScriptDir%\snd\b_bug.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\beep_high.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\beep_high.wav, %A_ScriptDir%\snd\beep_high.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\bleep.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\bleep.wav, %A_ScriptDir%\snd\bleep.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\button_no.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\button_no.wav, %A_ScriptDir%\snd\button_no.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\button_ok.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\button_ok.wav, %A_ScriptDir%\snd\button_ok.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\combine_on_q.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\combine_on_q.wav, %A_ScriptDir%\snd\combine_on_q.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("snd\combine_x.wav")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\snd
    Sleep, 500
    FileInstall, _assembly\snd\combine_x.wav, %A_ScriptDir%\snd\combine_x.wav, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    ;; end 2.










    ;; 4.            ;;; IMAGE FILES (GUI)

    if FileExist("gui\bg.png")
    {
        Sleep, 10
    }
    Else {
        SplashTextOn, 470 , ,  %RebuildFileString2%  ; REBUILD SND FILES NOTIFY
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\bg.png, %A_ScriptDir%\gui\bg.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("gui\about.exe")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ), Could locate one or more GUI About Files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\_about\about.exe, %A_ScriptDir%\gui\about.exe, 0
    FileInstall, _assembly\_about\ab_x.png, %A_ScriptDir%\gui\ab_x.png, 0
    FileInstall, _assembly\_about\about_bg.png, %A_ScriptDir%\gui\about_bg.png, 0
    FileInstall, _assembly\_about\about_bar.png, %A_ScriptDir%\gui\about_bar.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    if FileExist("gui\loop_active.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\loop_active.png, %A_ScriptDir%\gui\loop_active.png, 0
    ; Progress, 42 ; Set the position of the bar to 42%.
    Sleep, 500
    }

    ;     if FileExist("gui\loop_inactive.png")
    ; {
    ;     Sleep, 10
    ; }
    ; Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\gui
    ; Sleep, 500
    ; FileInstall, _assembly\gfx\_gui\loop_inactive.png, %A_ScriptDir%\gui\loop_inactive.png, 0
    ; Progress, 56 ; Set the position of the bar to 56%.
    ; Sleep, 500
    ; }

        if FileExist("gui\x.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\x.png, %A_ScriptDir%\gui\x.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }


        if FileExist("gui\min.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\min.png, %A_ScriptDir%\gui\min.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

    ;     if FileExist("gui\bug.png")
    ; {
    ;     Sleep, 10
    ; }
    ; Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\gui
    ; Sleep, 500
    ; FileInstall, _assembly\gfx\_gui\bug.png, %A_ScriptDir%\gui\bug.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    ; Sleep, 500
    ; }

        if FileExist("gui\bugreporter.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\bugreporter.png, %A_ScriptDir%\gui\bugreporter.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

        if FileExist("gui\help.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\help.png, %A_ScriptDir%\gui\help.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

        if FileExist("gui\about.png")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\about.png, %A_ScriptDir%\gui\about.png, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

        Progress, Off

    ;; end 4.




    ;; 3.            ;;; SETTINGS CONFIG APP

    if FileExist("settings.exe")
    {
        Sleep, 10
    }
    Else {
                SplashTextOn, 470 , ,  %RebuildFileString4%  ; REBUILD SND FILES NOTIFY
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    ; FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\_checkbox_src\settings.exe, %A_ScriptDir%\settings.exe, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    }

    ;; end 3.




    ;; 4.            ;;; BUG REPORTER FILES

        if FileExist("bug_report\bug_reporter.exe")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding Bug Reporter Files..., Automation Engine, Automation BR Rebuild Progress
    FileCreateDir, %A_ScriptDir%\bug_report
    Sleep, 500
    FileInstall, _assembly\BugReporter\bug_reporter.exe, %A_ScriptDir%\bug_report\bug_reporter.exe, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }


        if FileExist("bug_report\report.exe")
    {
        Sleep, 10
    }
    Else {
    ; Progress, b w200, Rebuilding Bug Reporter Files..., Automation Engine, Automation BR Rebuild Progress
    FileCreateDir, %A_ScriptDir%\bug_report
    Sleep, 500
    FileInstall, _assembly\BugReporter\report.exe, %A_ScriptDir%\bug_report\report.exe, 0
    ; Progress, 98 ; Set the position of the bar to 98%.
    Sleep, 500
    }

    Sleep, 150


    if FileExist("gui\bug.png")
    {
        Sleep, 10
    }
    Else {
    ; MsgBox, 48, %EngineTitle% - %EngineError0x0% ( %EngineInfo0x0% ) 1, Could locate one or more GUI Image files. Rebuilding...
    ; Progress, b w200, Rebuilding GUI images..., Automation Engine, Automation GUI Rebuild Progress
    FileCreateDir, %A_ScriptDir%\gui
    Sleep, 500
    FileInstall, _assembly\gfx\_gui\bug_bg.png, %A_ScriptDir%\gui\bug.png, 0
    ; Progress, 10 ; Set the position of the bar to 14%.
    Sleep, 500
    } 

    ;; end 4.



    Progress, Off
    SplashTextOff













;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;    BBBBBBBBBBBBBBBBB   UUUUUUUU     UUUUUUUUIIIIIIIIIILLLLLLLLLLL             DDDDDDDDDDDDD                     GGGGGGGGGGGGGUUUUUUUU     UUUUUUUUIIIIIIIIII
;;;;    B::::::::::::::::B  U::::::U     U::::::UI::::::::IL:::::::::L             D::::::::::::DDD               GGG::::::::::::GU::::::U     U::::::UI::::::::I
;;;;    B::::::BBBBBB:::::B U::::::U     U::::::UI::::::::IL:::::::::L             D:::::::::::::::DD           GG:::::::::::::::GU::::::U     U::::::UI::::::::I
;;;;    BB:::::B     B:::::BUU:::::U     U:::::UUII::::::IILL:::::::LL             DDD:::::DDDDD:::::D         G:::::GGGGGGGG::::GUU:::::U     U:::::UUII::::::II
;;;;      B::::B     B:::::B U:::::U     U:::::U   I::::I    L:::::L                 D:::::D    D:::::D       G:::::G       GGGGGG U:::::U     U:::::U   I::::I  
;;;;      B::::B     B:::::B U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G               U:::::D     D:::::U   I::::I  
;;;;      B::::BBBBBB:::::B  U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G               U:::::D     D:::::U   I::::I  
;;;;      B:::::::::::::BB   U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G    GGGGGGGGGG U:::::D     D:::::U   I::::I  
;;;;      B::::BBBBBB:::::B  U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G    G::::::::G U:::::D     D:::::U   I::::I  
;;;;      B::::B     B:::::B U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G    GGGGG::::G U:::::D     D:::::U   I::::I  
;;;;      B::::B     B:::::B U:::::D     D:::::U   I::::I    L:::::L                 D:::::D     D:::::D     G:::::G        G::::G U:::::D     D:::::U   I::::I  
;;;;      B::::B     B:::::B U::::::U   U::::::U   I::::I    L:::::L         LLLLLL  D:::::D    D:::::D       G:::::G       G::::G U::::::U   U::::::U   I::::I  
;;;;    BB:::::BBBBBB::::::B U:::::::UUU:::::::U II::::::IILL:::::::LLLLLLLLL:::::LDDD:::::DDDDD:::::D         G:::::GGGGGGGG::::G U:::::::UUU:::::::U II::::::II
;;;;    B:::::::::::::::::B   UU:::::::::::::UU  I::::::::IL::::::::::::::::::::::LD:::::::::::::::DD           GG:::::::::::::::G  UU:::::::::::::UU  I::::::::I
;;;;    B::::::::::::::::B      UU:::::::::UU    I::::::::IL::::::::::::::::::::::LD::::::::::::DDD               GGG::::::GGG:::G    UU:::::::::UU    I::::::::I
;;;;    BBBBBBBBBBBBBBBBB         UUUUUUUUU      IIIIIIIIIILLLLLLLLLLLLLLLLLLLLLLLLDDDDDDDDDDDDD                     GGGGGG   GGGG      UUUUUUUUU      IIIIIIIIII




;;; Extruder ON/OFF HOTKEYS
IniRead, ICvarExtKey, stack_core.ini, HOTKEY, ExtruderStartKey, %IniKeyErrorElevate%
GLOBAL ExtruderStartInput := ICvarExtKey
Hotkey, %ExtruderStartInput%, ExtruderSTARTBTN
IniRead, ICvarExtKey2, stack_core.ini, HOTKEY, ExtruderStopKey, %IniKeyErrorElevate%
GLOBAL ExtruderStopInput := ICvarExtKey2
Hotkey, %ExtruderStopInput%, StopExtruderEvent

;;; Coffee ON/OFF HOTKEYS
IniRead, ICvarCofKey, stack_core.ini, HOTKEY, CoffeeStartKey, %IniKeyErrorElevate%
GLOBAL CoffeeStartInput := ICvarCofKey
Hotkey, %CoffeeStartInput%, CoffeeSTARTBTN
IniRead, ICvarCofKey2, stack_core.ini, HOTKEY, CoffeeStopKey, %IniKeyErrorElevate%
GLOBAL CoffeeStopInput := ICvarCofKey2
Hotkey, %CoffeeStopInput%, StopCoffeeEvent


                                                                          


; Menu, FileMenu, Add, Script Icon, MenuHandler1
; Menu, FileMenu, Add, Suspend Icon, MenuHandler2
; Menu, FileMenu, Add, Pause Icon, MenuHandler3
; ; Menu, FileMenu, Icon, Script Icon, %A_ScriptDir%\_assembly\gfx\_icon\S.ico
; Menu, FileMenu, Icon, Suspend Icon, %A_AhkPath%, -206 ; Use icon with resource identifier 206
; Menu, FileMenu, Icon, Pause Icon, %A_AhkPath%, -207 ; Use icon with resource identifier 207
; ; Menu, FileMenu, Icon, Script Icon, %A_AhkPath%, 2 ; Use the 2nd icon group from the file
; ; Menu, FileMenu, Icon, Suspend Icon, %A_AhkPath%, -206 ; Use icon with resource identifier 206
; ; Menu, FileMenu, Icon, Pause Icon, %A_AhkPath%, -207 ; Use icon with resource identifier 207
; Menu, MyMenuBar, Add, &File, :FileMenu


; Gui, Menu, MyMenuBar ;;  uncomment this to add the menubar back, but you need to fix it lol
Gui, -Caption

Gui, Add, Button, x0 y40 w1 h1  , .

IniRead, ExtruderSpeed, stack_core.ini, CLIENT, Extruder_LOOP_Speed, Default]
; Gui, Add, Edit, x489 y202 w104 h17 vCS, %SelectedCrat%
; Gui, Add, Edit, x489 y202 w104 h17 vES, %SelectedCrat%

IniRead, SelectedCratT, stack_core.ini, CLIENT, CurrentCrat, Default]
Gui, Add, Edit, x489 y202 w104 h17 vCCrat, %SelectedCratT%
IniRead, SelectedTrader, stack_core.ini, CLIENT, CurrentTrader, Default]
Gui, Add, Edit, x510 y425 w87 h17 vCTrader, %SelectedTrader%
Gui, Add, Button, x476 y223 w105 h27 gUpdateCurrCrat, UPDATE CRAT
Gui, Add, Button, x476 y446 w105 h27 gUpdateCurrTrader, UPDATE TRAD


Gui, Add, Button, x32 y401 w127 h73 gSettingsApp, SETTINGS

;;;________________________________________________________
;;; coffeemachine buttons
Gui, Add, Button, x581 y266 w91 h57 gStopCoffeeEvent, STOP

Gui, Add, Button, x476 y266 w100 h57 vCPause  , PAUSE
Gui, Add, Button, x222 y266 w244 h57 gCoffeeSTARTBTN, START
;;;________________________________________________________
;;;________________________________________________________
;;;________________________________________________________
;;; extrudermachine buttons
Gui, Add, Button, x581 y490 w91 h57 gStopExtruderEvent, STOP

Gui, Add, Button, x476 y490 w100 h57 vEPause  , PAUSE
Gui, Add, Button, x222 y490 w244 h57 gExtruderSTARTBTN, START
;;;________________________________________________________
;;;________________________________________________________

Gui, Add, Picture, x654 y0 gclose, %A_ScriptDir%\gui\x.png
Gui, Add, Picture, x632 y0 gmin, %A_ScriptDir%\gui\min.png
; Gui, Add, Picture, x0 y0 gUImove, %A_ScriptDir%\_assembly\gfx\_gui\about_bar.png
; Gui, Add, Picture,  x0 y24 gUImove, %A_ScriptDir%\_assembly\gfx\_gui\stackref_bg.png
Gui, Add, Picture,  X11 y525 gAbout, %A_ScriptDir%\gui\about.png
Gui, Add, Picture,  X66 y525 gHelp, %A_ScriptDir%\gui\help.png
Gui, Add, Picture,  X130 y525 gBugReporter, %A_ScriptDir%\gui\bugreporter.png

Gui, Add, Picture,  x0 y0 gUImove, %A_ScriptDir%\gui\bg.png


; Gui, Add, Picture, x654 y0 gclose +BackgroundTrans, %A_ScriptDir%\_assembly\gfx\_gui\x.png
; Gui, Add, Picture, x632 y0 gclose +BackgroundTrans, %A_ScriptDir%\_assembly\gfx\_gui\min.png

; Gui, Add, Picture, x560 y0 gclose, %A_ScriptDir%\gui\x.png
; Gui, Add, Picture,  x0 y0, %A_ScriptDir%\_assembly\gfx\_gui\StackReferences_GUI.png
; Gui, Add, Button, x581 y266 w91 h57  , STOP
; Gui, Add, Button, x476 y266 w100 h57  , PAUSE
; Gui, Add, Button, x222 y266 w244 h57  , START



; Gui, Add, Button, x581 y490 w91 h57  , STOP
; Gui, Add, Button, x476 y490 w100 h57  , PAUSE
; Gui, Add, Button, x222 y490 w244 h57  , START
Gui, Add, Picture, x654 y0 gclose, %A_ScriptDir%\gui\x.png
Gui, Add, Picture, x632 y0 gmin, %A_ScriptDir%\gui\min.png



Gui, Add, Button, x0 y40 w1 h1  , .

IniRead, SelectedCratT, stack_core.ini, CLIENT, CurrentCrat, Default]
Gui, Add, Edit, x489 y202 w104 h17 vCCCrat, %SelectedCratT%
IniRead, SelectedTraderT, stack_core.ini, CLIENT, CurrentTrader, Default]
Gui, Add, Edit, x510 y425 w87 h17 vCCTrader, %SelectedTraderT%
Gui, Add, Button, x476 y223 w105 h27 , UPDATE CRAT
Gui, Add, Button, x476 y446 w105 h27 , UPDATE TRAD


Gui, Show, h580 w680, %SDK_TitleString%
; Gui, Show, x557 y185 h580 w680, %SDK_TitleString%



; Gui, Add, Picture, x321 y195 +BackgroundTrans vCInactive, %A_ScriptDir%\gui\loop_inactive.png
; Gui, Add, Picture, x321 y195 +BackgroundTrans vC2, %A_ScriptDir%\gui\loop_inactive.png ;;;;;
; Gui, Add, Picture, x321 y195 +BackgroundTrans vCActive, %A_ScriptDir%\gui\loop_active.png
Gui, Add, Picture, x321 y195 +BackgroundTrans vC1, %A_ScriptDir%\gui\loop_active.png

; Gui, Add, Picture, x321 y420 +BackgroundTrans vEInactive, %A_ScriptDir%\gui\loop_inactive.png
; Gui, Add, Picture, x321 y420 +BackgroundTrans vE2, %A_ScriptDir%\gui\loop_inactive.png ;;;;;
; Gui, Add, Picture, x321 y420 +BackgroundTrans vEActive, %A_ScriptDir%\gui\loop_active.png
Gui, Add, Picture, x321 y420 +BackgroundTrans vE1, %A_ScriptDir%\gui\loop_active.png

Gui, Add, Button, x32 y401 w127 h73 gSettingsApp, SETTINGS




;:::: FCVAR_DEVELOPMENTONLY COMMANDS HERE, DISABLES FEATURES IN THE RELEASE VERSION
GuiControl, Disable, CPause  ; fix gui not changing text to resume/pause on toggle - also weird behaviour to re-enable this
GuiControl, Disable, EPause
GuiControl Hide, C1
GuiControl Hide, E1
; Gui, Show, x557 y185 h580 w680, %SDK_TitleString%
Return


;;;;;;;;   END BUILD GUI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;; MENUBAR MISC CRAP

MenuHandler1:
MsgBox, 48, [Script Icon] File Menu Test, [Script Icon]
return

MenuHandler2:
MsgBox, 48, [Suspend Icon] File Menu Test, [Suspend Icon]
return

MenuHandler3:
MsgBox, 48, [Pause Icon] File Menu Test, [Pause Icon]
return





                                                                                                                                                   
                                                                                                                                                   
;;;;    HHHHHHHHH     HHHHHHHHH     OOOOOOOOO     TTTTTTTTTTTTTTTTTTTTTTTKKKKKKKKK    KKKKKKKEEEEEEEEEEEEEEEEEEEEEEYYYYYYY       YYYYYYY   SSSSSSSSSSSSSSS    ;;;;
;;;;    H:::::::H     H:::::::H   OO:::::::::OO   T:::::::::::::::::::::TK:::::::K    K:::::KE::::::::::::::::::::EY:::::Y       Y:::::Y SS:::::::::::::::S   ;;;;
;;;;    H:::::::H     H:::::::H OO:::::::::::::OO T:::::::::::::::::::::TK:::::::K    K:::::KE::::::::::::::::::::EY:::::Y       Y:::::YS:::::SSSSSS::::::S   ;;;;
;;;;    HH::::::H     H::::::HHO:::::::OOO:::::::OT:::::TT:::::::TT:::::TK:::::::K   K::::::KEE::::::EEEEEEEEE::::EY::::::Y     Y::::::YS:::::S     SSSSSSS   ;;;;
;;;;      H:::::H     H:::::H  O::::::O   O::::::OTTTTTT  T:::::T  TTTTTTKK::::::K  K:::::KKK  E:::::E       EEEEEEYYY:::::Y   Y:::::YYYS:::::S               ;;;;
;;;;      H:::::H     H:::::H  O:::::O     O:::::O        T:::::T          K:::::K K:::::K     E:::::E                Y:::::Y Y:::::Y   S:::::S               ;;;;
;;;;      H::::::HHHHH::::::H  O:::::O     O:::::O        T:::::T          K::::::K:::::K      E::::::EEEEEEEEEE       Y:::::Y:::::Y     S::::SSSS            ;;;;
;;;;      H:::::::::::::::::H  O:::::O     O:::::O        T:::::T          K:::::::::::K       E:::::::::::::::E        Y:::::::::Y       SS::::::SSSSS       ;;;;
;;;;      H:::::::::::::::::H  O:::::O     O:::::O        T:::::T          K:::::::::::K       E:::::::::::::::E         Y:::::::Y          SSS::::::::SS     ;;;;  
;;;;      H::::::HHHHH::::::H  O:::::O     O:::::O        T:::::T          K::::::K:::::K      E::::::EEEEEEEEEE          Y:::::Y              SSSSSS::::S    ;;;;  
;;;;      H:::::H     H:::::H  O:::::O     O:::::O        T:::::T          K:::::K K:::::K     E:::::E                    Y:::::Y                   S:::::S   ;;;;  
;;;;      H:::::H     H:::::H  O::::::O   O::::::O        T:::::T        KK::::::K  K:::::KKK  E:::::E       EEEEEE       Y:::::Y                   S:::::S   ;;;;  
;;;;    HH::::::H     H::::::HHO:::::::OOO:::::::O      TT:::::::TT      K:::::::K   K::::::KEE::::::EEEEEEEE:::::E       Y:::::Y       SSSSSSS     S:::::S   ;;;;  
;;;;    H:::::::H     H:::::::H OO:::::::::::::OO       T:::::::::T      K:::::::K    K:::::KE::::::::::::::::::::E    YYYY:::::YYYY    S::::::SSSSSS:::::S   ;;;;  
;;;;    H:::::::H     H:::::::H   OO:::::::::OO         T:::::::::T      K:::::::K    K:::::KE::::::::::::::::::::E    Y:::::::::::Y    S:::::::::::::::SS    ;;;;  
;;;;    HHHHHHHHH     HHHHHHHHH     OOOOOOOOO           TTTTTTTTTTT      KKKKKKKKK    KKKKKKKEEEEEEEEEEEEEEEEEEEEEE    YYYYYYYYYYYYY     SSSSSSSSSSSSSSS      ;;;;  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BUTTONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





; HOME::
ExtruderSTARTBTN:
SOUNDloopstartExtruder()
SetTimer, UpdateCoffeeHud, Off
IniRead, LeftHUD, stack_core.ini, CLIENT, Left_HeadsUp_Display, Default]
If(LeftHUD = 1)
{
SplashTextOn, 580 , ,  %ExtruderLoopOnString%
; Sleep, 5
; WinMove, %A_Space% %A_Space% %A_Space% %A_Space% %A_Space% [StackExchange]:      AUTO-LOOP  {EXTRUDER  MACHINE}   IS   ('RUNNING'), , 0, 0  ; Move the splash window to the top left corner.
WinMove, %ExtruderLoopOnString%, , 0, 0  ; Move the splash window to the top left corner.
}
If(LeftHUD = 0)
{
SplashTextOff
SetTimer, UpdateExtruderHud, Off
}
SetTimer, CoffeeStartTimer, Off
SetTimer, ExtruderStartTimer, Off
Sleep, 200
GuiControl Show, E1
Sleep, 400
GuiControl Hide, C1
; COFFEOFFSTATE()
; GuiControl Hide, CActive
; GuiControl Show, CInactive

; GuiControl Show, EActive
; GuiControl Hide, EInactive
Gui, Submit, NoHide
SetTimer, ExtruderStartTimer, 4000
Return

ExtruderStartTimer:
Gui, Submit, NoHide
GuiControl Show, E1
GuiControl Hide, C1
GLOBAL CoffeeActive := "0"
GLOBAL ExtruderActive := "1"
Sleep, 1500
SetTimer, CoffeeLogic, Off
Sleep, 1500
ScanRunningA()
IniRead, ExtruderSpeed, stack_core.ini, CLIENT, Extruder_LOOP_Speed, Default]
SetTimer, ExtruderLogic, % ExtruderSpeed + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
; SetTimer, ExtruderLogic, % BarDelayInterval + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
SetTimer, ExtruderStartTimer, Off
Return



INS::
CoffeeSTARTBTN:
SOUNDloopstartCoffee()
SetTimer, UpdateExtruderHud, Off
IniRead, LeftHUD, stack_core.ini, CLIENT, Left_HeadsUp_Display, Default]
If(LeftHUD = 1)
{
SplashTextOn, 580 , ,  %CoffeeLoopOnString%
; Sleep, 5
; WinMove, %A_Space% %A_Space% %A_Space% %A_Space% %A_Space% [[StackExchange]:      AUTO-LOOP   { COFFEE  MACHINE }   IS   ('RUNNING'), , 0, 0  ; Move the splash window to the top left corner.
WinMove, %CoffeeLoopOnString%, , 0, 0  ; Move the splash window to the top left corner.
}
If(LeftHUD = 0)
{
SplashTextOff
SetTimer, UpdateCoffeeHud, Off
}
SetTimer, CoffeeStartTimer, Off
SetTimer, ExtruderStartTimer, Off
Sleep, 200
; COFFEONSTATE()
GuiControl Show, C1
Sleep, 400
GuiControl Hide, E1
; EXTRUDEROFFSTATE()
; GuiControl Hide, EActive
; GuiControl Show, EInactive

; GuiControl Show, CActive
; GuiControl Hide, CInactive
Gui, Submit, NoHide
SetTimer, CoffeeStartTimer, 4000
Return

CoffeeStartTimer:
Gui, Submit, NoHide
GuiControl Show, C1
; Sleep, 500
GuiControl Hide, E1
GLOBAL ExtruderActive := "0"
GLOBAL CoffeeActive := "1"
Sleep, 1500
SetTimer, ExtruderLogic, Off
Sleep, 1500
ScanRunningB()
IniRead, CoffeeSpeed, stack_core.ini, CLIENT, Coffee_LOOP_Speed, Default]
SetTimer, CoffeeLogic, % CoffeeSpeed + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
; SetTimer, CoffeeLogic, % CoffeeDelayInterval + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
SetTimer, CoffeeStartTimer, Off
Return


;:::::::  SUB-ROUTINE BUTTON CONTROL PANEL  :::::::  :::::::  :::::::  :::::::  


;; PAUSE BUTTONS

UNPAUSECoffee()
{
        Gui, Submit, NoHide
    GLOBAL ExtruderActive := "0"
    GLOBAL CoffeeActive := "1"
        SetTimer, ExtruderLogic, Off
        ScanRunningB()
        SetTimer, CoffeeLogic, % CoffeeDelayInterval + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
        Return
}

UNPAUSEExtruder()
{
        Gui, Submit, NoHide
    GLOBAL CoffeeActive := "0"
    GLOBAL ExtruderActive := "1"
        SetTimer, CoffeeLogic, Off
        ScanRunningA()
        SetTimer, ExtruderLogic, % BarDelayInterval + 4700   ;; Where X = the user's input time and 2700 = hard-coded sleep times during the scan phase
}



; INS::
; EXTcontrolPause:
PauseExtruderEvent:
; Gui, Submit, NoHide
; GLOBAL ExtruderActive := "0"
; ScanRunningA()
; SetTimer, ExtruderLogic, Off   ;; PAUSE EXTRUDER EVENTS
Gui, Submit, NoHide
; GLOBAL CoffeeActive := "0"
    ;
    If(ExtruderActive = 1)
    {
    SetTimer, ExtruderLogic, Off
    ControlSetText, Button5, &RESUME
    GuiControl Text, EPause, RESUME
        Return
    }
    If(ExtruderActive = 0)
    {
    UNPAUSEExtruder()
    GuiControl Text, EPause, PAUSE
        Return
    }
    ;
    Return


; DEL::
; COFcontrolPause:
PauseCoffeeEvent:
Gui, Submit, NoHide
; GLOBAL CoffeeActive := "0"
    ;
    If(CoffeeActive = 1)
    {
    SetTimer, CoffeeLogic, Off   ;; PAUSE EXTRUDER EVENTS
    GuiControl, Text, CPause, RESUME
        Return
    }
    If(CoffeeActive = 0)
    {
        UNPAUSECoffee()
    GuiControl, Text, CPause, PAUSE
        Return
    }
    ;
    Return



; END::
StopExtruderEvent:
ReleaseInput()
SOUNDloopstopExtruder()
SplashTextOff
SetTimer, UpdateExtruderHud, Off
SetTimer, ExtruderStartTimer, Off
; GuiControl Show, EInactive
; GuiControl Hide, EActive
; GuiControl Show, EInactive
; GuiControl HIde, EActive
; EXTRUDEROFFSTATE()
Sleep, 500
GuiControl Hide, E1
; COFFEOFFSTATE()
Gui, Submit, NoHide
; ScanRunningA()
; GLOBAL CoffeeActive := "0"
GLOBAL ExtruderActive := "0"
; SetTimer, CoffeeLogic, Off   ;; STOPS COFFEE EVENTS
SetTimer, ExtruderLogic, Off   ;; STOPS EXTRUDER EVENTS
; Reload
Return

DEL::
StopCoffeeEvent:
ReleaseInput()
SOUNDloopstopCoffee()
SplashTextOff
SetTimer, UpdateCoffeeHud, Off
SetTimer, CoffeeStartTimer, Off
; GuiControl Show, CInactive
; GuiControl Hide, CActive
; GuiControl Show, CInactive
; GuiControl Hide, CActive
; ScanRunningB()
; COFFEOFFSTATE()
Sleep, 500
GuiControl Hide, C1
; EXTRUDEROFFSTATE()
Gui, Submit, NoHide
; GLOBAL ExtruderActive := "0"
GLOBAL CoffeeActive := "0"
; SetTimer, ExtruderLogic, Off   ;; STOPS EXTRUDER EVENTS
SetTimer, CoffeeLogic, Off   ;; STOPS COFFEE EVENTS
; Reload
Return



COFFEONSTATE()
{
; GuiControl Hide, C2
Sleep, 10
GuiControl Show, C1
Return
}

COFFEOFFSTATE()
{
GuiControl Hide, C1
Sleep, 10
; GuiControl Show, C2
Return
}



EXTRUDERONSTATE()
{
; GuiControl Hide, E2
Sleep, 10
GuiControl Show, E1
Return
}


EXTRUDEROFFSTATE()
{
GuiControl Hide, E1
Sleep, 10
; GuiControl Show, E2
Return
}



;:::::::  :::::::  :::::::  :::::::  :::::::  :::::::  :::::::  ::::::



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











UpdateExtruderHud:
IniRead, LeftHUD, stack_core.ini, CLIENT, Left_HeadsUp_Display, Default]
If(LeftHUD = 1)
{
SplashTextOn, 580 , ,  %ExtruderLoopOnString%
; Sleep, 5
; WinMove, %A_Space% %A_Space% %A_Space% %A_Space% %A_Space% [StackExchange]:      AUTO-LOOP  {EXTRUDER  MACHINE}   IS   ('RUNNING'), , 0, 0  ; Move the splash window to the top left corner.
WinMove, %ExtruderLoopOnString%, , 0, 0  ; Move the splash window to the top left corner.
Return
}
If(LeftHUD = 0)
{
SplashTextOff
SetTimer, UpdateExtruderHud, Off
}
Return

UpdateCoffeeHud:
IniRead, LeftHUD, stack_core.ini, CLIENT, Left_HeadsUp_Display, Default]
If(LeftHUD = 1)
{
SplashTextOn, 580 , ,  %CoffeeLoopOnString%
; Sleep, 5
; WinMove, %A_Space% %A_Space% %A_Space% %A_Space% %A_Space% [[StackExchange]:      AUTO-LOOP   { COFFEE  MACHINE }   IS   ('RUNNING'), , 0, 0  ; Move the splash window to the top left corner.
WinMove, %CoffeeLoopOnString%, , 0, 0  ; Move the splash window to the top left corner.
}
If(LeftHUD = 0)
{
SplashTextOff
SetTimer, UpdateCoffeeHud, Off
Return
}
Return







ScanRunningA()
{
    ;
    If(ExtruderActive = 1)
    {
        ExtruderScan()
        Return
    }
    If(ExtruderActive = 0)
    {
        ; ExtruderScan()
        Return
    }
    ;
    Return
}

ScanRunningB()
{
    If(CoffeeActive = 1)
    {
        CoffeeScan()
        Return
    }
    If(CoffeeActive = 0)
    {
        ; ExtruderScan()
        Return
    }
    ;
    Return
}



; ScanRunning()
; {
;     ;
;     If(ExtruderActive = 1)
;     {
;         ExtruderScan()
;         Return
;     }
;     If(ExtruderActive = 0)
;     {
;         ; ExtruderScan()
;         Return
;     }
;     If(CoffeeActive = 1)
;     {
;         CoffeeScan()
;         Return
;     }
;     If(CoffeeActive = 0)
;     {
;         ; ExtruderScan()
;         Return
;     }
;     ;
;     Return
; }




CoffeeLogic:
CoffeeScan()
Return



ExtruderLogic:
ExtruderScan()
Return




Min:
WinMinimize, %A%
Return



UpdateCurrCrat:
SOUNDsaveCrat()
Gui, Submit, NoHide
Sleep, 5
IniWrite, %A_Space%%CCrat%, stack_core.ini, CLIENT, CurrentCrat
; IniWrite, %A_Space%%CCCrat%, stack_core.ini, CLIENT, CurrentCrat
MsgBox, 262144, StackExchange - Current Crat, Updated Current Crat Successfully.
Return

UpdateCurrTrader:
SOUNDsaveTrader()
Gui, Submit, NoHide
Sleep, 5
IniWrite, %A_Space%%CTrader%, stack_core.ini, CLIENT, CurrentTrader
MsgBox, 262144, StackExchange - Current Trader, Updated Current Trader Successfully.
Return




ParseTargetWinClampTRADER()
{
    IniRead, CurrentTrader, stack_core.ini, CLIENT, Extruder_TRADERName, ;% %
    ;Make this activate the AO window
    WinActivate, Anarchy Online - %CurrentTrader%
    Return
}

ParseTargetWinClampCRAT()
{
    IniRead, CurrentTrader, stack_core.ini, CLIENT, Extruder_CRATName, ;% %
    ;Make this activate the AO window
    WinActivate, Anarchy Online - %CurrentTrader%
    Return
}



CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}


UImove:
PostMessage, 0xA1, 2,,, A
Return

About:
SOUNDabout()
Run, %A_ScriptDir%\gui\about.exe
; MsgBox,, ABOUT, STUFF HERE
Return

Help:
SOUNDhelp()
MsgBox,, HELP, WIKI STILL UNDER CONSTRUCTION
Return

BugReporter:
SOUNDbugReporter()
; MsgBox,, BUG REPORTER, STUFF HERE
Run, %A_ScriptDir%\bug_report\bug_reporter.exe
Return


close:
GuiClose:
ExitApp


SettingsApp:
SOUNDlaunchSettings()
; MsgBox,, SETTINGS APP, STUFF HERE
Run, %A_ScriptDir%\settings.exe
Return


;;;;=====================================================================================================================================================================
;;;;=====================================================================================================================================================================


; ScanCold_Extruder()
; {
;     If (ExtruderScanPass > 0)
;     {
;         ;; the first scan completed, check for any extra single bars or cups now
;         Return
;     }
;     ; If (ExtruderScanPass < 1)
;     ; {
;     ;     IfDoAltTab()  ;; The loop ended, do IfAltTab settings check
;     ;     Return
;     ; }
;     If (ExtruderScanPass = 0)
;     {
;         IfDoAltTab()  ;; The loop ended, do IfAltTab settings check
;         Return
;     }
;     Return
; }




; ScanCold()
; {
;     If (ExtruderScanPass > 0)
;     {
;         ;; the first scan completed, check for any extra single bars or cups now
;     }
;     If (ExtruderScanPass > 1)
;     {
;         ;; there was a 2nd extra pass made, check for any extra single bars or cups now
;     }
;     If (ExtruderScanPass > 1)
;     {
;         ;; there was an extra pass made, check for any extra single bars or cups now
;     }
;     If (ExtruderScanPass > 1)
;     {
;         ;; there was an extra pass made, check for any extra single bars or cups now
;     }
; }

; The answer is in here: <!-- m -->http://www.autohotke...s.htm#Operators<!-- m -->

; Var1 += 20 ; adds 20 to Var1
; Var1 -= 20 ; subtracts 20 from Var1

;;; You can do the same with another variable:
; Var1 -= Var2 ; subtracts Var2 from Var1

;;;; But that can be a little confusing, so I would do something like this:
; Var3 := (Var1 - Var2)
;;;; It's just a matter of preference.


;;;;=====================================================================================================================================================================
;;;;=====================================================================================================================================================================





IfDoAltTab()
{
    IniRead, IfDoAltTab, stack_core.ini, ENGINE, Do_Auto_AltTab, Default]
    ;; Do Ini Read here for option (will peform automatic alt-tab at the end of the logical loop)
    If(IfDoAltTab = 1)
    {
        ; SetKeyDelay 30,50
        Send, {ALT DOWN}{TAB}{ALT UP}
        Sleep, 100
        Send, {ALT UP}
        Return
    }
    Else If (IfDoAltTab = 0)
    {
    }
}




IfEarlyInputLockActive()
{
    IniRead, IfEarlyInputLockActive, stack_core.ini, ENGINE, Do_Early_InputLock, Default]
    ;; Do Ini Read here for option (will perform an auto-lock of all input controls at the start of each ImageSearching loop to ensure controls are locked for the remainder of the logical loop)
    If(IfEarlyInputLockActive = 1)
    {
        BlockInput()
        Return
    }
    Else If(IfEarlyInputLockActive = 0)
    {
        ReleaseInput()
        Return
    }
}


BlockInput()
{
    IniRead, IfBlockInput, stack_core.ini, ENGINE, Auto_LockInput, Default]
    If(IfBlockInput = 1)
    {
        LockInput()
        Return
    }
    Else If(IfBlockInput = 0)
    {
        ; ReleaseInput()
        Return
    }
}

LockInput()
{
    BlockInput On           ;BLOCK MOUSE MOVEMENTS DURING MOTION
	Mouse_Blocked := true   ;BLOCK MOUSE MOVEMENTS DURING MOTION
	BlockInput, MouseMove   ;BLOCK MOUSE MOVEMENTS DURING MOTION
    Return
}







ReleaseInput()
{
    BlockInput Off            ;UNBLOCK MOUSE MOVEMENTS AFTER MOTION
	Mouse_Blocked := false    ;UNBLOCK MOUSE MOVEMENTS AFTER MOTION
    BlockInput, MouseMoveoff  ;UNBLOCK MOUSE MOVEMENTS AFTER MOTION
    Return
}





StartHangTimerCheck()
{
    IniRead, AutoCorrectInput, stack_core.ini, ENGINE, Auto_Handle_InputHang, Default]
    ;; Do Ini Read here for option (will perform an auto-lock of all input controls at the start of each ImageSearching loop to ensure controls are locked for the remainder of the logical loop)
    If(AutoCorrectInput = 1)
    {
        SetTimer, HangDetected, %INPUT_HANG_TIMEOUT%
        Return
    }
    Else If(AutoCorrectInput = 0)
    {
        Return
    }
}

KillHangTimer()
{
    SetTimer, HangDetected, Off
    Return
}


HangDetected:
ReleaseInput()
SetTimer, HangDetected, Off
Return






;;////////////////////////////////////SOUND FUNCTIONS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\;;
SOUNDloopstartExtruder()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDStrtExtruder, stack_core.ini, SOUND, Extruder_Module_Start, Default
    if(SNDStrtExtruder = 1) and (SNDEngineMaster = 1)
    {
    ; SoundBeep
    SoundPlay, .\_assembly\snd\button_ok.wav
    Return
    }
    if(SNDStrtExtruder = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDStrtExtruder = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDloopstopExtruder()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDStopExtruder, stack_core.ini, SOUND, Extruder_Module_Stop, Default
    if(SNDStopExtruder = 1) and (SNDEngineMaster = 1)
    {
    ; SoundBeep
    SoundPlay, .\_assembly\snd\button_no.wav
    Return
    }
    if(SNDStopExtruder = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDStopExtruder = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}


SOUNDloopstartCoffee()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDStrtCoffee, stack_core.ini, SOUND, Coffee_Module_Start, Default
    if(SNDStrtCoffee = 1) and (SNDEngineMaster = 1)
    {
    ; SoundBeep
    SoundPlay, .\_assembly\snd\button_ok.wav
    Return
    }
    if(SNDStrtCoffee = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDStrtCoffee = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDloopstopCoffee()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDStopCoffee, stack_core.ini, SOUND, Coffee_Module_Stop, Default
    if(SNDStopCoffee = 1) and (SNDEngineMaster = 1)
    {
    ; SoundBeep
    SoundPlay, .\_assembly\snd\button_no.wav
    Return
    }
    if(SNDStopCoffee = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDStopCoffee = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}


SOUNDlaunchSettings()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDLaunchSettings, stack_core.ini, SOUND, Settings_Config_Start, Default
    if(SNDLaunchSettings = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\combine_on_q.wav
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


SOUNDsaveCrat()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDSaveCrat, stack_core.ini, SOUND, Save_Current_Crat, Default
    if(SNDSaveCrat = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\beep_high.wav
    Return
    }
    if(SNDSaveCrat = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDSaveCrat = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDsaveTrader()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDSaveTrader, stack_core.ini, SOUND, Save_Current_Trader, Default
    if(SNDSaveTrader = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\beep_high.wav
    Return
    }
    if(SNDSaveTrader = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDSaveTrader = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDabout()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDabout, stack_core.ini, SOUND, About_Start, Default
    if(SNDabout = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\about.wav
    Return
    }
    if(SNDabout = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDabout = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDhelp()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDhelp, stack_core.ini, SOUND, Help_Start, Default
    if(SNDhelp = 1) and (SNDEngineMaster = 1)
    {
    SoundBeep
    Return
    }
    if(SNDhelp = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDhelp = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}

SOUNDbugReporter()
{
    IniRead, SNDEngineMaster, stack_core.ini, SOUND, Sound_Master_Switch, Default
    IniRead, SNDBugReport, stack_core.ini, SOUND, Bug_Reporter_Start, Default
    if(SNDBugReport = 1) and (SNDEngineMaster = 1)
    {
    SoundPlay, .\snd\b_bug.wav
    Return
    }
    if(SNDBugReport = 1) and (SNDEngineMaster = 0)
    {
    Return
    }
    if(SNDBugReport = 0) and (SNDEngineMaster = 1)
    {
    Return
    }
    Return
}
;;////////////////////////////////////SOUND FUNCTIONS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\;;







; COFFEONSTATE()
; {
;     If(CoffeeOn = 1) and (ExtruderOn = 1)
;     {
;     GuiControl Hide, C2
;     Sleep, 10
;     GuiControl Show, C1
;     }
; Return
; }

; COFFEOFFSTATE()
; {
; GuiControl Hide, C1
; Sleep, 10
; GuiControl Show, C2
; Return
; }



; EXTRUDERONSTATE()
; {
; GuiControl Hide, E2
; Sleep, 10
; GuiControl Show, E1
; Return
; }


; EXTRUDEROFFSTATE()
; {
; GuiControl Hide, E1
; Sleep, 10
; GuiControl Show, E2
; Return
; }