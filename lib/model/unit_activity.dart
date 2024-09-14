class UnitActivity {
  final String name;
  final String serviceType;
  final String unit;
  final String approvedBy;
  final DateTime dateTime;
  final String imageUrl;
  final String entryTime;
  final String exitTime;

  UnitActivity({
    required this.name,
    required this.serviceType,
    required this.unit,
    required this.approvedBy,
    required this.dateTime,
    required this.imageUrl,
    required this.entryTime,
    required this.exitTime,
  });

  factory UnitActivity.fromJson(Map<String, dynamic> json) {
    return UnitActivity(
      name: json['name'],
      serviceType: json['serviceType'],
      unit: json['unit'],
      approvedBy: json['approvedBy'],
      dateTime: DateTime.parse(json['dateTime']),
      imageUrl: json['imageUrl'],
      entryTime: json['entryTime'],
      exitTime: json['exitTime'],
    );
  }
}