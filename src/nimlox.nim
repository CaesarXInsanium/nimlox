# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import os
import std/strformat
import token
import scanner

var had_error = false

proc report(line: int, where: string, message: string) =
  var mes = fmt"[line {line}] Error here [{where}] message [{message}]"
  echo mes

proc error(line: int, message: string) = 
  report(line, "", message)

proc run(source: string) = 
  var scanner = newScanner(source)
  var tokens: seq[Token] = scanner.scan_tokens()
  for token in tokens:
    echo $token

proc run_file(path: string) =
  let source = read_file(path)
  run(source)

proc run_prompt() =
  var cont = true
  while cont :
    write(stdout, "> ")
    var input = read_line(stdin)
    if input.len == 0:
      cont = false
    run(input)
    had_error = false


when isMainModule:
  let params = command_line_params()
  echo params
  if params.len > 1:
    echo "Usage: nimlox [file]"
    echo "Usage: nimlox"
  elif params.len == 1:
    run_file(params[0])
  else:
    run_prompt()

  echo "Program Exit"
