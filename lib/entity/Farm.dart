import 'package:torrefacteurk/entity/Field.dart';

class Farm{
  final String name;
  final List<Field> fields;

  Farm({required this.name, required this.fields});

  Farm.fromJson(Map<String, dynamic> json)
      :
        name = json['name'],
        fields = List<Field>.from(json['fields'].map((field) => Field.fromJson(field)));
}