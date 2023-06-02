import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../api/FarmService.dart';
import '../entity/Seed.dart';
import '../entity/User.dart';
import '../entity/DryingPlant.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  final dbRef = FirebaseDatabase.instance.ref();

  Future<void> getUser(String idUser) async {
    user = await getUserById(idUser);
    notifyListeners();
  }

  void updateUserWallet(int newValue) {
    user.wallet = newValue;
    notifyListeners();
  }

  void updateDryingTasks(DryingPlant dryingPlant) {
    user.drying.add(dryingPlant);
    notifyListeners();
  }

  double updateUserStock(String seedName, double quantity) {
    double newQuantity = 0;
    switch(seedName) {
      case "Arbrista":
        user.stock.arbrista += quantity;
        newQuantity = user.stock.arbrista;
        break;
      case "Goldoria":
        user.stock.goldoria += quantity;
        newQuantity = user.stock.goldoria;
        break;
      case "Roupetta":
        user.stock.roupetta += quantity;
        newQuantity = user.stock.roupetta;
        break;
      case "Rubisca":
        user.stock.rubisca += quantity;
        newQuantity = user.stock.rubisca;
        break;
      case "Tourista":
        user.stock.tourista += quantity;
        newQuantity = user.stock.tourista;
        break;
    }

    notifyListeners();
    return newQuantity;
  }

  void removeSeed(String idField, Seed seed) {
    int fieldIndex = user.farm.fields.indexWhere((field) => field.id.toString() == idField);
    user.farm.fields[fieldIndex].seeds.remove(seed);
    notifyListeners();
  }

  void addDryingTask(BuildContext context, String idUser, DryingPlant dryingPlant) {
    String generatedId = const Uuid().v1();
    dryingPlant.id = generatedId;
    dbRef.child("users/$idUser/drying/$generatedId").set(dryingPlant.toJson());
    // todo: reduce coffee stock of the added drying task type
    Provider.of<UserProvider>(context, listen: false).updateDryingTasks(dryingPlant);
    notifyListeners();
  }
}