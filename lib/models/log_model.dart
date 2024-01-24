class LogModel {
  int number;
  String last;

  LogModel({required this.number, required this.last});

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      number: json['number'],
      last: json['last'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'last': last,
    };
  }
}
