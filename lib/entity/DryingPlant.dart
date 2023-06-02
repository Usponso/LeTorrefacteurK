class DryingPlant {
  String id;
  final String type;
  int date;
  final int duration;
  final double quantity;

  DryingPlant({this.id="0", required this.type, required this.date, required this.duration, required this.quantity});

  DryingPlant.fromJson(Map<String, dynamic> json)
      :
        id = json['id'].toString(),
        type = json['type'],
        date = json['date'],
        duration = json['duration'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'type': type,
    'date': date,
    'duration': duration,
    'quantity': quantity,
  };
}