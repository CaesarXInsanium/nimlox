type
  LoxKind* = enum
    Int,
    Float,
    Bool,
    String,
  LoxObject* = ref object
    case kind*: LoxKind
    of Int: int_value*: int
    of Float: float_value*: float
    of Bool: bool_value*: bool
    of String: string_value*: string

