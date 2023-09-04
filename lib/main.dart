import 'dart:async';
import 'dart:math';
import 'package:supabase/supabase.dart';

import 'package:flutter/material.dart';

final SupabaseClient client = SupabaseClient( "https://wruqswjbhpvpikhgwade.supabase.co",
 "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0");

int currentTemperature = 0; 

void main() {
  insertDataIntoTable();
  Timer.periodic(Duration(seconds: 5), (timer) async {
    await sendDataToSupabase();
  if(currentTemperature == 100){
    currentTemperature = 0;
  }
  currentTemperature++;
  });
  runApp(const MyApp());
}

Map<String, dynamic> simulateDeviceData() {
 // final random = Random();
  //final temperature = 20 + random.nextInt(15);  // A random value between 20 and 35

  return {'sensor_id': '12345', 'data': currentTemperature};
  //return {'device_id': '72807a12-24c1-4505-9383-92a91be7a478','port': 'D', 'cfg_code': '1', 'data': temperature, };
}

Map<String, dynamic> simulateDeviceData2() {
  final random = Random();
  final temperature = 20 + random.nextInt(15);  // A random value between 20 and 35

  return {'sensor_id': '5325', 'data': temperature};
  //return {'device_id': '72807a12-24c1-4505-9383-92a91be7a478','port': 'D', 'cfg_code': '1', 'data': temperature, };
}

Future<void> sendDataToSupabase() async {
  final data = simulateDeviceData();
  final data2 = simulateDeviceData2();

  final response = await client.from('pintunnel_data').insert(data).execute();

  await client.from('pintunnel_data').insert(data2);
}

void insertDataIntoTable() async{

final url = 'https://wruqswjbhpvpikhgwade.supabase.co/rest/v1/';
final postgrestClient = PostgrestClient(url, headers: {'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndydXFzd2piaHB2cGlraGd3YWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI4MzA2NTIsImV4cCI6MjAwODQwNjY1Mn0.XxlesUi6c-Wi7HXidzVotr8DWzljWGvY4LY3BPD-0N0'});
try {
  await postgrestClient.from('pintunnel')
    .insert([
      {'mac_address': 12345, 'name': 'PinTunnel3', 'user_id': '23fd7c8d-0afd-40fd-b5e9-fe76f702c95f'}
    ]);
} on PostgrestException catch (error, stacktrace) {
  // handle a PostgrestError
  print('$error \n $stacktrace');
} catch (error, stacktrace) {
  // handle other errors
  print('$error \n $stacktrace');
}
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*
import 'dart:async';
import 'dart:math';
import 'package:supabase/supabase.dart';

import 'package:flutter/material.dart';

final SupabaseClient client = SupabaseClient( "https://xkvzvrqmpqhfhutbvlry.supabase.co",
 "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhrdnp2cnFtcHFoZmh1dGJ2bHJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNzY0ODQsImV4cCI6MjAwMjc1MjQ4NH0.73RTVlB2J7OTLRdMQBsOmnKLJb3cOU_jMJxiomkh4-A");

void main() {
  Timer.periodic(Duration(seconds: 5), (timer) async {
    await sendDataToSupabase();
  });
  runApp(const MyApp());
}

Map<String, dynamic> simulateDeviceData() {
  final random = Random();
  final temperature = 20 + random.nextInt(15);  // A random value between 20 and 35

  return {'sensor_id': '3f50219a-1829-41b2-baa0-58ccdb53c3d2', 'value': temperature};
}

Future<void> sendDataToSupabase() async {
  final data = simulateDeviceData();

  final response = await client.from('reading').insert(data).execute();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/