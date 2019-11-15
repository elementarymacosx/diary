import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_diary/setting.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
    (
      title: 'My Diary',
      theme: new ThemeData
      (
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(title: 'MyDiary: '),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _currentDate2 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var appBarTitleText;

  void _checkPermissions() async
  {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location, PermissionGroup.storage]);
    bool isGranted = true;
    permissions.forEach((permission, status)
    {
      if(status != PermissionStatus.granted)
        {
          isGranted = false;
        }
    });
    while(!isGranted)
      {
        _checkPermissions();
      }
  }


  void getRealTime()
  {
    appBarTitleText = new Text(new DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now()));
    setState(()
    {
      appBarTitleText = Text(new DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now()));
    });
  }

  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  void _showToast()
  {
    Fluttertoast.showToast
    (
      msg: 'Create an event',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 10.0,
    );
  }
//Fluttertoast.cancel();

  static Widget _eventIcon = new Container
  (
    decoration: new BoxDecoration
    (
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 2.0)
  ),
    child: new Icon
    (
      Icons.person,
      color: Colors.amber,
    )
  );

  EventList<Event> _markedDateMap = new EventList<Event>
  (
    events:
    {
      new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1):
          [
            new Event
            (
              date: new DateTime(2019, 11, 14),
              title: 'Event 1',
              icon: _eventIcon,
              dot: Container
              (
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                color: Colors.red,
                height: 5.0,
                width: 5.0,
              ),
            ),
            new Event
              (
              date: new DateTime(2019, 11, 16),
              title: 'Event 2',
              icon: _eventIcon,
            ),
            new Event
              (
              date: new DateTime(2019, 11, 16),
              title: 'Event 3',
              icon: _eventIcon,

            )
          ]
    }
  );

  CalendarCarousel _calendarCarousel;

  @override
  void initState()
  {
    _markedDateMap.add
    (
      new DateTime(2019, 11, 2),
      new Event
      (
        date: new DateTime(2019, 11, 2),
        title: 'Event 5',
        icon: _eventIcon,
      )
    );

    _markedDateMap.add
    (
      new DateTime(2019, 11, 3),
      new Event
      (
        date: new DateTime(2019, 11, 3),
        title: 'Event 4',
        icon: _eventIcon,
      )
    );
    
    _markedDateMap.addAll(new DateTime(2019, 11, 1),
    [
      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 1',
        icon: _eventIcon,
      ),

      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 2',
        icon: _eventIcon,
      ),

      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 3',
        icon: _eventIcon,
      ),

      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 4',
        icon: _eventIcon,
      ),

      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 23',
        icon: _eventIcon,
      ),

      new Event
      (
        date: new DateTime(2019, 11, 1),
        title: 'Event 123',
        icon: _eventIcon,
      )
    ]);
    super.initState();
    _checkPermissions();
    getRealTime();
  }

  @override
  Widget build(BuildContext context)
  {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    _calendarCarousel = CalendarCarousel<Event>
    (
      onDayPressed: (DateTime date, List<Event> events)
      {
        this.setState(()=> _currentDate2 = date);
        events.forEach((event) => print(event.title));
        Fluttertoast.showToast
        (
          msg: date.year.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16,
        );
      },
      weekendTextStyle: TextStyle
      (
        color: Colors.red,
      ),

      thisMonthDayBorderColor: Colors.grey,

      headerText: 'My Diary',

      weekFormat: false,

      markedDatesMap: _markedDateMap,

      showOnlyCurrentMonthDate: false,

      height: 420.0,

      selectedDateTime: _currentDate2,

      showIconBehindDayText: true,

      //daysHaveCircularBorder: true,

      customGridViewPhysics: NeverScrollableScrollPhysics(),

      markedDateShowIcon: true,

      markedDateIconMaxShown: 2,

      selectedDayTextStyle: TextStyle
      (
        color: Colors.yellowAccent,
        fontSize: 10.0,
      ),

      todayTextStyle: TextStyle
      (
        color: Colors.white,
      ),

      markedDateIconBuilder: (event)
      {
        return event.icon;
      },

      minSelectedDate: _currentDate.subtract(Duration(days: 360)),

      maxSelectedDate: _currentDate.add(Duration(days: 360)),

      todayButtonColor: Colors.blue,

      todayBorderColor: Colors.green,

      markedDateMoreShowTotal: false,

      prevDaysTextStyle: TextStyle
      (
        fontSize: 16,
        color: Colors.pinkAccent,
      ),

      inactiveDaysTextStyle: TextStyle
        (
        color: Colors.tealAccent,
        fontSize: 16,
      ),

      onCalendarChanged: (DateTime date)
      {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },

      onDayLongPressed: (DateTime date)
      {
        print('Long pressed date $date');
      },

    );

    return new Scaffold
      (
      appBar: new AppBar
      (
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: appBarTitleText,
        //title: new Text(widget.title),
        actions: <Widget>
        [
          IconButton
          (
            icon: Icon(Icons.settings),
            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Setting())),

          )
        ],
      ),
      body: SingleChildScrollView
      (
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column
          (
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            //Custom Icon
            Container
            (
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarousel,
            ),
            //Custom Icon without Header
            Container
            (
              margin: EdgeInsets.only
              (
                top: 30.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),

              child: new Row
              (
                children: <Widget>
                [
                  Expanded
                  (
                    child: Text
                    (
                      _currentMonth,
                      style: TextStyle
                      (
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  FlatButton
                  (
                    child: Text('PREV'),
                    onPressed: ()
                    {
                      setState(()
                      {
                        //_currentDate2 = _currentDate2.subtract(Duration(days: 30));
                        //_currentMonth = DateFormat.yMMM().format(_currentDate2);
                      });
                    },
                  ),

                  FlatButton
                  (
                    child: Text('NEXT'),
                    onPressed: ()
                    {
                      setState(()
                      {
                        //_currentDate2 = _currentDate2.add(Duration(days: 30));
                        //_currentMonth = DateFormat.yMMM().format(_currentDate2);
                      });
                    },
                  )
                ],
              ),
            ),

          ]

        ),
      ),

      floatingActionButton: FloatingActionButton
      (
        onPressed: _showToast,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
