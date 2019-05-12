
LAlt & `::    ; Last window
  WinGetClass, ActiveClass, A
  WinActivateBottom, ahk_class %ActiveClass%
return

CapsLock:: AltTab()

; a::msgbox hello


;----------------------------------------
; SUSPEND SCRIPT
;----------------------------------------

~RControl::
  Suspend, Permit
  if (A_PriorHotkey <> "~RControl" or A_TimeSincePriorHotkey > 400) {
    ; Too much time between presses, so this isn't a double-press.
    KeyWait, RControl
    return
  }
  Suspend, Toggle
return

; f12::Suspend


;----------------------------------------
; FUNCTIONS
;----------------------------------------

AltTab(){
  list := ""
  WinGet, id, list
  Loop, %id% {
    this_ID := id%A_Index%
    IfWinActive, ahk_id %this_ID%
      continue    
    WinGetTitle, title, ahk_id %this_ID%
    If (title = "")
      continue
    If (!IsWindow(WinExist("ahk_id" . this_ID))) 
      continue
    WinActivate, ahk_id %this_ID%, ,2
      break
  }
}

IsWindow(hWnd){
  WinGet, dwStyle, Style, ahk_id %hWnd%
  if ((dwStyle&0x08000000) || !(dwStyle&0x10000000)) {
    return false
  }
  WinGet, dwExStyle, ExStyle, ahk_id %hWnd%
  if (dwExStyle & 0x00000080) {
    return false
  }
  WinGetClass, szClass, ahk_id %hWnd%
  if (szClass = "TApplication") {
    return false
  }
  return true
}
