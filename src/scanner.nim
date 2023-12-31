import token
import std/tables
import std/strutils
import tokentype
import loxobject
import loxerror

type
  Scanner = ref object
    source: string
    tokens: seq[Token]
    start: int
    current: int
    line: int

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

proc is_at_end*(self: var Scanner): bool =
  return self.current >= self.source.len()

proc add_token*(self: var Scanner, token_type: TokenType,
    lox_object: LoxObject) =
  var text = self.source.substr(self.start, self.current - 1)
  self.tokens.add(newToken(token_type, text, nil, self.line))

proc add_token*(self: var Scanner, token_type: TokenType) =
  self.add_token(token_type, nil)

proc advance(self: var Scanner): char =
  result = self.source[self.current]
  self.current = self.current + 1

# import std/strutils
# isAlphaNumeric
# isDigit
# isAlphaAscii

proc peek(self: var Scanner): char =
  if self.is_at_end():
    return '\0'
  return self.source[self.current]

proc identifier(self: var Scanner) =
  while(isAlphaNumeric(self.peek())):
    discard self.advance()
  var text: string = self.source.substr(self.start, self.current - 1)
  try:
    var token_type = keywords[text]
    add_token(self, token_type)
  except KeyError:
    var token_type = TokenType.Identifier
    add_token(self, token_type)

proc match(self: var Scanner, expected: char): bool =
  if (self.is_at_end()):
    return false
  if (self.source[self.current] != expected):
    return false
  self.current = self.current + 1
  return true


proc peekNext(self: var Scanner): char =
  if (self.current + 1 >= self.source.len()):
    return '\0'
  return self.source[self.current + 1]

proc strings(self: var Scanner) =
  while(self.peek() != '"' and not self.is_at_end()):
    if self.peek() == '\n':
      self.line = self.line + 1
    discard self.advance()
  if self.is_at_end():
    error(self.line, "Unterminated String")
    return
  discard self.advance()
  var value = self.source.substr(self.start + 1, self.current)
  self.add_token(TokenType.String, LoxObject(kind: LoxKind.String,
      string_value: value))

proc number(self: var Scanner) =
  echo "Processing number!"
  while isDigit(self.peek()):
    discard self.advance()
  if self.peek() == '.' and isDigit(self.peek_next()):
    discard self.advance()
    while isDigit(self.peek()):
      discard self.advance()
    echo "Adding Number Token!"
  self.add_token(TokenType.Number, LoxObject(kind: LoxKind.Float,
      float_value: parseFloat(self.source.substr(self.start, self.current - 1))))

proc scan_token(self: var Scanner) =
  var c = self.advance()
  case c
  of '(':
    self.add_token(TokenType.LeftParen)
  of ')':
    self.add_token(TokenType.RightParen)
  of '{':
    self.add_token(TokenType.LeftBrace)
  of '}':
    self.add_token(TokenType.RightBrace)
  of ',':
    self.add_token(TokenType.Comma)
  of '.':
    self.add_token(TokenType.Dot)
  of '-':
    self.add_token(TokenType.Minus)
  of '+':
    self.add_token(TokenType.Plus)
  of ';':
    self.add_token(TokenType.Semicolon)
  of '*':
    self.add_token(TokenType.Star)
    ## Two Characters
  of '!':
    if self.match('='):
      add_token(self, TokenType.BangEqual)
    else:
      add_token(self, TokenType.Bang)
  of '=':
    if self.match('='):
      add_token(self, TokenType.EqualEqual)
    else:
      add_token(self, TokenType.Equal)
  of '<':
    if self.match('='):
      add_token(self, TokenType.LessEqual)
    else:
      add_token(self, TokenType.Less)
  of '>':
    if self.match('='):
      add_token(self, TokenType.GreaterEqual)
    else:
      add_token(self, TokenType.Greater)

  of '/':
    # handle comments
    if self.match('/'):
      while self.peek() != '\n' and not self.is_at_end():
        discard self.advance()
    else:
      self.add_token(TokenType.Slash)
    # whitespace
  of ' ':
    discard
  of '\r':
    discard
  of '\t':
    discard
  of '\n':
    self.line = self.line + 1
  of '"':
    self.strings()
  else:
    if isDigit(c):
      self.number();
    elif isAlphaAscii(c):
      self.identifier()
    else:
      error(self.line, "Unexpected Character.")

proc scan_tokens*(self: var Scanner): seq[Token] =
  while not self.is_at_end():
    self.start = self.current
    self.scan_token()
  self.tokens.add(newToken(TokenType.Eof, "", nil, self.line))
  return self.tokens

proc newScanner*(source: string): Scanner =
  result = new Scanner
  result.source = source
  result.tokens = newSeq[Token]()
  result.start = 0
  result.current = 0
  result.line = 0
