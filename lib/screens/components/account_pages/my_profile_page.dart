import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfileScreen extends StatelessWidget {
  final List<String>? userInfo;
  const MyProfileScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 25,
            fontFamily: 'Comfortaa_bold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 20.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      width: double.maxFinite,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text('Personnal Informations'),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).iconTheme.color!,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Username:'),
                          Text(userInfo![0]),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).iconTheme.color!,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone'),
                          Text(userInfo![1]),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).iconTheme.color!,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Password'),
                          Text('........'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Share to receive messages',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: QrImage(
                  data: userInfo![1] + userInfo![0] + 'hidden_chat',
                  eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
                  dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
