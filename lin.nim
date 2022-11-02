import os
import osproc

const sleepMs = 500

proc exec(cmd: string) =
  if 0 != execCmd cmd:
    echo "Error during: "&cmd
    quit 1

proc time() = exec "date > ~/current"
proc win(s: string) = exec "xdotool key Super_L+"&s; sleep sleepMs
proc ctrl(s: string) = exec "xdotool key Ctrl+"&s; sleep sleepMs
proc key(s: string) = exec "xdotool key "&s; sleep sleepMs
proc tab() = key "Tab"; sleep sleepMs
proc ret() = key "Return"; sleep sleepMs
proc esc() = key "Escape"; sleep sleepMs
proc typ(s: string) = exec "xdotool type '"&s&"'"; sleep sleepMs; ret()
proc vscode() =
  win "1"
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
  ctrl "grave"
  typ "nimble fulltest --verbose"
  ret()
  sleep 20000
  ctrl "grave"
  ctrl "q"

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

exec "date > ~/start"
while true:
  for _ in 0..20:
    for _ in 0..10:
      vscode()
      time()
    browser()
    time()


