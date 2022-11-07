import os
import osproc
import strutils
import times

when not defined(posix):
  import wAuto
  const bWin = "#"
  const bCtrl = "^"
  const bAlt = "!"
  const bGrave = "`"
  const bClose = "{F4}"
else:
  const bWin = "Super_L+"
  const bCtrl = "Ctrl+"
  const bAlt = "Alt+"
  const bGrave = "grave"
  const bClose = "w"

const sleepMs = 500

when defined(posix):
  proc send(s: string) =
    let cmd = "xdotool key "&s
    if 0 != execCmd cmd:
      echo "Error during: "&cmd
      quit 1

var counter = 0
proc time() =
  let f = open("current.txt", fmAppend)
  defer: f.close()
  f.writeLine counter, ": ", $now()
  inc counter

proc win(s: string) = send "Super_L+"&s; sleep sleepMs
proc ctrl(s: string) = send "Ctrl+"&s; sleep sleepMs
proc key(s: string) = send s; sleep sleepMs
proc tab() = key "Tab"
proc ret() = key "Return"
proc esc() = key "Escape"
proc typ(s: string) = send s.split().join(" "); ret()
proc vscode() =
  win "1"
  when defined(posix):
    win "d"
    typ "vscode"
  sleep 10000
  for c in 'a'..'d':
    ctrl "p"
    typ $c
    ctrl "f"
    typ "ldap_init"
    esc()
    ctrl "b"
    ctrl "o"
    ctrl "w"
    ctrl "w"
  ctrl bGrave
  typ "nimble fulltest --verbose"
  sleep 20000
  ctrl bGrave
  ctrl bClose

proc browser() =
  win "2"
  win "w"
  sleep 5000
  typ "youtube jess 123 video"
  sleep 1000
  for _ in 1..19:
    tab()
  ret()
  sleep 30000
  ctrl "w"
  ctrl "w"
  ctrl "w"

time()
while true:
  for _ in 0..20:
    for _ in 0..10:
      vscode()
      time()
    browser()
    time()


