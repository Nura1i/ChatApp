import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram_clone/components/get_user_data.dart';

import '../contacts.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController nameController = TextEditingController(
    text: userriName,
  );
  TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: .0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.left_chevron,
                      size: MediaQuery.of(context).size.width * 0.06,
                      color: const Color(0xff007AFF),
                    ),
                    const Text(
                      'Back',
                      style: TextStyle(
                          color: Color(0xff037EE5),
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.06),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Text(
                'Done',
                style: TextStyle(
                    color: Color(0xff037EE5),
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(left: 0, right: 0, bottom: 4),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.09,
                        backgroundColor: Colors.blueGrey,
                        child: IconButton(
                            onPressed: () async {
                              // ImagePicker imagePicker = ImagePicker();
                              // XFile? file = await imagePicker.pickImage(
                              //     source: ImageSource.gallery);

                              ImagePicker.platform.getImageFromSource(
                                source: ImageSource.gallery,
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.camera_fill,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.061,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 5),
                            child: CupertinoTextField(
                              maxLength: 30,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.zero),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              placeholder: 'Name',
                              cursorColor: Colors.grey,
                              controller: nameController,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey.withOpacity(0.3),
                          width: MediaQuery.of(context).size.width * 0.74,
                          height: 1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.061,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12, left: 5),
                            child: CupertinoTextField(
                              maxLength: 30,
                              controller: lastNameController,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.zero),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              cursorColor: Colors.grey,
                              placeholder: 'Last Name',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, right: 16, left: 16),
                child: Text(
                  'Enter your name and add an optional profile photo.',
                  style: TextStyle(color: Color(0xff636366), fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Digital goodies designer - Pixsellz',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 12, right: 16, left: 16, bottom: 5),
                child: Text(
                  "Any details such as age, occupation or city.\nExample: 23 y.o. designer from San Francisco.",
                  style: TextStyle(
                      color: Color(0xff636366),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'Set Number',
                          style: TextStyle(fontSize: 17),
                        ),
                        trailing: Wrap(
                          children: [
                            Text(
                              '+998 XXXXXXX',
                              style: TextStyle(
                                  color:
                                      const Color(0xff3C3C43).withOpacity(0.6)),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              color: const Color(0xff3C3C43).withOpacity(0.3),
                              size: 17,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.withOpacity(0.3),
                      width: double.infinity,
                      height: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'UserEmail',
                          style: TextStyle(fontSize: 17),
                        ),
                        trailing: Wrap(
                          children: [
                            Text(
                              user.email.toString(),
                              style: TextStyle(
                                  color:
                                      const Color(0xff3C3C43).withOpacity(0.6)),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              color: const Color(0xff3C3C43).withOpacity(0.3),
                              size: 17,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Account',
                    style: TextStyle(
                        color: Color(0xff037EE5),
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                        color: Color(0xffFE3B30),
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
