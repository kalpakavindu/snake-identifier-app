import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snake_identification_app/screens/details_screen.dart';
import './firebase_options.dart';
import './screens/image_capture_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;

  final _pageOptions = <Widget>[
    const ImageCaptureScreen(),
    const DetailsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Identifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Snake Identifier'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.image_search_rounded, size: 30),
              label: 'Pick Image',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.details_rounded),
              label: 'Add Details',
            )
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          elevation: 10.0,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),
        body: _pageOptions[selectedPage],
      ),
    );
  }
}
