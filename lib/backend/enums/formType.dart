enum FormType {
  TEXT,
  RADIO,
  NUMBER,
  SWITCH,
}

extension FormTypeHelper on FormType {
  toMap() => this.index;
  fromMap(dynamic x) => FormType.values.elementAt(x);
}
