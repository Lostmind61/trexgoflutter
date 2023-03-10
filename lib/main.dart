import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'kayitekrani.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: kayitdeneme(),
  ));
}

class kayitdeneme extends StatelessWidget {
  const kayitdeneme({super.key});

  @override
  Widget build(BuildContext context) {
    return const kayitekrani();
  }
}
