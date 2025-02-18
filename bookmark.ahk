#Requires AutoHotkey v2.0
#SIngleInstance Force
+Esc::ExitApp
#HotIf WinActive("ahk_class Chrome_WidgetWin_1")

^+b::
{
i := 0
Sleep 100
Send "!d"
Sleep 100
Send "^c"
Sleep 100
Result := InputBox("Enter the title", "Bookmark website")
fbook := FileOpen("C:\Users\junej\Downloads\master ahk\bookmark\bookmarksahk.txt", "a")
fhelper := FileOpen("C:\Users\junej\Downloads\master ahk\bookmark\bookmarkhelper.txt", "a")
Title := Result.Value


{
fcounter := FileOpen("C:\Users\junej\Downloads\master ahk\bookmark\bookmarkcounter.txt", "rw")
fcounter.Seek(0)
i2 := fcounter.ReadLine()
i2 := i2+0
i2 := i2+1
fcounter.Seek(0)
fcounter.Write(i2)
;Msgbox "i2 = " i2
}

Appendtxtb := A_Clipboard . "`n"
Appendtxth := i2 . ". " . Title . "`n"
fbook.Write(Appendtxtb)
fhelper.Write(Appendtxth)
Msgbox "Saved! " . i2*1 . " " . Title . " " . A_Clipboard
A_Clipboard := ""
}

A_HotkeyModifierTimeout := 100
