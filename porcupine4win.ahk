#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

for n, param in A_Args  ; For each parameter:
{
	Haystack := param
	Needle := "http"
	If InStr(Haystack, Needle) {
		MsgBox, Copied URL to clipboard: "%param%"
		clipboard := param
		break
	}
}