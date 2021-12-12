enum Gender { MALE, FEMALE, OTHER }

extension GenderHelper on Gender {
  toMap() => this.index;
  fromMap(dynamic x) => Gender.values.elementAt(x);
}
