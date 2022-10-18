class BillModel {
  String? description;
  int? day;
  int? month;
  int? year;
  int? worth;

  BillModel({
    this.description,
    this.day,
    this.month,
    this.year,
    this.worth,
  });

  // receiving data from server
  factory BillModel.fromMap(map) {
    return BillModel(
      description: map['description'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      worth: map['worth'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'day': day,
      'month': month,
      'year': year,
      'worth': worth,
    };
  }
}
