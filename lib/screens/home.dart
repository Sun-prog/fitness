
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness/components/activeWorkouts.dart';
import 'package:fitness/components/workouts-list-origin.dart';
import 'package:fitness/domain/workout.dart';
import 'package:fitness/services/auth.dart';
import 'package:flutter/material.dart';

import 'add-workout.dart';


class HomePage extends StatefulWidget {
  // const HomePage ({Key key}):super(key:key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context){
    var navigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      index: 0,
      height: 47,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.35),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() {
          sectionIndex = index;
        });
      },
    );
    return new Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(title: Text("Fitfit" + (sectionIndex == 0 ? 'Active Workouts': "Find Workouts")),
          leading: Icon(Icons.fitness_center),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                AuthService().logOut();
              },
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              label: SizedBox.shrink())
        ],
        ),
          body: sectionIndex ==0 ?ActiveWorkouts() : WorkoutsList(),
          bottomNavigationBar: navigationBar,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                 AddWorkout()));
            },
          )

    /*bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:Icon(Icons.fitness_center),
              title:Text("My workouts")
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.fitness_center),
                title:Text("Find workouts")
            )
          ],
          backgroundColor: Colors.white30,
          currentIndex: sectionIndex,
          selectedItemColor: Colors.white,
          onTap: (int index){
            setState(()=>sectionIndex = index);
          },
        ),

         */
      ),
    );
  }
}

