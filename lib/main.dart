import 'package:flutter/material.dart';
import 'package:flutterstart/CounterPage.dart';
import 'package:flutterstart/WordPage.dart';

void main() {
  runApp(const MyApp());
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
        // the application has a purple toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Start'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This class holds the values (in this case the title) provided by the parent and used by the build method
  // Fields in a Widget subclass are always marked "final".
  final String title;

  // This widget is stateful, meaning that it has a State object (defined below) that contains fields that affect
  // how it looks.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedNavIndex) {
      case 0:
        page = const CounterPage();
        break;
      case 1:
        page = const WordPage();
        break;
      default:
        // page = const Placeholder();
        throw UnimplementedError("No widget for nav $selectedNavIndex");
    }

    // LayoutBuilder's builder callback is called every time the constraints change e.g. when
    // user resizes the app's window, rotates their phone from portrait mode to landscape mode, or back
    // Some widget next to MyHomePage grows in size, making MyHomePage's constraints smaller
    return LayoutBuilder(
      builder: (context, constraints) {
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
          body: Row(
            children: [
              SafeArea( // ensures that its child is not obscured by a hardware notch or a status bar.
                child: NavigationRail(
                  // responsively show the labels when there's enough room for them.
                  extended: constraints.maxWidth >= 600,
                  selectedIndex: selectedNavIndex,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                    NavigationRailDestination(icon: Icon(Icons.book), label: Text('Words')),
                  ],
                  onDestinationSelected: (value) { setState(() { selectedNavIndex = value; }); },
                )
              ),
              Expanded(child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ))
            ],
          ),
        );
      }
    );
  }
}
