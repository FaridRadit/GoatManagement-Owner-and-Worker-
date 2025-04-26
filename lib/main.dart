import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Don't forget to import GetX
import 'package:mitrakambing2/pages/homepage.dart';
import 'package:mitrakambing2/route/routenames.dart';
import 'package:mitrakambing2/database/db_helper.dart';
import 'package:mitrakambing2/controller/controller.dart'; // Make sure the controller is imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before awaiting in main()
  Get.put(MitraController()); // Initialize the controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp instead of MaterialApp
      title: "Mitra Kambing",
      initialRoute: Routename.home,
      getPages: [
        GetPage(name: Routename.home, page: () => const Homepage()),  // Update the route definition
      ],
    );
  }
}
