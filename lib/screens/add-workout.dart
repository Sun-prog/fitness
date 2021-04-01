import 'package:fitness/components/common/save-button.dart';
import 'package:fitness/components/common/toast.dart';
import 'package:fitness/core/constants.dart';
import 'package:fitness/domain/workout.dart';
import 'package:flutter/material.dart';

import 'add-workout-week.dart';



class AddWorkout extends StatefulWidget {
  final WorkoutSchedule workoutSchedule;

  AddWorkout({Key key, this.workoutSchedule}) : super(key: key);

  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final _fbKey = GlobalKey<FormState>();

  WorkoutSchedule workout = WorkoutSchedule(weeks: []);
  var filterLevel = 'Any Level';
  var levelMenuItems = <String>[
    'Any Level',
    'Beginner',
    'Intermediate',
    'Advanced'
  ].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList();

  @override
  void initState() {
    if (widget.workoutSchedule != null) workout = widget.workoutSchedule.copy();

    super.initState();
  }

  void _saveWorkout() {
    if (_fbKey.currentState.validate()) {
      if(workout.weeks == null || workout.weeks.length == 0)
      {
        buildToast('Please add at least one training week');
        return;
      }

      Navigator.of(context).pop(workout);
    } else {
      buildToast('Ooops! Something is not right');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MaxFit // Create Workout'),
          actions: <Widget>[
            SaveButton(onPressed: _saveWorkout)
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: bgColorWhite),
          child: Column(
            children: <Widget>[
              Form(
                // context,
                key: _fbKey,
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Title*",
                      ),
                      onChanged: (dynamic val) {},
                      validator: (String value) {
                        if (value == null || value.isEmpty || value.length>100) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Level'),
                items: levelMenuItems,
                value: filterLevel,
                onChanged: (String val) => setState(() => filterLevel = val),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Weeks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      var week = await Navigator.push<WorkoutWeek>(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => AddWorkoutWeek()));
                      if (week != null)
                        setState(() {
                          workout.weeks.add(week);
                        });
                    },
                  )
                ],
              ),
              workout.weeks.length <= 0
                  ? Text(
                'Please add at least one training week',
                style: TextStyle(fontStyle: FontStyle.italic),
              )
                  : _buildWeeks()
            ],
          ),
        ));
  }

  Widget _buildWeeks() {
    return Expanded(
      //padding: EdgeInsets.all(5),
        child: Column(
            children: workout.weeks
                .map((week) => Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: InkWell(
                onTap: () async {
                  var ind = workout.weeks.indexOf(week);

                  var modifiedWeek = await Navigator.push<WorkoutWeek>(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              AddWorkoutWeek(week: week)));
                  if (modifiedWeek != null) {
                    setState(() {
                      workout.weeks[ind] = modifiedWeek;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(50, 65, 85, 0.9)),
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1, color: Colors.white24))),
                    ),
                    title: Text(
                        'Week ${workout.weeks.indexOf(week) + 1} - ${week.daysWithDrills} Training Days',
                        style: TextStyle(
                            color:
                            Theme.of(context).textTheme.title.color,
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.title.color),
                  ),
                ),
              ),
            ))
                .toList()));
  }
}


