class PaymentModel {
  String? identification;
  int? day;
  int? month;
  int? year;
  int? payment;

  PaymentModel({
    this.identification,
    this.day,
    this.month,
    this.year,
    this.payment,
  });

  // receiving data from server
  factory PaymentModel.fromMap(map) {
    return PaymentModel(
      identification: map['identification'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      payment: map['payment'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'identification': identification,
      'day': day,
      'month': month,
      'year': year,
      'payment': payment,
    };
  }
}
