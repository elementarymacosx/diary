import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteForm extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: "MyDiary",
      theme: ThemeData
      (
        primarySwatch: Colors.purple,
      ),
      home: Scaffold
      (

      ),
    );
  }

}

class RouteFormWidget extends StatefulWidget
{
  final String title, activityType;

  RouteFormWidget({Key key, @required this.title, @required this.activityType}): super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return RouteFormState();
  }
}

class RouteFormState extends State<RouteFormWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (

    );
  }
}