import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';
import 'package:torrefacteurk/entity/Seed.dart';
import 'package:uuid/uuid.dart';

import '../api/FarmService.dart';

class FieldProvider extends ChangeNotifier {
  List<Seed> _seeds = [];

  UnmodifiableListView<Seed> get seeds => UnmodifiableListView(_seeds);

  final dbRef = FirebaseDatabase.instance.ref();

  void postSeed(BuildContext context, String idUser, String idField, Seed seed) {
    int currentWallet =  0;
    getUserWallet(idUser).then((amount) {
      currentWallet = amount;
      if(currentWallet >= seed.cost) {
        String generatedId = const Uuid().v1();
        seed.id = generatedId;
        seed.date = DateTime.now().millisecondsSinceEpoch + (seed.duration*1000);
        dbRef.child("users/$idUser/farm/fields/$idField/seeds/$generatedId").set(seed.toJson());
        dbRef.child("users/$idUser").update({"wallet":currentWallet-seed.cost});
        _seeds.add(seed);
        Provider.of<UserProvider>(context, listen: false).updateUserWallet(currentWallet-seed.cost);
      }
      notifyListeners();
    });
  }

  Future<void> getSeeds(String idUser, String idField) async {
    _seeds = await getSeedsByFieldId(idUser,idField);
    notifyListeners();
  }

  void collectSeed(BuildContext context, String idUser, Seed seed, String idField) {
    dbRef.child("users/$idUser/farm/fields/$idField/seeds/${seed.id}").remove().then((value) {
      double quantity = Provider.of<UserProvider>(context, listen: false).updateUserStock(seed.name, seed.quantity);
      dbRef.child("users/$idUser/stock/").update({seed.name.toLowerCase(): quantity}).then((value) {
        Provider.of<UserProvider>(context, listen: false).removeSeed(idField, seed);
        _seeds.remove(seed);
        notifyListeners();
      });
    });
  }
}