import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_lane_optimization_app/admin/adminPage.dart';
import 'package:dsc_lane_optimization_app/dscLaneOptApp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart'; // Import provider

import 'provider/client_provider.dart'; // Import the ClientProvider class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ClientProvider(), // Initialize ClientProvider
      child: MyApp(), // Wrap your app with ChangeNotifierProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSC Emergency Lane Optimization',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 19, 90, 128)),
        useMaterial3: true,
      ),
      home: Consumer<ClientProvider>(
        builder: (context, clientProvider, _) {
          return clientProvider.client == 'user'
              ? DscLaneOptApp(title: 'Dsc LaneOpt') // Show user page
              : Adminpage(); // Show admin page
        },
      ),
    );
  }
}
