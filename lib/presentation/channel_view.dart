import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelView extends StatefulWidget {
  const ChannelView({super.key});

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  static const platform = MethodChannel('com.apptoapp.upc/data');

  @override
  void initState() {
    print("Init state");
    platform.setMethodCallHandler(_receiveFromHost);
    super.initState();
  }
// main.dart

  dynamic jData1 = {"idUser": "", "token": ""};

  Future<void> _receiveFromHost(MethodCall call) async {
    var jData;

    try {
      print(call.method);

      if (call.method == "fromHostToClient") {
        final String data = call.arguments;
        print(call.arguments);
        jData = await jsonDecode(data);
      }
    } on PlatformException catch (error) {
      print(error);
    }

    setState(() {
      jData1 = jData;
      if (jData['color'] == 'blue') {
        color = Colors.blue;
      } else if (jData['color'] == 'green') {
        color = Colors.green;
      } else {
        color = Colors.pink;
      }
    });
  }

  Color color = Colors.brown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Your Data Example',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "COD: ${jData1['idUser']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                jData1['token'].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
