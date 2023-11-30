import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hidden/manage_db.dart';
import 'package:intl/intl.dart';

class SubMessageScreen extends StatefulWidget {
  final String receiver;
  const SubMessageScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  State<SubMessageScreen> createState() => _SubMessageScreenState();
}

class _SubMessageScreenState extends State<SubMessageScreen> {
  int index = 0;
  // Variables to get user entries
  final myCon1 = TextEditingController();

  // Form key
  final _FormKey = GlobalKey<FormState>();
  CollectionReference _actualites =
      FirebaseFirestore.instance.collection('SubMessages');

  late Stream<QuerySnapshot> _streamNews;
  List<QueryDocumentSnapshot> listQueryDocumentSnapshot = [];
  @override
  void initState() {
    super.initState();
    _streamNews = _actualites
        .where('receiver', isEqualTo: 'widget.userInfo![1]')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Secret Message',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 25,
            fontFamily: 'Comfortaa_bold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

                    return Expanded(
                      child: Column(
                        children: [
                          for (var item in listQueryDocumentSnapshot)
                            itemBuilder(
                              SubMessage(
                                text: item['message'],
                                dateTime: item['dateTime'],
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),

            // Secret Messages display zone __end__

            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      child: TextField(
                        controller: myCon1,
                        onChanged: (String value) {
                          setState(() {
                            if (value != '') {
                              index = 1;
                            } else {
                              index = 0;
                            }
                          });
                          print(value);
                        },
                        onSubmitted: (String text) {},
                        cursorWidth: 1.0,
                        cursorColor: Theme.of(context).iconTheme.color,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.8),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000.0),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.8),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000.0),
                            ),
                            // gapPadding: 2.0,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 8.0,
                          ),
                          hintText: 'type a message',
                          hintStyle: TextStyle(
                            // color: kPrimaryColor,
                            fontFamily: 'Comfortaa_light',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        myCon1.clear();
                        index = 0;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/send.3.svg',
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(SubMessage message) {
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

class SubMessage {
  final String text;
  final Timestamp dateTime;

  const SubMessage({
    Key? key,
    required this.text,
    required this.dateTime,
  });
}
