import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppSetup {
  static Future<void> get setup async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}
