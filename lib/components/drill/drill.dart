import 'package:fitness/domain/workout.dart';
import 'package:flutter/material.dart';


class Drill extends StatelessWidget {
  final bool isSingleDrill;
  final int drillBlockIndex;
  final int index;
  final WorkoutDrill drill;

  Drill({Key key, this.drillBlockIndex, this.index, this.isSingleDrill, this.drill}) : super(key: key);

  isNumeric(string) => string != null && int.tryParse(string.toString().trim()) != null;
  cleanInt(string) => int.parse(string.toString().trim());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 4, right: 4),
        decoration: BoxDecoration(color: Colors.white54),
        child: Column(
          children: <Widget>[

              ],
            ),

        )
    );
  }
}
