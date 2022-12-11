import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_clone/home/home_page.dart';

import 'google_auth/google_sign_in.dart';
import 'mail_auth/sign_up.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

const countryPicker = FlCountryCodePicker(
    favorites: ['UZ'],
    favoritesIcon: Icon(
      Icons.star,
      color: Colors.orange,
    ));

class _login_pageState extends State<login_page> {
  bool? isButtonActive;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    phoneController.addListener(() {
      final isButtonActive = phoneController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  bool loading = false;
  Widget? flag;
  bool isswitch = false;
  String? nameCountry;
  String? valueChoose;
  bool len = false;
  late String codes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            color: Color(0xff007AFF),
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: Color(0xff007AFF),
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Your Phone',
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(17),
                child: SizedBox(
                  height: 38,
                  width: 250,
                  child: Text(
                    'Please confirm your country code\n    and enter your phone number.',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Divider(
                indent: 17,
                endIndent: 17,
                height: 2,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () async {
                    final code = await countryPicker.showPicker(
                      context: context,
                    );
                    if (code != null) {
                      print(code);
                      codes = code.dialCode;
                      flag = code.flagImage;
                      nameCountry = code.name;
                    }
                  },
                  child: ListTile(
                    minLeadingWidth: 50,
                    title: nameCountry == null
                        ? const Text(
                            'Select country and code',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          )
                        : Text(
                            nameCountry!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                    leading: flag,
                  ),

                  // const Text('Select country and code',
                  //     style: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
              SvgPicture.asset('assets/images/Seperator.svg'),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.center,
                    child: Text(
                      codes,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/verticalDivider.svg',
                    height: 51,
                  ),
                  SizedBox(
                    height: 45,
                    width: 263,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: TextField(
                          controller: phoneController,
                          maxLength: 9,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'Your phone number',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 17,
                endIndent: 17,
                height: 2,
                thickness: 1,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 17),
                    child: Text(
                      'Sync Contacts',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                        height: 40,
                        width: 75,
                        child: CupertinoSwitch(
                            value: isswitch,
                            onChanged: (value) {
                              setState(() {
                                isswitch = value;
                              });
                            })),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await signInWithGoogle();
                          setState(() {
                            loading = true;
                            if (userEmail != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Home_Page(),
                              ));
                            }
                            ;
                          });
                        },
                        child: Image(
                          image: const AssetImage(
                              'assets/images/google_sign_in.png'),
                          width: MediaQuery.of(context).size.width * 0.4,
                        )),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ));
                          ;
                        });
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        const Image(
                            image: AssetImage('assets/images/mail.png'),
                            height: 33),
                        Container(
                            height: 33,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(color: Colors.red
                                // color: Color.fromARGB(255, 92, 139, 178),
                                //  borderRadius: BorderRadius.circular(10)),
                                ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Sign in with Email',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ]),
                    ),
                  ]),
                ),
              ),
              loading == true
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: Lottie.asset(
                          'assets/animations/loading_login.json',
                          width: 120),
                    )
                  : SizedBox()
            ],
          ),
        ),
        floatingActionButton: isButtonActive == true
            ? Padding(
                padding: const EdgeInsets.only(),
                child: InkWell(
                  radius: 50,
                  onTap: () {
                    setState(() {
                      if (phoneController.text.length == 9) {
                        len = true;
                      } else {
                        len = false;
                        return showErrorSnackBar(context);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 35),
                    width: double.infinity,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2,
                            color: isButtonActive == true
                                ? Colors.blue
                                : const Color.fromARGB(255, 128, 127, 127))),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: isButtonActive == true
                              ? Colors.blue
                              : const Color.fromARGB(255, 128, 127, 127)),
                    ),
                  ),
                ),
              )
            : null);
  }
}

void showErrorSnackBar(BuildContext context) {
  final snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 128, 127, 127),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.error_outline,
            size: 24,
            color: Colors.white,
          ),
          Expanded(
              child: Text(
            '  Not a valid number ',
            style: TextStyle(fontSize: 20),
          ))
        ],
      ));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
