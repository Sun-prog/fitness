import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/domain/userFitness.dart';

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserFitness> signInWithEmailAndPassword (String email, String password)  async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: deprecated_member_use
      User firebaseUser = result.user;
      var user =  UserFitness.fromFirebase(firebaseUser);
      return user;

    }
    catch(e){
      print(e);
      return null;
    }
}

  Future<UserFitness> registerInWithEmailAndPassword (String email, String password)  async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      // ignore: deprecated_member_use
      User firebaseUser = result.user;

      //надо вот это попробовать - https://firebase.flutter.dev/docs/auth/usage/
      //User user1 = _fAuth.currentUser;
      var user =  UserFitness.fromFirebase(firebaseUser);
      return user;

    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }


  Stream<User> get currentUser {
   /* return _fAuth.onAuthStateChanged
        .map((FirebaseUser user) => user != null
        ? User.fromFirebase(user)
        : null); */
    User user = FirebaseAuth.instance.currentUser;
    return FirebaseAuth.instance
        .authStateChanges()
        ;
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}