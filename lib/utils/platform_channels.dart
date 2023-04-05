import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannels {
  static const methodChannelName = "com.example.add_to_app_flutter_module/data";

  final MethodChannel methodChannel = const MethodChannel(methodChannelName);

   Future<MaterialColor> receiveFromHost(MethodCall call) async {
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

    if (jData['color'] == 'blue') {
      return Colors.blue;
    } else if (jData['color'] == 'green') {
      return Colors.green;
    } else {
      return Colors.pink;
    }
  }
}


