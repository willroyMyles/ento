enum FormType {
  TEXT,
  NUMBER,
  PICTURE,
  RADIO,
  SWITCH,
}

extension FormTypeHelper on FormType {
  toMap() => this.index;
  fromMap(dynamic x) => FormType.values.elementAt(x);
}
