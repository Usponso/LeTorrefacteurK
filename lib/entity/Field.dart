import 'Seed.dart';

class Field{
  final String id;
  final String name;
  final String specification;
  final List<Seed> seeds;

  Field({required this.id, required this.name, required this.specification, required this.seeds});

  factory Field.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String name = json['name'];
    String specification = json['specification'];
    List<Seed> seeds = [];
    if(json['seeds'] != null) {
       seeds = [...json['seeds'].values.map((value) => Seed.fromJson(value))];
    }
    return Field(id: id, name: name,specification: specification,seeds: seeds);
  }
}