#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ;run only once
SetBatchLines,-1
; IniRead, CDO_Password ,Auth.ini,CDO, Gmail_Password

GLOBAL CDO_Password := "gZYFUnqdAuB+zCCai:H"


;~ https://autohotkey.com/board/topic/36522-cdo-com-email-delivery/</code>
Important:={smtpserver: "smtp.gmail.com" ;"host157.hostmonster.com" ; specify your SMTP server
,smtpserverport: 465 ;587 465 ;110 ; 25
,smtpusessl: True ;For hostmonster it must be true
,sendusing: 2 ; cdoSendUsingPort
,smtpauthenticate: 1 ; cdoBasic
,sendusername: "notumoverflor@gmail.com" ;"Joe@the-Automator.com" ;Login UserName for the SMTP Server
,sendpassword: CDO_Password ;You have to create a special "App password" in gmail and use it here. https://the-automator.com/gmail_App_Password
,smtpconnectiontimeout: 60} ;Login Password
;*************Per message******************************************
HTML=This is in html. Check out the-Automator for some cool tips!
pmsg:=ComObjCreate("CDO.Message")
pmsg.From:="joe.glines@gmail.com"
pmsg.To:="notumoverflor@gmail.com"
pmsg.BCC:=
pmsg.CC:=
pmsg.Subject:="Send via CDO and AutoHotkey"
;~ pmsg.HtmlBody:=HTML ;This would be your content in an HTML format.
pmsg.TextBody := "This is the body of a plain text message" ;if you want to send plain text
Fields:={smtpserver:Important.smtpserver,smtpserverport:Important.smtpserverport,smtpusessl:Important.smtpusessl,sendusing:Important.sendusing,smtpauthenticate:Important.smtpauthenticate,sendusername:Important.sendusername,sendpassword:Important.sendpassword,smtpconnectiontimeout:Important.smtpconnectiontimeout}
pfld:=pmsg.Configuration.Fields
For Field,Value in fields
pfld.Item("http://schemas.microsoft.com/cdo/configuration/" Field):=Value
pfld.Update()
;********************File Attachements***********************************
; sAttach := "C:\AHK Studio\Projects\Companies.txt|C:\AHK Studio\Projects\AHK_LinkedIn.txt"
; Loop, Parse, sAttach, |, %A_Space%%A_Tab%
; pmsg.AddAttachment(A_LoopField)
pmsg.Send