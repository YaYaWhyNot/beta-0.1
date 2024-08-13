#SingleInstance, Force
#Persistent
#NoEnv
SetWorkingDir, %A_ScriptDir%

if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

currenttab := "0"

; Задаем цвета
global BackgroundColor := "1A1A1A"
global TextColor := "E0E0E0"
global ButtonColor := "2D2D2D"
global ButtonHoverColor := "3A3A3A"
global AccentColor := "00A8E8"

; Функция для создания стилизованной кнопки
CreateStylizedButton(vName, gName, Text, x, y, w, h, Options := "") {
    global
    Gui, Add, Button, x%x% y%y% w%w% h%h% v%vName% g%gName% Center +0x200 +Border %Options%, %Text%
    GuiControl, +Background%ButtonColor% +c%TextColor%, %vName%
}

; Создаем GUI
Gui, +LastFound +AlwaysOnTop -Caption +Border +Owner
global hWnd := WinExist()
Gui, Color, %BackgroundColor%
Gui, Font, s10 c%TextColor%, Segoe UI

; Создаем верхнюю панель для перемещения окна
Gui, Add, Text, x0 y0 w480 h30 gGuiMove, ; Невидимая область для перетаскивания

; Добавляем текст "Scripton"
Gui, Font, s16 cWhite bold, Segoe UI
Gui, Add, Text, x10 y5 vScriptonText, Scripton
Gui, Font, s10 c%TextColor% norm, Segoe UI

; Добавляем стильные кнопки отделов
CreateStylizedButton("AimbotBtn", "AimbotBtn", "exbutton", 10, 50, 130, 40)
CreateStylizedButton("ESPBtn", "ESPBtn", "exbutton2", 10, 100, 130, 40)
CreateStylizedButton("MiscBtn", "MiscBtn", "exbutto2", 10, 150, 130, 40)
CreateStylizedButton("SkibidiBtn", "SkibidiBtn", "scripts", 10, 200, 130, 40)

; Основная область справа
Gui, Add, Text, x160 y40 w310 h270 vMainArea c%TextColor%

