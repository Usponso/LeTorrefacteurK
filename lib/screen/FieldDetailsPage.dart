import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:torrefacteurk/providers/FieldProvider.dart';
import 'package:provider/provider.dart';
import 'package:torrefacteurk/widgets/dialog/AddSeedDialog.dart';

import '../utils/materialColorFromHex.dart';

class FieldDetailsPage extends StatefulWidget {
  const FieldDetailsPage({Key? key, required this.idUser, required this.idField, required this.nameField, required this.specification}) : super(key: key);
  final String idUser;
  final String idField;
  final String nameField;
  final String specification;

  @override
  State<FieldDetailsPage> createState() => _FieldDetailsPageState();
}

class _FieldDetailsPageState extends State<FieldDetailsPage> {
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  Future<bool> getSeeds(BuildContext context) async {
    await Provider.of<FieldProvider>(context, listen: false).getSeeds(widget.idUser,widget.idField);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameField),
        backgroundColor: MaterialColor(0xff766c42, color),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.grey.shade500, width: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 20),
                leading: Icon(Icons.yard, color: MaterialColor(0xff766c42, color)),
                title: Text(
                  widget.nameField,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("SPECIFICATION : ${widget.specification}"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(color: Colors.grey,),
            ),
            FutureBuilder(
              future: getSeeds(context),
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return Consumer<FieldProvider>(
                    builder: (context, provider, child) {
                      return GridView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          if(index < provider.seeds.length) {
                            endTime = provider.seeds[index].date;
                            controller = CountdownTimerController(endTime: endTime);
                          }
                          return Card(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: index < provider.seeds.length ? [
                                        Text(provider.seeds[index].name),
                                        CountdownTimer(
                                          controller: controller,
                                          endTime: endTime,
                                          endWidget: ElevatedButton(
                                            onPressed: () => provider.collectSeed(context, widget.idUser, provider.seeds[index], widget.idField),
                                            child: Text("Collect"),
                                          ),
                                        ),
                                      ]
                                      : [
                                        const Text("EMPTY"),
                                        ElevatedButton(
                                          onPressed: () => addSeedDialog(context),
                                          child: Icon(Icons.add)
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 5,
                        ),
                      );
                    }
                  );
                } else if(snapshot.hasError){
                  print(snapshot.error);
                  return const Text("error");
                } else{
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      )
    );
  }

  void addSeedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddSeedDialog(idUser: widget.idUser, idField: widget.idField);
      },
    );
  }
}
