import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../new_messenger/services/database.dart';
import '../new_messenger/views/chatscreen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _MyAppState();
}

class _MyAppState extends State<SearchPage> {
  String username = "";

  // Stream? usersStream;
  // Widget searchUsersList() {
  //   return StreamBuilder(
  //     stream: usersStream,
  //     builder: (context, snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //               itemCount: snapshot.data.docs.length,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot ds = snapshot.data.docs[index];
  //                 return searchListUserTile(
  //                     username: ds["userusername"],
  //                     email: ds["email"],
  //                     userusername: ds["userusername"]);
  //               },
  //             )
  //           : const Center(
  //               child: CupertinoActivityIndicator(),
  //             );
  //     },
  //   );
  // }

  // List<Map<String, dynamic>> data = [
  //   {
  //     'username': 'John',
  //     'image':
  //         'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
  //     'email': 'john@gmail.com'
  //   },
  //   {
  //     'username': 'Eric',
  //     'image':
  //         'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
  //     'email': 'eric@gmail.com'
  //   },
  //   {
  //     'username': 'Mark',
  //     'image':
  //         'https://i.picsum.photos/id/449/200/300.jpg?grayscale&hmac=GcAk7XLOGeBrqzrEpBjAzBcZFJ9bvyMwvL1QENQ23Zc',
  //     'email': 'mark@gmail.com'
  //   },
  //   {
  //     'username': 'Ela',
  //     'image':
  //         'https://i.picsum.photos/id/3/200/300.jpg?blur=2&hmac=CgtEzNwC4BLEa1z5r0oGOsZPj5wJlqjU615MLuFillY',
  //     'email': 'ela@gmail.com'
  //   },
  //   {
  //     'username': 'Sue',
  //     'image':
  //         'https://i.picsum.photos/id/497/200/300.jpg?hmac=IqTAOsl408FW-5QME1woScOoZJvq246UqZGGR9UkkkY',
  //     'email': 'sue@gmail.com'
  //   },
  //   {
  //     'username': 'Lothe',
  //     'image':
  //         'https://i.picsum.photos/id/450/200/300.jpg?hmac=EAnz3Z3i5qXfaz54l0aegp_-5oN4HTwiZG828ZGD7GM',
  //     'email': 'lothe@gmail.com'
  //   },
  //   {
  //     'username': 'Alyssa',
  //     'image':
  //         'https://i.picsum.photos/id/169/200/200.jpg?hmac=MquoCIcsCP_IxfteFmd8LfVF7NCoRre282nO9gVD0Yc',
  //     'email': 'Alyssa@gmail.com'
  //   },
  //   {
  //     'username': 'Nichols',
  //     'image':
  //         'https://i.picsum.photos/id/921/200/200.jpg?hmac=6pwJUhec4NqIAFxrha-8WXGa8yI1pJXKEYCWMSHroSU',
  //     'email': 'Nichols@gmail.com'
  //   },
  //   {
  //     'username': 'Welch',
  //     'image':
  //         'https://i.picsum.photos/id/845/200/200.jpg?hmac=KMGSD70gM0xozvpzPM3kHIwwA2TRlVQ6d2dLW_b1vDQ',
  //     'email': 'Welch@gmail.com'
  //   },
  //   {
  //     'username': 'Delacruz',
  //     'image':
  //         'https://i.picsum.photos/id/250/200/200.jpg?hmac=23TaEG1txY5qYZ70amm2sUf0GYKo4v7yIbN9ooyqWzs',
  //     'email': 'Delacruz@gmail.com'
  //   },
  //   {
  //     'username': 'Tania',
  //     'image':
  //         'https://i.picsum.photos/id/237/200/200.jpg?hmac=zHUGikXUDyLCCmvyww1izLK3R3k8oRYBRiTizZEdyfI',
  //     'email': 'Tania@gmail.com'
  //   },
  //   {
  //     'username': 'Jeanie',
  //     'image':
  //         'https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU',
  //     'email': 'Jeanie@gmail.com'
  //   }
  // ];

  // addData() async {
  //   for (var element in data) {
  //     FirebaseFirestore.instance.collection('users').add(element);
  //   }
  //   print('all data added');
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   addData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
        )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (username.isEmpty) {
                        return ListTile(
                          title: Text(
                            data['username'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        );
                      }
                      if (data['username']
                          .toString()
                          .toLowerCase()
                          .startsWith(username.toLowerCase())) {
                        return ListTile(
                          title: Text(
                            data['username'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(data['image']),
                          // ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}

// Widget searchListUserTile({String? username, userusername, email}) {
//   return GestureDetector(
    // onTap: () {
    //   var chatRoomId = getChatRoomIdByUserusernames(myUserusername, userusername);
    //   Map<String, dynamic> chatRoomInfoMap = {
    //     "users": [myUserusername, userusername]
    //   };
    //   DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ChatScreen(userusername, username!)));
    // },




//     child: Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(40),
//             // child: Image.network(
//             //   profileUrl!,
//             //   height: 40,
//             //   width: 40,
//             // ),
//           ),
//           const SizedBox(width: 12),
//           Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [const Text('no'), Text(email)])
//         ],
//       ),
//     ),
//   );
// }
