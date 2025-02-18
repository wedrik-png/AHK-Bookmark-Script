#Requires AutoHotkey v2.0
#SingleInstance Force   
+Esc::ExitApp

; Read the contents of the file
text := FileOpen("C:\Users\junej\Downloads\master ahk\bookmark\bookmarkhelper.txt", "r").Read()

; Display an input box with the file's content and get user selection
Input := InputBox("Select a bookmark by its number (1-based):`n`n" text, "Bookmarks")

; Ensure the user entered valid input
if !Input || !IsInteger(Input) {
    MsgBox("Invalid input. Please enter a valid number.")
    return
}

; Open the file again to parse the lines
File := FileOpen("C:\Users\junej\Downloads\master ahk\bookmark\bookmarkhelper.txt", "r")
if !File {
    MsgBox("Error: Unable to open the file.")
    return
}

; Initialize a counter to track line numbers
LineNumber := 0

; Loop through the file line by line
while !File.AtEOF {
    Line := File.ReadLine()
    LineNumber++

    ; Match the selected line number with user input
    if LineNumber == Input {
        ; Run the URL (or bookmark) on the selected line
        MsgBox("Opening: " . Line)
        Run Line
        break
    }
}

; Close the file
File.Close()

; Helper function to validate integers
IsInteger(Value) {
    return RegExMatch(Value, "^\d+$")
}
