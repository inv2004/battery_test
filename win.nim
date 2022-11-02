import wAuto

import os
import osproc
import times

const sleepMs = 500

proc exec(cmd: string) =
  if 0 != execCmd cmd:
    echo "Error during: "&cmd
    quit 1

proc time() =
  writeFile("current.txt", $now())
proc win(s: string) = send "#"&s; sleep sleepMs
proc ctrl(s: string) = send "!"&s; sleep sleepMs
proc alt(s: string) = send "^"&s; sleep sleepMs
proc key(s: string) = send s; sleep sleepMs
proc tab() = send "{TAB}"; sleep sleepMs
proc ret() = send "{ENTER}"; sleep sleepMs
proc esc() = send "{ESC}"; sleep sleepMs
proc typ(s: string) = send s; sleep sleepMs; ret()
proc vscode() =
  win "1"
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
  ctrl "`"
  typ "nimble fulltest --verbose"
  ret()
  sleep 20000
  ctrl "`"
  alt "{F4}"

proc browser() =
  win "2"
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

writeFile("start.txt", $now())

while true:
  for _ in 0..20:
    for _ in 0..10:
      vscode()
      time()
    browser()
    time()