; Добавляем кнопку "On script" заранее, но делаем ее невидимой
CreateStylizedButton("OnScriptBtn", "OnScriptHandler", "On Morph", 160, 280, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn2", "OnScriptHandler2", "Off Morph", 300, 280, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn3", "OnScriptHandler3", "On Invoker", 160, 230, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn4", "OnScriptHandler4", "Off Invoker", 300, 230, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn5", "OnScriptHandler5", "On AutoSf", 160, 180, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn6", "OnScriptHandler6", "Off AutoSf", 300, 180, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn7", "OnScriptHandler7", "On AutoRaze", 160, 130, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn8", "OnScriptHandler8", "Off AutoRaze", 300, 130, 100, 30, "Hidden")
CreateStylizedButton("OnScriptBtn9", "OnScriptHandler9", "Discord", 230, 100, 100, 30, "Hidden")

; Добавляем кнопку закрытия
Gui, Add, Text, x450 y0 w30 h30 vCloseBtn gCloseGui Center, X
GuiControl, +Background%ButtonColor% +c%TextColor%, CloseBtn

; Сглаживание углов GUI
WinSet, Region, 0-0 w480 h320 R10-10, ahk_id %hWnd%

; Hotkey для открытия/закрытия GUI
global GuiVisible := false
Insert::ToggleGui()

ToggleGui() {
    global GuiVisible, hWnd
    if (GuiVisible) {
        Gui, Hide
        GuiVisible := false
    } else {
        Gui, Show, w480 h320
        WinSet, AlwaysOnTop, On, ahk_id %hWnd%
        GuiVisible := true
    }
}

; Обработка событий GUI
GuiClose:
ExitApp

; Функция для кнопки закрытия
CloseGui:
ToggleGui()
return

; Функция для перемещения окна
GuiMove:
    PostMessage, 0xA1, 2
return

; Функции для обработки нажатий на кнопки отделов
AimbotBtn:
    if (currenttab != "Aim") {
    currenttab := "Aim"
    UpdateMainArea("exbutton", "Scripton is now in pre-alpha, so this tab is empty")
    HideAllScriptButtons()
    GuiControl, Hide, OnScriptBtn9
    GuiControl, Show, OnScriptBtn9
}
return

ESPBtn:
    if (currenttab != "ESP") {
    currenttab := "ESP"
    UpdateMainArea("exbutton2", "Scripton is now in pre-alpha, so this tab is empty")
    HideAllScriptButtons()
    GuiControl, Hide, OnScriptBtn9
    GuiControl, Show, OnScriptBtn9
}
return

MiscBtn:
    if (currenttab != "Misc") {
    currenttab := "Misc"
    UpdateMainArea("exbutton3", "Scripton is now in pre-alpha, so this tab is empty")
    HideAllScriptButtons()
    GuiControl, Hide, OnScriptBtn9
    GuiControl, Show, OnScriptBtn9
}
return

SkibidiBtn:
    if (currenttab != "Skibidi") {
    currenttab := "Skibidi"
    UpdateMainArea("SKIBIDI.EXE", "Information about functions can be found in the discord server")
    ShowAllScriptButtons()
    GuiControl, Hide, OnScriptBtn9
}
return

OnScriptHandler:
    Run, morph.exe
return

OnScriptHandler2:
    RunWait, powershell.exe -Command "Stop-Process -Name morph -Force",, Hide
return

OnScriptHandler3:
    Run, invoker.exe
return

OnScriptHandler4:
    RunWait, powershell.exe -Command "Stop-Process -Name invoker -Force",, Hide
return

OnScriptHandler5:
    Run, SfMenu.exe
return

OnScriptHandler6:
    RunWait, powershell.exe -Command "Stop-Process -Name SfMenu -Force",, Hide
    RunWait, powershell.exe -Command "Stop-Process -Name eul -Force",, Hide
return

OnScriptHandler7:
    Run, autorazzsf.exe
return

OnScriptHandler8:
    RunWait, powershell.exe -Command "Stop-Process -Name autorazzsf -Force",, Hide
    RunWait, powershell.exe -Command "Stop-Process -Name qwesf -Force",, Hide
    RunWait, powershell.exe -Command "Stop-Process -Name 123sf -Force",, Hide
    RunWait, powershell.exe -Command "Stop-Process -Name zxcsf -Force",, Hide
return

OnScriptHandler9:
    Run, https://discord.gg/bezeNGwjzm
return

; Функция для обновления основной области
UpdateMainArea(Title, Content) {
    GuiControl,, MainArea, %Title%`n`n%Content%
}

; Функция для скрытия всех кнопок скриптов
HideAllScriptButtons() {
    GuiControl, Hide, OnScriptBtn
    GuiControl, Hide, OnScriptBtn2
    GuiControl, Hide, OnScriptBtn3
    GuiControl, Hide, OnScriptBtn4
    GuiControl, Hide, OnScriptBtn5
    GuiControl, Hide, OnScriptBtn6
    GuiControl, Hide, OnScriptBtn7
    GuiControl, Hide, OnScriptBtn8
}

; Функция для показа всех кнопок скриптов
ShowAllScriptButtons() {
    GuiControl, Show, OnScriptBtn
    GuiControl, Show, OnScriptBtn2
    GuiControl, Show, OnScriptBtn3
    GuiControl, Show, OnScriptBtn4
    GuiControl, Show, OnScriptBtn5
    GuiControl, Show, OnScriptBtn6
    GuiControl, Show, OnScriptBtn7
    GuiControl, Show, OnScriptBtn8
}

; Создание эффекта наведения для кнопок
OnMessage(0x200, "WM_MOUSEMOVE")
return

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
    static PrevHwnd
    if (Hwnd != PrevHwnd) {
        for each, btn in ["AimbotBtn", "ESPBtn", "MiscBtn", "SkibidiBtn", "CloseBtn", "OnScriptBtn", "OnScriptBtn2", "OnScriptBtn3", "OnScriptBtn4", "OnScriptBtn5", "OnScriptBtn6", "OnScriptBtn7", "OnScriptBtn8", "OnScriptBtn9"] {
            GuiControlGet, btnHwnd, Hwnd, %btn%
            if (Hwnd == btnHwnd) {
                if (btn == "CloseBtn") {
                    GuiControl, +Background%AccentColor% +cWhite, %btn%
                } else {
                    GuiControl, +Background%ButtonHoverColor%, %btn%
                }
            } else if (PrevHwnd == btnHwnd) {
                GuiControl, +Background%ButtonColor% +c%TextColor%, %btn%
            }
        }
        PrevHwnd := Hwnd
    }
}

WM_NCHITTEST() {
    return 2  ; HTCAPTION
}