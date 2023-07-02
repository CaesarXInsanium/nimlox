import tokentype
import loxobject

type
  Token* = object
    token_type: TokenType
    lexeme: string
    literal: LoxObject
    line: int

proc newToken*(token_type: TokenType, lexeme: string, literal: LoxObject, line: int): Token =
  result = Token(token_type: token_type, lexeme: lexeme, literal: literal, line: line)

proc `$`*(this: Token): string =
  return "TokenType: " & $this.token_type & "\tLexeme: " & $this.lexeme &
      "\tLine: " & $this.line;
