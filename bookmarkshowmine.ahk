#Requires AutoHotkey v2.0
#SingleInstance Force
+Esc::ExitApp   


;CONFIGURATION
;Replace the file paths with those of the txt files you created
title_txt := "C:\Users\user\master ahk\bookmark\title.txt"
address_txt := "C:\Users\user\master ahk\bookmark\address.txt"
counter_txt := "C:\Users\user\master ahk\bookmark\counter.txt"
^+!b::
{
    ; Initialize variables
    x := "Heck"
    texty := FileOpen(title_txt, "r")

    ; Create GUI with a resizable window
    global MyGui := Gui("+Resize")
    MyGui.Title := "Bookmarks List"

    ; Add a Search Bar
    SearchBar := MyGui.Add("Edit", "w700 vSearchBar")
    SearchBar.OnEvent("Change", SearchList)

    ; Add a ListView
    LV := MyGui.Add("Listview", "Grid -Hdr r20 w700 vMyListView", ["Index"])

    ; Read each line from the texty and add it to the ListView
    while (x != "")
    {
        x := texty.ReadLine()
        if (x != "")
            LV.Add(, x)
    }

    ; Set the column width
    LV.ModifyCol(1, 500)

    ; Show the GUI
    MyGui.Show

    {
        ; Show an input box asking for a number
        Input := InputBox("Enter the number`n`n", "", "x780 y793 w260 h100")

        i := 1  ; Initialize counter

        ; Read through another file "bookmarksahk.txt" line by line
        Loop read, address_txt
        {
            ; Parse each line using tab as a delimiter
            Loop parse, A_LoopReadLine, A_Tab
            {
                ; Check if the user input matches the current index
                if (i == Input.value)
                {
                    MyGui.Destroy()
                    ; If match found, execute the corresponding line (open file/link)
                    Run A_LoopReadLine
                    return  ; Exit script after running
                }
                i := i + 1  ; Increment index counter
            }
        }

        Winclose "ahk_class AutoHotkeyGUI"
        MyGui.Destroy()
    }
}

SearchList(*) {
    global MyGui
    SearchBarText := MyGui.Submit(false).SearchBar
    LV := MyGui["MyListView"]

    LV.Modify(0, "-Select")  ; Clear previous selection

    Loop LV.GetCount()
    {
        LVText := LV.GetText(A_Index)
        if InStr(LVText, SearchBarText)
        {
            LV.Modify(A_Index, "Select")  ; Highlight the match
            LV.Modify(A_Index, "Vis")     ; Scroll to the match
            break  ; Stop after first match
        }
    }
} 
^+b::
{
i := 0
Sleep 100
Send "!d"
Sleep 100
Send "^c"
Sleep 100
Result := InputBox("Enter the title", "Bookmark website")
fbook := FileOpen(address_txt, "a")
fhelper := FileOpen(title_txt, "a")
Title := Result.Value


{
fcounter := FileOpen(counter_txt, "rw")
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
