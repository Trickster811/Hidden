import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidden/screens/components/scan_page.dart';
import 'package:hidden/screens/contacts_page.dart';
import 'package:hidden/screens/secret_chat_pages.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final List<List<dynamic>> menuItemList;
  final List<String>? userInfo;
  final double appBarHeightSize;
  const ChatScreen({
    Key? key,
    required this.appBarHeightSize,
    required this.userInfo,
    required this.menuItemList,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final inputController = TextEditingController();

  int index = 0;

  CollectionReference _actualites =
      FirebaseFirestore.instance.collection('Messages');

  late Stream<QuerySnapshot> _streamNews;
  List<QueryDocumentSnapshot> listQueryDocumentSnapshot = [];
  @override
  void initState() {
    super.initState();
    _streamNews = _actualites
        .where('receiver', isEqualTo: widget.userInfo![1])
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactScreen(
                        menuItemList: widget.menuItemList,
                        appBarHeightSize: widget.appBarHeightSize),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5.0),
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'New Secret Message',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/chat.5.svg',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Secret Messages display zone __start__

            StreamBuilder<QuerySnapshot>(
              stream: _streamNews,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Some error occured!'),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    QuerySnapshot querySnapshot = snapshot.data;
                    // print(querySnapshot.docs[0]['titre']);

                    listQueryDocumentSnapshot.addAll(querySnapshot.docs);

                    return Column(
                      children: [
                        for (var item in listQueryDocumentSnapshot)
                          itemBuilder(
                            Message(
                              text: item['message'],
                              dateTime: item['dateTime'],
                            ),
                          ),
                      ],
                    );
                  }
                }
              },
            ),

            // Secret Messages display zone __end__
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(Message message) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '${DateFormat('yyyy-MM-dd H:m:s').format(message.dateTime.toDate())}',
            style: TextStyle(
              fontFamily: 'Comfortaa_bold',
              fontSize: 9,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/message.6.svg',
                        color: Theme.of(context).iconTheme.color,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubMessageScreen(
                              receiver: message.text,
                            ),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).iconTheme.color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Text(
                            'Reply',
                            style: TextStyle(
                              fontFamily: 'Comfortaa_bold',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Message',
                  style: TextStyle(
                    fontFamily: 'Comfortaa_bold',
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontFamily: 'Comfortaa_regular',
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 8.0,
                ),
                margin: EdgeInsets.only(
                  top: 8.0,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: Text(
                  'Hidden Chat',
                  style: TextStyle(
                    fontFamily: 'Comfortaa_bold',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Message {
  final String text;
  final Timestamp dateTime;

  const Message({
    Key? key,
    required this.text,
    required this.dateTime,
  });
}
