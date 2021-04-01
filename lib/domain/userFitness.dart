import 'package:firebase_auth/firebase_auth.dart';

class UserFitness{
  String id;
  UserFitness.fromFirebase(User user){
    id = user.uid;
  }
}