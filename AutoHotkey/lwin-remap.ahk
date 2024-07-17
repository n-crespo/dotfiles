; https://superuser.com/a/1819950/881662


#InstallKeybdHook


; Optional: Remap winKey + <someKey> here:

;LWin::
;If ProcessExist ("Flow.Launcher.exe"){
;KeyWait, LWin, T0.15
;If !ErrorLevel ; if you hold the LWin key for less than 150 milliseconds
;Send, !{Space} ; send alt+space
;Else ; but if it is held for more than that
;Send, {LWin Down} ; hold LWin down
;KeyWait, LWin ; and, in both cases, wait for it to be released
;}else{ ; if process doesn't exist, windows key will function like normal
;Send, {LWin Down}
;KeyWait, LWin
;}
;Send, {LWin Up}
;return

#space::return
#s::return

#j::Send {Down}
return

#k::Send {Up}
return

;#h::Send {Left}
;return

; #d::Send {PgDn}
; return

; #u::Send {PgUp}
; return

Reload
