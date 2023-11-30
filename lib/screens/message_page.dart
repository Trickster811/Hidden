import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hidden/manage_db.dart';

class MessageScreen extends StatefulWidget {
  final String receiver;
  const MessageScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Variables to get user entries
  final myCon1 = TextEditingController();

  // Form key
  final _FormKey = GlobalKey<FormState>();

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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Message To'),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.receiver,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Form(
                key: _FormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),

                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(5, 35, 61, 1),
                          ),
                          cursorColor: Color.fromRGBO(5, 35, 61, 1),
                          maxLines: 10,
                          decoration: InputDecoration(
                            icon: SvgPicture.asset(
                              'assets/icons/message.6.svg',
                              color: Color.fromRGBO(5, 35, 61, 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 223, 223, 223),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(5, 35, 61, 1),
                              ),
                            ),
                            hintText: 'enter your username',
                          ),
                          // value: dropdownvalue_1,
                          controller: myCon1,
                          onChanged: (text) {},
                          validator: RequiredValidator(
                            errorText: 'Please enter your username',
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    // Submit Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(5, 35, 61, 1),
                          borderRadius: BorderRadius.circular(10000),
                        ),
                        width: double.maxFinite,
                        child: InkWell(
                          onTap: () async {
                            if (_FormKey.currentState!.validate()) {
                              try {
                                // final password = EncryptionSalsa20
                                //     .encryptSalsa20(my_con_2.text);
                                final userInputs = [
                                  myCon1.text,
                                  widget.receiver,
                                  DateTime.now()
                                ];

                                Messages.createMessages(userInputs);

                                // storeNotificationToken(userInputs);

                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    title: Text(
                                      'Succes!!',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'ArialRoundedBold',
                                      ),
                                    ),
                                    message: Text(
                                      'Your message have been well send to ${widget.receiver}.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'ArialRoundedBold',
                                      ),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        // onPressed: () => imageGallerypicker(ImageSource.camera, context),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Go to the Login page
                                        },
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'ArialRoundedBold',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } catch (e) {
                                // print(e);
                                return showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    title: Text(
                                      'Error!!',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14,
                                        fontFamily: 'ArialRoundedBold',
                                      ),
                                    ),
                                    message: Text(
                                      'Sorry some error occured.\nPlease retry.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'ArialRoundedBold',
                                      ),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        // onPressed: () => imageGallerypicker(ImageSource.camera, context),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
