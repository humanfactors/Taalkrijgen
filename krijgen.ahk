;; Many functions taken from https://github.com/jdiamond/todo.txt-ahk/blob/master/todo.ahk
;; This should be called from command line
#SingleInstance, force
SendMode Input
SetWorkingDir, %A_ScriptDir%

ARG_LENGTHS := A_Args.Length()
SOURCE_FILE_PATH := ""

If (ARG_LENGTHS > 0) {
    SOURCE_FILE_PATH := A_Args[1]
}

; MsgBox % SOURCE_FILE_PATH

INI_FILE_NAME := "krijgen.ini"

GetConfig(section, key, default) {
  Global INI_FILE_NAME
  IniRead value, %A_ScriptDir%\%INI_FILE_NAME%, %section%, %key%, %default%
  return value
}

CAPTURE_DIRECTORY := ExpandEnvironmentStrings(GetConfig("FILES", "CaptureFolder", "%userprofile%\ShareX"))
DATA_FILE_NAME = GetConfig("FILES", "RecordTextFile", "taal_data.csv")
;; CAPTURE_DIRECTORY . "\" . "File"

; GUI Config
WINDOW_TITLE := "Capture a Dutch Moment"

InputMenu(SOURCE_FILE_PATH)
return

InputMenu(CAPTURE_FILE_NAME) {
    
    global

    Gui, +AlwaysOnTop +Resize
    Gui, font, s12, Arial

    Gui, Add, Text,, CaptionedText
    Gui, Add, Edit, W300 R3 vTranslationText
    Gui, Add, Text,, Source File:
    Gui, Add, Edit, W300 vCaptureFile, %CAPTURE_FILE_NAME%

    Gui, Add, Button, default w80 h40, &Submit
    Gui, Show, , % WINDOW_TITLE
}


ButtonSubmit:
Gui, Submit
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