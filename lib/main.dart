import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/portfolio.dart';
import 'package:portfolio/view/desktop/projects.dart';
import 'package:portfolio/view/model/navbarstate_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBSlrVZQnPKvgGrxBpPIeBaTlS8w5kesIE",
        authDomain: "portfolio-my-20e16.firebaseapp.com",
        projectId: "portfolio-my-20e16",
        storageBucket: "portfolio-my-20e16.firebasestorage.app",
        messagingSenderId: "387554507827",
        appId: "1:387554507827:web:208cb0048e0881344db746"),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavBarStateModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Portfolio(),
      ),
    );
  }
}
