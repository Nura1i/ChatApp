import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:telegram_clone/home/home_page.dart';

import 'package:telegram_clone/loginPage/mail_auth/sign_in.dart';

import '../../components/credential.dart';
import '../../components/user_widget/model/user_model.dart';

import '../../services/fire_service.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

String? username;

class _SignUpViewState extends State<SignUpView> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmation = TextEditingController();

  void get signUp async {
    try {
      if (controllerEmail.text.isEmpty ||
          controllerPassword.text.isEmpty ||
          controllerUsername.text.isEmpty ||
          controllerConfirmation.text.isEmpty) return;

      if (controllerConfirmation.text != controllerPassword.text) return;
      final UserCredential credentional = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text);
      assert(credentional.user != null);
      setState(() {
        username = controllerUsername.text;
      });

      UserModel? userModel = UserModel(
          id: credentional.user!.uid,
          userName: controllerUsername.text,
          userCreatedDate: DateTime.now(),
          email: controllerEmail.text,
          password: controllerPassword.text);

      final userSavedToDatabase =
          await FireDatabaseService.saveUserToCollection(user: userModel);
      if (credentional.user != null && userSavedToDatabase!) {
        setState(() {
          mine_creden = credentional;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home_Page()),
              (route) => false);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        'Sign Up',
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
                      'First creat your account',
                      style: TextStyle(color: Color(0XffA8A6A7), fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        cursorColor: Colors.blue.shade900,
                        controller: controllerUsername,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade900),
                            ),
                            hintText: ' Full name',
                            hintStyle:
                                const TextStyle(color: Color(0XffA8A6A7))),
                      ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        cursorColor: Colors.blue.shade900,
                        controller: controllerConfirmation,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade900),
                            ),
                            hintText: ' Confirm password',
                            hintStyle:
                                const TextStyle(color: Color(0XffA8A6A7))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: GestureDetector(
                        onTap: () {
                          signUp;
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFF222222),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'SIGN UP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInView(),
                            ),
                            (route) => false);
                        ;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Already have an account?'),
                          Text(
                            '  Login',
                            style: TextStyle(
                                color: Color(0xffD87234),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )

                    // CupertinoButton.filled(
                    //     child: const Text('sign up'), onPressed: () => signUp),
                    // CupertinoButton(
                    //     child: const Text('sign in'),
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => const Home_Page()));
                    //     })
                  ],
                ),
              ])),
    );
  }
}
