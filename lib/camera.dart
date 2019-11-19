import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget
{
  final title, routeId, routeName, activityType, type, subType,code, remark;


  CameraWidget({this.title, this.routeId, this.routeName, this.activityType,
      this.type, this.subType, this.code,
      this.remark});

  //CameraWidget.name(this.title, this.routeId, this.routeName, this.activityType,
      //this.type, this.subType, this.code, this.remark);//named constructor



  @override
  State<StatefulWidget> createState()
  {
    return CameraState();
  }
}

class CameraState extends State<CameraWidget>
{
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold
    (

    );
  }
}