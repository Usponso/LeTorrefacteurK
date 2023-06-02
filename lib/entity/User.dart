import 'Farm.dart';
import 'UserStock.dart';
import 'DryingPlant.dart';

class User{
  String id;
  final String name;
  final String firstname;
  final String username;
  final String mail;
  int wallet;
  int gold;
  final String avatar;
  final Farm farm;
  final UserStock stock;
  final UserStock stockDried;
  List<DryingPlant> drying;

  User({required this.id, required this.name, required this.firstname, required this.username, required this.mail, required this.wallet, required this.gold, required this.avatar, required this.farm, required this.stock, required this.stockDried, required this.drying});

  // User.fromJson(Map<String, dynamic> json)
  //     :
  //       id = json['id'],
  //       name = json['name'],
  //       firstname = json['firstname'],
  //       username = json['username'],
  //       mail = json['mail'],
  //       wallet = json['wallet'],
  //       gold = json['gold'],
  //       avatar = json['avatar'],
  //       farm = Farm.fromJson(json['farm']),
  //       stock = UserStock.fromJson(json['stock']),
  //       stockDried = UserStock.fromJson(json['stockDried']);

  factory User.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String name = json['name'];
    String firstname = json['firstname'];
    String username = json['username'];
    String mail = json['mail'];
    int wallet = json['wallet'];
    int gold = json['gold'];
    String avatar = json['avatar'];
    Farm farm = Farm.fromJson(json['farm']);
    UserStock stock = UserStock.fromJson(json['stock']);
    UserStock stockDried = UserStock.fromJson(json['stockDried']);
    List<DryingPlant> drying = [];
    if(json['drying'] != null) {
      drying = [...json['drying'].values.map((value) => DryingPlant.fromJson(value))];
    }

    return User(id: id, name: name, firstname: firstname, username: username, mail: mail, wallet: wallet, gold: gold, avatar: avatar, stock: stock, stockDried: stockDried, farm: farm, drying: drying);
  }

}