import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? password;

  UserModel(this.id, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'password': password};
  }

  UserModel.fromDocumentSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    id = documentSnapshot.id;
    email = documentSnapshot.data()!['email'];
    password = documentSnapshot.data()!['password'];
  }
}
