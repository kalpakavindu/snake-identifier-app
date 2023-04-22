import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './color_scheme.dart';
import './firebase_options.dart';
import './screens/image_capture_screen.dart';
import './screens/add_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;

  final _pageOptions = <Widget>[
    const ImageCaptureScreen(),
    const AddDetailsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Identifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorScheme.primaryContainer,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.background,
          foregroundColor: Colors.black,
        ),
      ),
      home: Scaffold(
        backgroundColor: lightColorScheme.background,
        appBar: AppBar(
          title: const Text('Snake Identifier'),
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
          currentIndex: selectedPage,
          elevation: 5.0,
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
