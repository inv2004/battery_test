import os
import strutils
import times

when defined windows:
  import wAuto
else:
  import osproc

const sleepMs = 500

when not defined windows:
  proc cmd(s: string) =
    var s = s
    s = s.multiReplace {
            "!{F4}": "Ctrl+Q", "#": "Super_L+", "^": "Ctrl+", "!": "Alt+",
            "`": "Grave", "{TAB}": "Tab", "{ENTER}": "Return", "{ESC}": "Esc"
            }
    let cmd = "xdotool key "&s
    echo cmd
    if 0 != execCmd cmd:
      echo "Error during: "&cmd
      quit 1
else:
  proc cmd(s: string) =
    echo s
    send(s)

var counter = 0
proc time(mode = fmAppend) =
  let f = open("log.txt", mode)
  defer: f.close()
  f.writeLine counter, ": ", $now()
  inc counter

proc key(s: string, delay = sleepMs) = cmd s; sleep delay
proc win(s: string) = key "#"&s
proc ctrl(s: string) = key "^"&s
proc alt(s: string) = key "!"&s
proc tab() = key "{TAB}"
proc ret() = key "{ENTER}"
proc esc() = key "{ESC}"
proc typ(s: string) = cmd s.split().join(" "); ret()
proc wait(ms: int) = echo "... " & $ms; sleep ms
proc vscode() =
  win "1"
  when not defined windows:
    win "d"
    typ "vscode"
  wait 10000
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
  ctrl "`"
  typ "nimble test"
  wait 20000
  ctrl "`"
  alt "{F4}"

proc browser() =
  when defined windows:
    win "2"
  else:
    win "w"
  wait 5000
  typ "youtube jess 123 video"
  wait 1000
  for _ in 0..50:
    key "{DOWN}", 100
  for _ in 0..50:
    key "{UP}", 100
  for _ in 0..5:
    key "{F5}"
    wait 1000
  for _ in 1..19:
    tab()
  ret()
  wait 30000
  ctrl "w"
  ctrl "w"
  ctrl "w"

proc main() =
  time(fmWrite)
  while true:
    for _ in 0..10:
      vscode()
      time()
    browser()
    time()

main()

