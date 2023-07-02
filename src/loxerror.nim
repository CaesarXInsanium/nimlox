import std/strformat

var had_error* = false

proc report*(line: int, where: string, message: string) =
  var mes = fmt"[line {line}] Error here [{where}] message [{message}]"
  echo mes

proc error*(line: int, message: string) = 
  report(line, "", message)
