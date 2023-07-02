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
