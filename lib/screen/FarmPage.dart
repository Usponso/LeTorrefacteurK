import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';
import 'package:torrefacteurk/screen/FieldDetailsPage.dart';

import '../utils/materialColorFromHex.dart';

class FarmPage extends StatefulWidget {
  const FarmPage({Key? key, required this.idUser}) : super(key: key);
  final String idUser;

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  Future<bool> getUser(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).getUser(widget.idUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getUser(context),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  return Consumer<UserProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/2.5,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(alignment: PlaceholderAlignment.middle,child: Icon(Icons.diamond, color: Colors.green)),
                                              TextSpan(text: " ${provider.user.wallet} DeeVee", style: TextStyle(color: Color(0xff272121)))
                                            ]
                                          ),
                                        ),
                                      ),
                                    )
                                  ),
                                  Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/2.5,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(alignment: PlaceholderAlignment.middle,child: Icon(Icons.star, color: Colors.yellow)),
                                              TextSpan(text: " ${provider.user.gold} ${provider.user.gold <= 0 ? 'gold':'golds'}", style: TextStyle(color: Color(0xff272121)))
                                            ]
                                          ),
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [Text("Ar"),Text((provider.user.stock.arbrista.toStringAsFixed(3)))],
                                        ),
                                      ),
                                    )
                                  ),
                                  Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [Text("Go"),Text(provider.user.stock.goldoria.toStringAsFixed(3))],
                                        ),
                                      ),
                                    )
                                  ),
                                  Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [Text("Ro"),Text(provider.user.stock.roupetta.toStringAsFixed(3))],
                                        ),
                                      ),
                                    )
                                  ),
                                  Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [Text("Ru"),Text(provider.user.stock.rubisca.toStringAsFixed(3))],
                                        ),
                                      ),
                                    )
                                  ),
                                  Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [Text("To"),Text(provider.user.stock.tourista.toStringAsFixed(3))],
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: provider.user.farm.fields.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FieldDetailsPage(idUser: widget.idUser,idField: provider.user.farm.fields[index].id.toString(), nameField: provider.user.farm.fields[index].name,specification: provider.user.farm.fields[index].specification)));
                                    },
                                    leading: Icon(Icons.yard, color: MaterialColor(0xff766c42, color)),
                                    title: Text(provider.user.farm.fields[index].name),
                                    subtitle: Text("SPECIFICATION : ${provider.user.farm.fields[index].specification}"),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey.shade500, width: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              }
                            )
                          ]
                        );
                      }
                    );
                } else if(snapshot.hasError){
                  print(snapshot.error);
                  return const Text("error");
                } else{
                  return const CircularProgressIndicator();
                }
              }
            )
          ],
        )
      ),
    );
  }
}
