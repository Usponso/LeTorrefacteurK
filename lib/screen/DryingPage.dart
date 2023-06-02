import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';
import 'package:torrefacteurk/widgets/dialog/AddDryTaskDialog.dart';
import 'package:torrefacteurk/entity/UserStock.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class DryingPage extends StatefulWidget {
  const DryingPage({Key? key, required this.idUser}) : super(key: key);
  final String idUser;

  @override
  State<DryingPage> createState() => _DryingPageState();
}

class _DryingPageState extends State<DryingPage> {
  late CountdownTimerController controller;
  int endTime = 0;

  Future<bool> getUser(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).getUser(widget.idUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff766c42),
              onPressed: () => addDryingTaskDialog(context, provider.user.stockDried),
              child: const Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future: getUser(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 10),
                              child: Text("Dry coffee",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Card(
                                      child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 6,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Text("Ar (d)"),
                                              Text((provider.user
                                                  .stockDried.arbrista
                                                  .toStringAsFixed(3)))
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  const Spacer(),
                                  Card(
                                      child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 6,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Text("Go (d)"),
                                              Text(provider.user
                                                  .stockDried.goldoria
                                                  .toStringAsFixed(3))
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  const Spacer(),
                                  Card(
                                      child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 6,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Text("Ro (d)"),
                                              Text(provider.user
                                                  .stockDried.roupetta
                                                  .toStringAsFixed(3))
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  const Spacer(),
                                  Card(
                                      child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 6,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Text("Ru (d)"),
                                              Text(provider.user
                                                  .stockDried.rubisca
                                                  .toStringAsFixed(3))
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  const Spacer(),
                                  Card(
                                    child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 6,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text("To (d)"),
                                            Text(provider.user
                                              .stockDried.tourista
                                              .toStringAsFixed(3))
                                          ],
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: provider.user.drying.length,
                              itemBuilder: (context, index) {
                                if(index < provider.user.drying.length) {
                                  endTime = provider.user.drying[index].date;
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
                                              children: [
                                                Text("${provider.user.drying[index].type} - ${provider.user.drying[index].quantity}"),
                                                CountdownTimer(
                                                  controller: controller,
                                                  endTime: endTime,
                                                  endWidget: ElevatedButton(
                                                    // todo: create function to collect dried coffee on ended
                                                    onPressed: () => {},
                                                    child: Text("Collect"),
                                                  ),
                                                ),
                                              ]
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
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Text("error");
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addDryingTaskDialog(BuildContext context, UserStock stockDried) {
    showDialog(
      context: context,
      builder: (context) {
        return AddDryTaskDialog(idUser: widget.idUser, stockDry: stockDried);
      },
    );
  }
}
