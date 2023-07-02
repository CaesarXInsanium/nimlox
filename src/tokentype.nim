type
  TokenType* = enum
    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,
    Comma,
    Dot,
    Minus,
    Plus,
    SemiColon,
    Slash,
    Star,

    # Two Char
    Bang,
    Bang_Equal,
    Equal,
    EqualEqual,
    Greater,
    Greater_Equal,
    Less,
    LessEqual,

    # Literals
    Identifier,
    String,
    Number,

    # KEYWORDS
    And,
    Class,
    Else,
    False,
    Fun,
    For,
    If,
    Nil,
    Or,
    Print,
    Return,
    Super,
    This,
    True,
    Var,
    While,

    Eof

proc `$`*(self: TokenType): string =
  case self:
    of TokenType.LeftParen:
      return "LeftParen"
    of TokenType.RightParen:
      return "RightParen"
    of TokenType.LeftBrace:
      return "LeftBrace"
    of TokenType.RightBrace:
      return "RightBrace"
    of TokenType.Comma:
      return "Comma"
    of TokenType.Dot:
      return "Dot"
    of TokenType.Minus:
      return "Minus"
    of TokenType.Plus:
      return "Plus"
    of TokenType.SemiColon:
      return "SemiColon"
    of TokenType.Slash:
      return "Slash"
    of TokenType.Star:
      return "Star"

    # Two Char
    of TokenType.Bang:
      return "Bang"
    of TokenType.Bang_Equal:
      return "Bang_Equal"
    of TokenType.Equal:
      return "Equal"
    of TokenType.EqualEqual:
      return "EqualEqual"
    of TokenType.Greater:
      return "Greater"
    of TokenType.Greater_Equal:
      return "GreaterEqual"
    of TokenType.Less:
      return "Less"
    of TokenType.LessEqual:
      return "LessEqual"

    # Literals
    of TokenType.Identifier:
      return "Identifier"
    of TokenType.String:
      return "String"
    of TokenType.Number:
      return "Number"

    # KEYWORDS
    of TokenType.And:
      return "And"
    of TokenType.Class:
      return "Class"
    of TokenType.Else:
      return "Else"
    of TokenType.False:
      return "False"
    of TokenType.Fun:
      return "Fun"
    of TokenType.For:
      return "For"
    of TokenType.If:
      return "If"
    of TokenType.Nil:
      return "Nil"
    of TokenType.Or:
      return "Or"
    of TokenType.Print:
      return "Print"
    of TokenType.Return:
      return "Return"
    of TokenType.Super:
      return "Super"
    of TokenType.This:
      return "This"
    of TokenType.True:
      return "True"
    of TokenType.Var:
      return "Var"
    of TokenType.While:
      return "While"
    of TokenType.Eof:
      return "Eof"
