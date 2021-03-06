enum AgeGroup {
  ZERO_TO_TWENTY,
  NINETEEN_TWENTYFIVE,
  TWENTYSIX_THIRTY,
  THIRTYONE_THIRTYFIVE,
  THIRSTYSIX_FORTY,
  FORTYONE_FORTYFIVE,
  FORTYSIX_FIFTY,
  FIFTYONE_FIFTYFIVE,
  FIFTYSIX_SIXTY,
  SIXTYSIX_SEVENTY,
  SEVENTYONE_SEVENTYFIVE,
  SEVENTYSIX_EIGHTY,
  EIGHTYONE_EIGHTYFIVE,
  EIGHTYSIX_NINTY,
  NINTYONE_NINTYFIVE,
  NINTYSIX_HUNDREAD,
}

extension AgeGroupHelper on AgeGroup {
  int toMap() => this.index;
  AgeGroup fromMap(dynamic x) => AgeGroup.values.elementAt(x);
}
