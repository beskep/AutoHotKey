#Requires AutoHotkey v2.0

control := true
hotstrings := true
wheel_down := 'None' ; {'None', '{LButton}', '{Space}'}

TimeoutTrayTip(text, title := '', option := '', time := 1000) {
    TrayTip text
    SetTimer TrayTip, -time
}

^!+1::
{
    global control
    control := !control
    TimeoutTrayTip('Control: ' . (control ? "On" : "Off"))
}

^!+2::
{
    global hotstrings
    hotstrings := !hotstrings
    TimeoutTrayTip('Hotstrings: ' . (hotstrings ? "On" : "Off"))
}

^!+3::
{
    global wheel_down
    wheel_down := 'None'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

^!+4::
{
    global wheel_down
    wheel_down := wheel_down = '{LButton}' ? 'None' : '{LButton}'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

^!+5::
{
    global wheel_down
    wheel_down := wheel_down = '{Space}' ? 'None' : '{Space}'
    TimeoutTrayTip('WheelDown: ' . wheel_down)
}

#HotIf control
{
    ; Capslock
    +Capslock::Capslock
    Capslock::Ctrl

    ; Mouse
    XButton2:: Send '^{w}'

    ; Alt control
    !h:: Send '{Left}'
    !j:: Send '{Down}'
    !k:: Send '{Up}'
    !l:: Send '{Right}'

    ; Volume
    ^!PgDn:: Send '{Volume_Down}'
    ^!PgUp:: Send '{Volume_Up}'

    ; Hotstring
    :?*:\today\::
    {
        SendText FormatTime(, "yyyy-MM-dd")
    }
    :?*:\now\::
    {
        SendText FormatTime(, "yyyy-MM-dd HH:mm:ss")
    }
    :?*:\nowb\::
    {
        ; basic format
        SendText FormatTime(, "yyyyMMdd'T'HHmmss")
    }
    :?*:\nowc\::
    {
        ; 콜론 제외 (파일명에 사용)
        SendText FormatTime(, "yyyy-MM-dd HHmmss")
    }
}

#HotIf hotstrings
{
    ;{hotstrings}
}

#HotIf wheel_down != 'None'
{
    WheelDown:: Send wheel_down
}
