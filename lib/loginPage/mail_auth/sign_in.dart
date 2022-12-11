import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:telegram_clone/home/home_page.dart';
import 'package:telegram_clone/loginPage/mail_auth/sign_up.dart';

import '../../components/credential.dart';
import '../../home/Screens/chat/chat_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

String? mail;

class _SignInViewState extends State<SignInView> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  void get signIn async {
    try {
      if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) {
        return;
      }

      final UserCredential credentionall =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      setState(() {
        // mail = controllerEmail.text;
        mail = FirebaseAuth.instance.currentUser!.email;
      });

      if (credentionall.user != null) {
        mine_creden = credentionall;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home_Page()),
            (route) => false);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // void signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     GoogleSignInAccount? account = await googleSignIn!.signIn();
  //     GoogleSignInAuthentication? googleAuth = await account!.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential credentional =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: controllerEmail.text,
  //       password: controllerPassword.text,
  //     );

  //     final UserCredential authCredentional =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     log(credential.token.toString());
  //     if (credentional.user != null) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (context) => HomePage(
  //                     userCredential: authCredentional,
  //                   )),
  //           (route) => false);
  //     }
  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage('assets/images/circle_sign.png'),
                    fit: BoxFit.cover,
                    width: 155,
                    height: 155,
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(
                          image: AssetImage('assets/images/mail_login.png'),
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const Text(
                        'Enter your email and password',
                        style:
                            TextStyle(color: Color(0XffA8A6A7), fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          cursorColor: Colors.blue.shade900,
                          controller: controllerEmail,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                              ),
                              hintText: ' Email',
                              hintStyle:
                                  const TextStyle(color: Color(0XffA8A6A7))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          cursorColor: Colors.blue.shade900,
                          // cursorColor: Colors.black,
                          controller: controllerPassword,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade900),
                              ),
                              hintText: ' Password',
                              hintStyle:
                                  const TextStyle(color: Color(0XffA8A6A7))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: GestureDetector(
                          onTap: () {
                            signIn;
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.92,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpView(),
                              ),
                              (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Dont have an acount?'),
                            Text(
                              '  Sign Up',
                              style: TextStyle(
                                  color: Color(0xffD87234),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ])));
  }
}
