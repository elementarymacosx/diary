import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:app_settings/app_settings.dart';
import 'package:flutter_diary/camera.dart';


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
  List<Route> _routeList = List();
  final _mediumTextStyle = const TextStyle(fontSize: 16);
  final _bigTextStyle = const TextStyle(fontSize: 30);
  final _hintStyle = const TextStyle(color: Colors.grey);

  final _typeList =
  {
    "PL": "PL (Pole)",
    "MH": "MH (Manhole)",
    "HH": "HH (Handhole)",
    "EODB": "Exchange ODB",
    "EODF": "Exchange ODF",
    "CODB": "Customer ODB",
    "CODF": "Customer ODF",
    "PMODB": "MC/ 12C Pole Mout ODB",
  };

  final _subTypeList1 =
  {
    "EP": "EP (Existing Pole)",
    "NP": "NP (New Pole)",
    "RP": "RP (Replacement Pole)",
    "RB": "RB (Pole Restanding)",
    "GIP": "GIP (GI Pole)",
  };

  final _subTypeList2 =
  {
    "EMH": "EMH (Existing Manhole)",
    "NMH": "NMH (New Manhole)",
    "RBMH": "RBMH (Rebuild Manhole)"
  };

  final _subTypeList3 =
  {
    "NHH": "New Handhole",
    "EHH": "Existing Handhole",
  };

  String _routeName = "";
  String _type = "PL";
  String _subType = "EP";
  String _code = "";
  String _remark = "";
  int _routeId = 0;

  StreamSubscription<ConnectivityResult> _connectivityListener;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem<String>> getTypeMenuItems()
  {
    List<DropdownMenuItem<String>> types = new List();

    _typeList.forEach((key, value)
    {
      types.add(DropdownMenuItem(value: key, child: Text(value),));
    });
    return types;
  }

  List<DropdownMenuItem<String>> getSubTypeMenuTtems(String key)
  {
    List<DropdownMenuItem<String>> types = new List();

    switch(key)
    {
      case "PL":
        _subTypeList1.forEach((key, value)
            {
              types.add(DropdownMenuItem(value: key, child: Text(value),));
            }
        );
        break;
      case "MH":
        _subTypeList2.forEach((key, value)
        {
          types.add(DropdownMenuItem(value: key, child: Text(value),));
        });
        break;
      case "HH":
        _subTypeList3.forEach((key, value)
        {
          types.add(DropdownMenuItem(value: key, child: Text(value),));
        });
        break;
    }
    return types;
  }

  void getDataFromServer(String term) async
  {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    String serverUrl = sharedpreferences.getString("server_url") ?? "http://167.172.70.248:8000";
    final response = await http.get(serverUrl + "/routes/search?term=" +term);

    if(response.statusCode == 200)
      {
        setState(()
        {
          var jsonData = json.decode(response.body);
          _routeList.clear();
          _routeList.addAll((jsonData["results"] as List).map((i) => Route.fromJson(i)));
        });
      }
  }

  @override
  void initState()
  {
    super.initState();
    var connectivity = Connectivity();
    _connectivityListener = connectivity.onConnectivityChanged.listen((result)
        {
          if(result == ConnectivityResult.none)
            {
              _showAlertDialog(context, "Connection Lost", "Please check your connection settings");
            }
          else
            {
              scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Connection Restored"), duration: Duration(seconds: 2),));
            }
        });

    connectivity.checkConnectivity().then((result)
    {
      if (result != ConnectivityResult.none)
        {
          getDataFromServer("");
        }
      else
        {
          _showAlertDialog(context, "No Connection", "No Internet Connection Detected!");
        }
    });
  }

  @override
  void dispose()
  {
    super.dispose();
    _connectivityListener.cancel();
  }

  void _showAlertDialog(BuildContext context, String title, String message)
  {
    AlertDialog alertdialog = AlertDialog
    (
      title: Text(title),
      content: Text(message),
      actions: <Widget>
      [
        FlatButton
        (
          child: Text("Cancel"),
          onPressed: ()
          {
            Navigator.pop(context);
          },

        ),
        FlatButton
        (
          child: Text("Network Settings"),
          onPressed: () => AppSettings.openWIFISettings(),

        )
      ],


    );
    
    showDialog
    (context: context,
     builder: (BuildContext context)
     {
       return alertdialog;
     },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      key: scaffoldKey,
      appBar: AppBar
      (
        title: Text(widget.title),
      ),
      body: Center
      (
        child: SingleChildScrollView
        (
          child: Column
          (
            children: <Widget>
            [
              Text
              (
                widget.activityType,
                style: _bigTextStyle,

              ),
              Padding
              (
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField
                (
                  textAlign: TextAlign.center,
                  decoration: InputDecoration
                  (
                    hintText: "Search Routes",
                    hintStyle: _hintStyle,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text)
                  {
                    getDataFromServer(text);
                  },
                ),
              ),
              ConstrainedBox
              (
                constraints: new BoxConstraints
                (
                  minHeight: 35.0,
                  maxHeight: 300.0,
                ),
                child: ListView.builder
                (
                    itemCount: _routeList.length,
                    itemBuilder: (context, i)
                    {
                      return Column
                      (
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>
                        [
                          ListTile
                          (
                            title: Text
                            (
                              _routeList[i].text,
                              style: _mediumTextStyle,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            onTap: ()
                            {
                              setState(()
                              {
                                _routeId = _routeList[i].id;
                                _routeName = _routeList[i].text;

                              });
                            },
                          ),
                          Divider(height: 2,),
                        ],
                      );
                    }
                ),
              ),
              Divider(color: Colors.black,),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Text
                  (
                    'Route: ',
                    style: _mediumTextStyle,
                  ),
                  Text
                  (
                    _routeName,
                    style: _mediumTextStyle,
                  ),
                ],
              ),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Text
                  (
                    "Type",
                    style: _mediumTextStyle,
                  ),
                  DropdownButton
                  (
                    value: _type,
                    items: getTypeMenuItems(),
                    onChanged: (newVal)
                    {
                      setState(()
                      {
                        _type = newVal;
                        var subList = getSubTypeMenuTtems(_type);
                        if(subList.length > 0)
                          {
                            _subType = subList[0].value;
                          }
                        else
                          _subType = "";

                      });
                    },
                  ),
                ],
              ),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Text
                  (
                    "Sub-Type",
                    style: _mediumTextStyle,
                  ),
                  DropdownButton
                  (
                    value: _subType,
                    items: getSubTypeMenuTtems(_type),
                    onChanged: (newVal)
                    {
                      setState(()
                      {
                        _subType = newVal;
                      });
                    },
                  ),
                ],
              ),
              Padding
              (
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ConstrainedBox
                (
                  constraints: BoxConstraints
                  (
                    minWidth: 100,
                    maxWidth: 150,
                  ),
                  child:
                  (
                    TextField
                    (
                      textAlign: TextAlign.center,
                      decoration: InputDecoration
                      (
                        hintText: "Code",
                        hintStyle: _hintStyle,
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      onChanged: (text) => _code = text,

                    )
                  ),
                ),
              ),
              Padding
              (
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextField
                (
                  textAlign: TextAlign.center,
                  decoration: InputDecoration
                  (
                    hintText: "Remark",
                    hintStyle: _hintStyle,
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (text) => _remark = text,
                ),
              ),
              FlatButton
              (
                child: Text
                (
                  "Next",
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraWidget
                  (
                    title: widget.title,
                    routeId: _routeId,
                    routeName: _routeName,
                    activityType: widget.activityType,
                    type: _type,
                    subType: _subType,
                    code: _code,
                    remark: _remark,
                  )));
                },
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Route
{
  int id;
  String text;
  Route({this.id, this.text}); //name argument
  //Route(this.id, this.text); //positional argument
  factory Route.fromJson(Map<String, dynamic> json)
  {
    return Route(id: json["id"], text: json["text"]);
  }
}