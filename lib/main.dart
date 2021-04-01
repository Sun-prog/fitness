import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/domain/workout.dart';
import 'package:fitness/screens/auth.dart';
import 'package:fitness/screens/home.dart';
import 'package:fitness/screens/landing.dart';
import 'package:fitness/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// урок https://www.youtube.com/watch?v=yS6TRvCmCxg&list=PLu_62Q68DvTpWKx289HnZq7_19e84vSpr&index=1
// context - определяет место в иерархии виджетов
 //void main() => runApp(MaxFitApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaxFitApp());
}

 class MaxFitApp extends StatelessWidget{
   @override
   Widget build(BuildContext context){
     return StreamProvider<User>.value(
       value: AuthService().currentUser,
       child: MaterialApp(
       title: "Fitness",
       theme: ThemeData(
         primaryColor: Color.fromRGBO(50,65,85,1),
         textTheme: TextTheme(title: TextStyle(color: Colors.white70))
       ),
       home:LandingPage(),
     )
     );
   }



 }
