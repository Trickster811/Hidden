import 'package:cloud_firestore/cloud_firestore.dart';

final firebase = FirebaseFirestore.instance;

class User {
  // create
  static createUser(data) async {
    try {
      FirebaseFirestore.instance.collection('User').doc(data[1]).set({
        'username': data[0],
        'phone': data[1],
        'password': data[2],
      });
    } catch (e) {
      print(e);
    }
  }

  // update
  static updateUser(data) async {
    try {
      firebase.collection('User').doc(data[1]).update({
        'username': data[0],
        'phone': data[1],
        'password': data[2],
      });
    } catch (e) {
      print(e);
    }
  }

  // delete
  static deleteUser(data) async {
    try {
      firebase.collection('User').doc(data[0]).delete();
    } catch (e) {
      print(e);
    }
  }
}

class Messages {
  // create
  static createMessages(data) async {
    try {
      FirebaseFirestore.instance.collection('Messages').doc(data[0]).set({
        'message': data[0],
        'sender': data[1],
        'receiver': data[2],
        'dateTime': data[3],
      });
    } catch (e) {
      print(e);
    }
  }

  // update
  static updateMessages(data) async {
    try {
      firebase.collection('Messages').doc(data[0]).update({
        'message': data[0],
        'sender': data[1],
        'receiver': data[2],
        'dateTime': data[3],
      });
    } catch (e) {
      print(e);
    }
  }

  // delete
  static deleteMessages(data) async {
    try {
      firebase.collection('Messages').doc(data[0]).delete();
    } catch (e) {
      print(e);
    }
  }
}

class SubMessages {
  // create
  static createSubMessages(data) async {
    try {
      FirebaseFirestore.instance.collection('SubMessages').doc(data[0]).set({
        'message': data[0],
        'id': data[1],
        'receiver': data[2],
        'dateTime': data[3],
      });
    } catch (e) {
      print(e);
    }
  }

  // update
  static updateSubMessages(data) async {
    try {
      firebase.collection('SubMessages').doc(data[0]).update({
        'message': data[0],
        'receiver': data[1],
        'dateTime': data[2],
      });
    } catch (e) {
      print(e);
    }
  }

  // delete
  static deleteSubMessages(data) async {
    try {
      firebase.collection('SubMessages').doc(data[0]).delete();
    } catch (e) {
      print(e);
    }
  }
}
