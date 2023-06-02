import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:torrefacteurk/entity/UserStock.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';

import '../api/FarmService.dart';
import '../entity/Farm.dart';
import '../entity/User.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key, required this.idUser}) : super(key: key);
  final String idUser;

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  User currentUser = User(id: "", name: "", avatar: "", firstname: "", username: "", gold: 0, wallet: 0, mail: "", stock: UserStock(arbrista: 0, goldoria: 0, roupetta: 0, rubisca: 0, tourista: 0), stockDried: UserStock(arbrista: 0, goldoria: 0, roupetta: 0, rubisca: 0, tourista: 0) ,farm: Farm(name: "", fields: []), drying: []);
  int currentUserPosition = 0;

  @override
  void initState() {
    super.initState();
    // Refreshing the position when the widget build is ended
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentUserPosition = currentUserPosition;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentUserPosition = currentUserPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text("Overall ranking", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            FutureBuilder(
              future: getRankUsers(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  return Column(
                    children: [
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if(snapshot.data[index].id == widget.idUser) {
                            currentUserPosition = index+1;
                          }
                          return Card(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text("${index + 1}. ${snapshot.data[index].username}", style: const TextStyle(fontWeight: FontWeight.w500)),
                              trailing: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${snapshot.data[index].gold} ",
                                      style: const TextStyle(color: Color(0xff272121), fontWeight: FontWeight.w500)
                                    ),
                                    const WidgetSpan(child: Icon(Icons.star, color: Colors.yellow), alignment: PlaceholderAlignment.middle),
                                  ]
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey.shade500, width: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 10),
                        child: Divider(),
                      ),
                      Consumer<UserProvider>(
                        builder: (context, provider, child) {
                          return Card(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text("$currentUserPosition. You (${provider.user.username})", style: const TextStyle(fontWeight: FontWeight.w500)),
                              trailing: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${provider.user.gold} ",
                                      style: const TextStyle(color: Color(0xff272121), fontWeight: FontWeight.w500)
                                    ),
                                    const WidgetSpan(child: Icon(Icons.star, color: Colors.yellow), alignment: PlaceholderAlignment.middle),
                                  ]
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade500, width: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  );
                } else if(snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("error");
                } else {
                  return const CircularProgressIndicator();
                }
              }
            )
          ]
        )
      )
    );
  }
}
