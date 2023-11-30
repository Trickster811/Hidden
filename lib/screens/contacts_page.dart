import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hidden/functions.dart';
import 'package:hidden/manage_db.dart';
import 'package:hidden/screens/message_page.dart';

class ContactScreen extends StatefulWidget {
  final List<List<dynamic>> menuItemList;
  final double appBarHeightSize;
  const ContactScreen({
    Key? key,
    required this.menuItemList,
    required this.appBarHeightSize,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  CollectionReference _actualites =
      FirebaseFirestore.instance.collection('User');

  late Stream<QuerySnapshot> _streamNews;
  List<QueryDocumentSnapshot> listQueryDocumentSnapshot = [];
  @override
  void initState() {
    super.initState();
    _streamNews = _actualites.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Hidden User',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 25,
            fontFamily: 'Comfortaa_bold',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {
              UsualFunctions.openDialog(
                  context, widget.menuItemList, widget.appBarHeightSize);
            },
            icon: SvgPicture.asset(
              'assets/icons/more-circle.1.svg',
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('All available contacts :'),
                SizedBox(
                  height: 10,
                ), // Secret Messages display zone __start__

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
                              userElement(
                                context,
                                HiddenUser(
                                  phone: item['phone'],
                                  username: item['username'],
                                ),
                              )
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
        ),
      ),
    );
  }

  Widget userElement(BuildContext context, HiddenUser user) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => MessageScreen(
                receiver: user.phone,
              )),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              child: SvgPicture.asset(
                'assets/icons/profile.5.svg',
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                // color: Colors.red,
                height: 50,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.username + ' (' + user.phone + ')',
                      style: TextStyle(
                        // color: kPrimaryColor,
                        fontSize: 15,
                        fontFamily: 'Comfortaa_regular',
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow-right-2.4.svg',
                      height: 20,
                      width: 20,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HiddenUser {
  final String username;
  final String phone;
  const HiddenUser({
    Key? key,
    required this.phone,
    required this.username,
  });
}
