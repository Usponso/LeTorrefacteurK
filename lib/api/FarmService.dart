import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:torrefacteurk/entity/Field.dart';
import 'package:torrefacteurk/entity/User.dart';

import '../entity/Seed.dart';
import '../entity/UserStock.dart';

Future<List<Field>> getFieldsById(String idUser) async {
  var response = await FirebaseDatabase.instance.ref().child('users/$idUser/farm/fields').get();
  var decode = jsonEncode(response.value);
  List<Field> fields = List<Field>.from(json.decode(decode).map((field) => Field.fromJson(field)));
  return fields;
}

Future<List<Seed>> getSeedsByFieldId(String idUser, String idField) async {
  var response = await FirebaseDatabase.instance.ref().child('users/$idUser/farm/fields/$idField/seeds').get();
  var decode = jsonEncode(response.value);
  List<Seed> seeds = [];
  if(response.value != null) {
    seeds = [...json.decode(decode).values.map((seed) => Seed.fromJson(seed))];
  }
  return seeds;
}

Future<List<User>> getUsers() async{
  var response = await FirebaseDatabase.instance.ref().child('users/').get();
  var decode = jsonEncode(response.value);
  List<User> users = List<User>.from(json.decode(decode).map((user) => User.fromJson(user)));
  return users;
}

Future<UserStock> getUserStock(String idUser) async {
  var response = await FirebaseDatabase.instance.ref().child('users/$idUser/stock').get();
  var decode = jsonEncode(response.value);
  UserStock stock = UserStock.fromJson(json.decode(decode));
  return stock;
}

Future<int> getUserWallet(String idUser) async {
  var response = await FirebaseDatabase.instance.ref().child('users/$idUser/wallet').get();
  var decode = jsonEncode(response.value);
  int wallet = json.decode(decode);
  return wallet;
}

Future<User> getUserById(String idUser) async {
  var response = await FirebaseDatabase.instance.ref().child('users/$idUser').get();
  var decode = jsonEncode(response.value);
  User user = User.fromJson(json.decode(decode));
  return user;
}

Future<List<User>> getRankUsers() async {
  var response = await FirebaseDatabase.instance.ref().child('users').get();
  var decode = jsonEncode(response.value);
  List<User> users = List<User>.from(json.decode(decode).map((user) => User.fromJson(user)));
  users.sort((a,b) => a.gold.compareTo(b.gold));
  return List.from(users.reversed);
}
