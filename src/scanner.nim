import token
import std/tables
import tokentype

type
  Scanner = ref object
    source: string
    tokens: seq[Token]
    start: uint
    endl: uint
    current: uint

const keywords: Table[string, TokenType] = toTable[string, TokenType]({
    "and": TokenType.And,
    "or": TokenType.Or,
    "class": TokenType.Class,
    "else": TokenType.Else,
    "false": TokenType.False,
    "for": TokenType.For,
    "fun": TokenType.Fun,
    "if": TokenType.If,
    "nil": TokenType.Nil,
    "print": TokenType.Print,
    "return": TokenType.Return,
    "super": TokenType.Super,
    "this": TokenType.This,
    "true": TokenType.True,
    "var": TokenType.Var,
    "while": TokenType.While})

proc newScanner*(source: string): Scanner =
  result = new Scanner
  result.source = source
  result.tokens = newSeq[Token]()

proc scan_tokens*(self: var Scanner): seq[Token] =
  result = newSeq[Token]()
  for char in self.source:
    echo char
