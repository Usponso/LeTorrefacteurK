import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:torrefacteurk/entity/Seed.dart';
import 'package:torrefacteurk/providers/FieldProvider.dart';
import 'package:torrefacteurk/utils/format.dart';

class AddSeedDialog extends StatefulWidget {
  AddSeedDialog(
      {Key? key,
        required this.idUser,
        required this.idField,
      })
      : super(key: key);

  String idUser, idField;

  @override
  State<AddSeedDialog> createState() => _AddSeedDialogState();
}

class _AddSeedDialogState extends State<AddSeedDialog> {
  TextEditingController? _controller;
  String selectedValue = '';

  final List<Map<String, dynamic>> _items = [
    {
      'value': '{"name":"Arbrista","cost":6,"date":0,"duration":2400,"quantity":0.274,"gato":{"taste":87,"bitterness":4,"tenor":35,"smell":59}}',
      'label': 'Arbrista',
      'icon': Icon(Icons.coffee),
    },
    {
      'value': '{"name":"Goldoria","cost":2,"date":0,"duration":1800,"quantity":0.473,"gato":{"taste":39,"bitterness":9,"tenor":7,"smell":87}}',
      'label': 'Goldoria',
      'icon': Icon(Icons.coffee),
    },
    {
      'value': '{"name":"Roupetta","cost":3,"date":0,"duration":1200,"quantity":0.461,"gato":{"taste":35,"bitterness":41,"tenor":75,"smell":67}}',
      'label': 'Roupetta',
      'icon': Icon(Icons.coffee),
    },
    {
      'value': '{"name":"Rubisca","cost":2,"date":0,"duration":600,"quantity":0.632,"gato":{"taste":15,"bitterness":54,"tenor":35,"smell":19}}',
      'label': 'Rubisca',
      'icon': Icon(Icons.coffee),
    },
    {
      'value': '{"name":"Tourista","cost":1,"date":0,"duration":60,"quantity":0.961,"gato":{"taste":3,"bitterness":91,"tenor":74,"smell":6}}',
      'label': 'Tourista',
      'icon': Icon(Icons.coffee),
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: '2');
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.deepPurple[50],
        icon: const Icon(Icons.grass, color: Color(0xff766c42)),
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
            child: Text(
              "Plant coffee",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectFormField(
                type: SelectFormFieldType.dialog,
                controller: _controller,
                //initialValue: _initialValue,
                icon: Icon(Icons.format_shapes),
                labelText: 'Shape',
                changeIcon: true,
                dialogTitle: 'Pick a item',
                dialogCancelBtn: 'CANCEL',
                enableSearch: true,
                dialogSearchHint: 'Search item',
                items: _items,
                onChanged: (val) => setState(() => selectedValue = val),
              ),
              if(selectedValue != "")
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RichText(text: TextSpan(
                            children: [
                              const WidgetSpan(child: Icon(Icons.diamond, color: Colors.green), alignment: PlaceholderAlignment.middle),
                              TextSpan(
                                  text: " ${json.decode(selectedValue)['cost']} DeeVee",
                                  style: const TextStyle(color: Colors.black)
                              )
                            ],
                          )),
                          Spacer(),
                          RichText(text: TextSpan(
                            children: [
                              const WidgetSpan(child: Icon(Icons.grass, color: Colors.lightGreen), alignment: PlaceholderAlignment.middle),
                              TextSpan(
                                  text: " ${json.decode(selectedValue)['quantity']} Kg",
                                  style: const TextStyle(color: Colors.black)
                              )
                            ],
                          )),
                          Spacer(),
                          RichText(text: TextSpan(
                            children: [
                              const WidgetSpan(child: Icon(Icons.timer, color: Color(0xff766c42)), alignment: PlaceholderAlignment.middle),
                              TextSpan(
                                  text: " ${formattedTime(json.decode(selectedValue)['duration'])}",
                                  style: const TextStyle(color: Colors.black)
                              )
                            ],
                          )),

                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
          ),

          TextButton(
              onPressed: () {
                Provider.of<FieldProvider>(context, listen: false)
                    .postSeed(context, widget.idUser, widget.idField, Seed.fromJson(json.decode(selectedValue)));
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
