import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
class Setting extends StatelessWidget
{
  final _hintStyle = const TextStyle(color: Colors.grey);
  final _controller = TextEditingController(text: "");

  Setting({Key key}): super(key: key)
{
  SharedPreferences.getInstance().then((preferences)
      {
        String serverUrl = preferences.getString("server_url");
        _controller.text = serverUrl;
      });
}
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Settings"),
      ),
      body: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>
        [
          TextField(controller: _controller, decoration: InputDecoration(hintStyle: _hintStyle, hintText: "Server URL", icon: Icon(Icons.http)),),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              FlatButton
              (
                child: Text
                (
                  "Save",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: ()
                {
                  SharedPreferences.getInstance().then((preferences)
                      {
                        print(_controller.text);
                        preferences.setString("server_url", _controller.text).then((success)
                        {
                          if(success) {_showAlertDialog(context, "Success", "Save Successful" );}
                          else {_showAlertDialog(context, "Error", "Something went wrong, Please try again!");}
                        });
                      }
                      );
                },
              ),
              FlatButton
              (
                child: Text
                (
                  "Cancel",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black26,
                onPressed: ()=> Navigator.pop(context),
              ),
            ],
          ),
        ],

      ),
    );
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
          child: Text("Ok"),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog
    (
      context: context,
      builder: (BuildContext context)
        {
          return alertdialog;
        }
    );
  }
}