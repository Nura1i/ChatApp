import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:telegram_clone/loginPage/login_page.dart';

// GoogleSignIn? googleSignIn = GoogleSignIn(
//     clientId:
//         "321181927789-0mv8547geb45r29qej9qdp513kgkq12b.apps.googleusercontent.com",
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ]);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_page(),
    );
  }
}



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'new_messenger/views/signin.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: SignIn()

//         // FutureBuilder(
//         //   future: AuthMethods().getCurrentUser(),
//         //   builder: (context, AsyncSnapshot<dynamic> snapshot) {
//         //     if (snapshot.hasData) {
//         //       return Home();
//         //     } else {
//         //       return SignIn();
//         //     }
//         //   },
//         // ),
//         );
//   }
// }
