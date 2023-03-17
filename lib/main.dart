import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 216, 222, 255),
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: 800,
        child: SingleChildScrollView(
          child: WallLayout(
            layersCount: 8,
            stones: List.generate(
                11,
                (index) => index == 1
                    ? Stone(
                        id: index,
                        width: 4,
                        height: 4,
                        child: const SizedBox.shrink())
                    : Stone(
                        id: index,
                        width: 4,
                        height: 7,
                        child: LayoutBuilder(builder: (context, constraint) {
                          final newindex = index > 1 ? index - 1 : index;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(flex: 1),
                              Container(
                                width: constraint.maxWidth * 0.5,
                                height: constraint.maxWidth * 0.5,
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.star_outlined,
                                    size: constraint.maxWidth * 0.32),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nivel ${newindex + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Intégrate a las\nactividades culturales'
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18)),
                              ),
                              const Spacer(flex: 3),
                            ],
                          );
                        }))),
          ),
        ),
      ),
    );
  }

  Color getRandomColor(int index) {
    Random random = Random(index);
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
