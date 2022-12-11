import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telegram_clone/components/credential.dart';

import '../../components/user_widget/model/user_model.dart';
import '../../home/Screens/chat/chat_view.dart';
import '../../home/home_page.dart';
import '../../services/fire_service.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

String userEmail = "";
String? userName;
String userImage = '';

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  String userEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Google"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("User Email: "), Text(userEmail)],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await signInWithGoogle();

                  setState(() {});
                },
                child: Text("Login with google")),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  userEmail = "";

                  await GoogleSignIn().signOut();
                  setState(() {});
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final OAuthCredential credential = await GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final UserCredential authCredentional =
      await FirebaseAuth.instance.signInWithCredential(credential);
  UserModel? userModel = UserModel(
      userName: googleUser.displayName.toString(),
      userCreatedDate: DateTime.now(),
      email: googleUser.email,
      id: authCredentional.user!.uid,
      password: 'No password');
  final userSavedToDatabase =
      await FireDatabaseService.saveUserToCollection(user: userModel);
  if (userModel.id != null && userSavedToDatabase!) {
    const Home_Page();
  }

  userModel = UserModel(id: authCredentional.user!.uid);
  log(credential.token.toString());
  if (authCredentional.user != null) {
    mine_creden = authCredentional;
  }

  userEmail = googleUser.email;
  userName = googleUser.displayName!;
  userImage = googleUser.photoUrl!;

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
