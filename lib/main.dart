import 'package:first_app/products/views/ggg.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationController().init();
  runApp(const MyApp());
}

// use statelesswidget

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageScreen(),
    );
  }
}
