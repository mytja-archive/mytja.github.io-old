import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  var personal =
      await http.get(Uri.parse("https://api.github.com/users/mytja"));
  Map<String, dynamic> personalJSON = json.decode(personal.body.toString());

  var orgs = await http.get(Uri.parse("https://api.github.com/users/mytja"));
  Map<String, dynamic> orgJSON = json.decode(orgs.body.toString());

  runApp(MyApp(personal: personalJSON, org: orgJSON));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> personal;
  final Map<String, dynamic> org;

  MyApp(
      {Key? key,
      required Map<String, dynamic> this.personal,
      required Map<String, dynamic> this.org})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mytja',
      home: MyHomePage(
        title: 'mytja',
        org: org,
        personal: personal,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key,
      required this.title,
      required Map<String, dynamic> this.personal,
      required Map<String, dynamic> this.org})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Map<String, dynamic> personal;
  final Map<String, dynamic> org;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle linkStyle = TextStyle(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          js.context.callMethod('open', [widget.personal["html_url"]]);
        },
        child: const Icon(AntDesign.github),
      ),
      body: ListView(
        children: <Widget>[
          Card(
              child: Column(children: [
            Container(height: 10),
            GestureDetector(
              child: Image.network(
                widget.personal["avatar_url"],
                height: 100,
                width: 100,
              ),
              onTap: () {
                js.context.callMethod('open', ["https://github.com/mytja"]);
              },
            ),
            Container(height: 10),
            Text(
              "Hi, there! 👋",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "I'm @mytja",
              style: TextStyle(fontSize: 40),
            ),
            Container(height: 20),
            Text("I am an open-source developer."),
            Container(height: 5),
            Text(widget.personal["bio"]),
            Container(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Entypo.location_pin),
                Text(widget.personal["location"])
              ],
            ),
            Container(height: 10),
          ])),
          Container(height: 20),
          Center(
              child:
                  Text("Used technologies: ", style: TextStyle(fontSize: 30))),
          Card(
              child: Column(children: [
            Container(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    "https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg",
                    height: 150,
                  ),
                  Container(width: 10),
                  Column(children: [
                    Text("Python", style: TextStyle(fontSize: 30)),
                    Container(height: 10),
                    Text(
                        "From Python, I'm interested in IoT & Web development the most. \nI also develop some libraries and own some short codes")
                  ])
                ]),
          ])),
          Card(
              child: Column(children: [
            Container(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                      "https://raw.githubusercontent.com/dnfield/flutter_svg/7d374d7107561cbd906d7c0ca26fef02cc01e7c8/example/assets/flutter_logo.svg?sanitize=true",
                      height: 150),
                  Container(width: 10),
                  Column(children: [
                    Text("Flutter / Dart", style: TextStyle(fontSize: 30)),
                    Container(height: 10),
                    Text(
                        "Flutter is a library written in Dart, \nwhich itself is built around JavaScript. \nIn it, we can create apps that can run on any platform"),
                    Container(height: 10),
                    Text("Fun fact: This website is fully written in Flutter")
                  ])
                ]),
          ])),
          Card(
              child: Column(children: [
            Container(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                      "https://upload.wikimedia.org/wikipedia/commons/9/99/Unofficial_JavaScript_logo_2.svg",
                      height: 150),
                  Container(width: 10),
                  Column(children: [
                    Text("JavaScript", style: TextStyle(fontSize: 30)),
                    Container(height: 10),
                    Text(
                        "I know AJAX and a little bit of jQuery. \nI mostly use JavaScript in browser extensions"),
                  ])
                ]),
          ])),
          Container(height: 20),
          Center(child: Text("My projects: ", style: TextStyle(fontSize: 30))),
          GestureDetector(
              onTap: () {
                js.context.callMethod(
                    'open', ["https://github.com/MeetPlan/MeetPlan"]);
              },
              child: Card(
                  child: Column(children: [
                Container(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://avatars.githubusercontent.com/u/81251558?s=400&u=c2d70fa0f2aa2a6961e177119bf7b02eedf65e80&v=4",
                        height: 150,
                      ),
                      Container(width: 10),
                      Column(children: [
                        Text("MeetPlan", style: TextStyle(fontSize: 30)),
                        Container(height: 10),
                        Text(
                            "MeetPlan is a organizer for schools, that organizes (online) meetings"),
                      ])
                    ]),
              ]))),
          GestureDetector(
              onTap: () {
                js.context.callMethod(
                    'open', ["https://github.com/mytja/harmonoid-music-bot"]);
              },
              child: Card(
                  child: Column(children: [
                Container(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://avatars.githubusercontent.com/u/75374037?s=200&v=4",
                        height: 150,
                      ),
                      Container(width: 10),
                      Column(children: [
                        Text("Harmonoid Music Bot",
                            style: TextStyle(fontSize: 30)),
                        Container(height: 10),
                        Text(
                            "Harmonoid Music Bot is a music-playing bot with really advanced features."),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(text: 'It was created with help of '),
                              TextSpan(
                                  text: '@alexmercerind',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      js.context.callMethod('open',
                                          ["https://github.com/alexmercerind"]);
                                    }),
                              TextSpan(text: ' and '),
                              TextSpan(
                                  text: '@raitonoberu',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      js.context.callMethod('open',
                                          ["https://github.com/raitonoberu"]);
                                    }),
                              TextSpan(text: " aka. "),
                              TextSpan(
                                  text: 'The Harmonoid Team',
                                  style: linkStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      js.context.callMethod('open',
                                          ["https://github.com/harmonoid"]);
                                    }),
                            ],
                          ),
                        ),
                      ])
                    ]),
              ]))),
          GestureDetector(
              onTap: () {
                js.context
                    .callMethod('open', ["https://github.com/mytja/RGBApp"]);
              },
              child: Card(
                  child: Column(children: [
                Container(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/rgbapp.png",
                        height: 150,
                      ),
                      Container(width: 10),
                      Column(children: [
                        Text("RGBApp", style: TextStyle(fontSize: 30)),
                        Container(height: 10),
                        Text(
                            "RGBApp is a simple app, that can control RGB LEDs with multiple connections. \nFun fact: This was my first Flutter app"),
                      ])
                    ]),
              ]))),
          Container(height: 20),
          Center(
              child:
                  Text("My organisations: ", style: TextStyle(fontSize: 30))),
          GestureDetector(
              onTap: () {
                js.context.callMethod('open', ["https://github.com/MeetPlan"]);
              },
              child: Card(
                  child: Column(children: [
                Container(height: 10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://avatars.githubusercontent.com/u/81251558?s=400&u=c2d70fa0f2aa2a6961e177119bf7b02eedf65e80&v=4",
                        height: 150,
                      ),
                      Container(width: 10),
                      Column(children: [
                        Text("MeetPlan", style: TextStyle(fontSize: 30)),
                        Container(height: 10),
                        Text(
                            "MeetPlan organisation hosts projects related to meeting planning (MeetPlan, MeetPlanApp)"),
                      ])
                    ]),
              ]))),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            Text("Built with ❤️ in Flutter"),
          ],
        ),
      ),
    );
  }
}
