import 'package:flutter/material.dart';
import 'package:flutterpomodorocat/about_page.dart';
import 'package:flutterpomodorocat/long_pause_page.dart';
import 'package:flutterpomodorocat/pomodoro_page.dart';
import 'package:flutterpomodorocat/short_pause_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Cat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pomodoro Cat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PageController(initialPage: _selectedIndex);

  static int _selectedIndex = 0;

  void _updateIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _updateIndex(index);
    controller.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _goToPage(int index) {
    _updateIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[500],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          _goToPage(index);
        },
        children: <Widget>[
          PomodoroPage(),
          ShortPausePage(),
          LongPausePage(),
          AboutPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Pomodoro'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pause_circle_outline),
            title: Text('Short pause'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pause_circle_filled),
            title: Text('Long pause'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange[500],
        unselectedItemColor: Colors.grey,
        //backgroundColor: Colors.grey[200]
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
