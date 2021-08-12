;; Many functions taken from https://github.com/jdiamond/todo.txt-ahk/blob/master/todo.ahk
;; This should be called from command line
#SingleInstance, force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;; TIme
global timenow := TimeNow()
; global vCaptureFile
; global vTranslationText


;; Ini set varibales (adjustable)
INI_FILE_NAME := "krijgen.ini"

; Default directory files saved in
CAPTURE_DIRECTORY := ExpandEnvironmentStrings(GetConfig("FILES", "CaptureFolder", "%userprofile%\ShareX"))

DATA_FILE_NAME := GetConfig("FILES", "RecordTextFile", "taal_data.csv")
; DATA_FILE_NAME_PATH := "D:\Dropbox\Code\AHK\Taalkrijgen\taal_data.csv"
DATA_FILE_NAME_PATH = %A_ScriptDir%\sound_vertalen.csv

;; Get first argument, this is source filepath
ARG_LENGTHS := A_Args.Length()
SOURCE_FILE_PATH := ""

If (ARG_LENGTHS > 0) {
    SOURCE_FILE_PATH := A_Args[1]
}

;; CAPTURE_DIRECTORY . "\" . "File"

; GUI Config
WINDOW_TITLE := "Capture a Dutch Moment"

; _g global
; 


g_InputMenu(CAPTURE_FILE_NAME) {
    
    global

    Gui, +AlwaysOnTop +Resize
    Gui, font, s12, Arial

    Gui, Add, Text,, Captioned Text
    Gui, Add, Edit, W300 R1 vTranslationText
    Gui, Add, Text,, Source File:
    Gui, Add, Edit, W300 vCaptureFile, %CAPTURE_FILE_NAME%

    Gui, Add, Button, default w80 h40, &Submit
    Gui, Show, , % WINDOW_TITLE
    
}

WriteDataCSV() {
  global
  FileAppend, %CaptureFile%`| %TranslationText%`n ,%DATA_FILE_NAME_PATH%
}

F1::g_InputMenu("C:\ShareX\Recording.mp3")
Return

g_InputMenu("C:\ShareX\Recording.mp3")
return

ButtonSubmit:
Gui, Submit
WriteDataCSV()
Gui, Destroy
ExitApp, 1
Return

GuiClose:
GuiEscape:
Gui Cancel
ExitApp, 1
Return

^Enter::
Gui, Submit
WriteDataCSV()
Gui, Destroy
ExitApp, 1
Return




IsAbsolute(path) {
  Return RegExMatch(path, "(^[a-zA-Z]:\\)|(^\\\\)") > 0
}

; Remove whitespace from the beginning and end of the string.
TrimWhitespace(str) {
  Return RegExReplace(str, "(^\s+)|(\s+$)")
}

TimeNow() {
    now := A_Now
	FormatTime, date, now, yyyy-MM-dd
	FormatTime, time, now, HH:mm:ss
    return now
}

ExpandEnvironmentStrings(str) {
   VarSetCapacity(dest, 2000)
   DllCall("ExpandEnvironmentStrings", "str", str, "str", dest, int, 1999, "Cdecl int")
   Return dest
}

GetConfig(section, key, default) {
  Global INI_FILE_NAME
  IniRead value, %A_ScriptDir%\%INI_FILE_NAME%, %section%, %key%, %default%
  return value
}
