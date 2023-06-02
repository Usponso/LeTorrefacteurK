import 'GATO.dart';

class Seed {
  String id;
  final String name;
  int date;
  final int duration;
  final int cost;
  final double quantity;
  GATO gato;

  Seed({this.id="0", required this.name, required this.date, required this.duration, required this.cost, required this.quantity, required this.gato});

  Seed.fromJson(Map<String, dynamic> json)
      :
        id = json['id'].toString(),
        name = json['name'],
        date = json['date'],
        duration = json['duration'],
        cost = json['cost'],
        quantity = json['quantity'],
        gato = GATO.fromJson(json['gato']);

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'name': name,
    'date': date,
    'duration': duration,
    'cost': cost,
    'quantity': quantity,
    'gato': gato.toJson()
  };
}