import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:torrefacteurk/entity/DryingPlant.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';
import 'package:torrefacteurk/entity/UserStock.dart';
import 'package:torrefacteurk/utils/format.dart';

class AddDryTaskDialog extends StatefulWidget {
  AddDryTaskDialog(
      {Key? key,
        required this.idUser,
        required this.stockDry
      })
      : super(key: key);

  String idUser;
  UserStock stockDry;

  @override
  State<AddDryTaskDialog> createState() => _AddDryTaskDialogState();
}

class _AddDryTaskDialogState extends State<AddDryTaskDialog> {
  TextEditingController? _controller;
  String selectedValue = '';
  DryingPlant toDry = DryingPlant(type: "", date: 0, duration: 0, quantity: 0);
  double quantityToDry = 0.0;

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'arbrista',
      'label': 'Arbrista',
      'icon': const Icon(Icons.coffee),
    },
    {
      'value': 'goldoria',
      'label': 'Goldoria',
      'icon': const Icon(Icons.coffee),
    },
    {
      'value': 'roupetta',
      'label': 'Roupetta',
      'icon': const Icon(Icons.coffee),
    },
    {
      'value': 'rubisca',
      'label': 'Rubisca',
      'icon': const Icon(Icons.coffee),
    },
    {
      'value': 'tourista',
      'label': 'Tourista',
      'icon': const Icon(Icons.coffee),
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
        icon: const Icon(Icons.dry, color: Color(0xff766c42)),
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text(
            "Dry coffee",
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
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.deny(new RegExp('[A-Za-z]'))
                      ],
                      onChanged: (newValue) {
                        if(isNumeric(newValue)) {
                          quantityToDry = double.parse(newValue);
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Quantity to dry",
                      ),
                    ),
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
            child: const Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),

          TextButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .addDryingTask(context, widget.idUser, DryingPlant(type: selectedValue, date: DateTime.now().millisecondsSinceEpoch + (600*quantityToDry~/0.1*1000), duration: 600*quantityToDry~/0.1, quantity: quantityToDry, id: "id-123")); //add dryingplant object
              Navigator.pop(context);
            },
            child: const Text(
              "Dry",
              style: TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            )),
        ],
      ),
    );
  }
}
