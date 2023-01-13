import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

// use statelesswidget

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

// Screen Mobile App
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apptitle = 'Mobile App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(apptitle),
        actions: const [Icon(Icons.notifications)],
      ),
      body: Row(
        children: [
          CupertinoButton(
              onPressed: () async {
                try {
                  await TorchLight.enableTorch();
                } on Exception catch (_) {
                  // Handle error
                }
              },
              child: const Text('Open')),
          CupertinoButton(
              onPressed: () async {
                try {
                  await TorchLight.disableTorch();
                } on Exception catch (_) {
                  // Handle error
                }
              },
              child: const Text('Close'))
        ],
      ),
    );
  }
}
