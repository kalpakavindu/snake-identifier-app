import 'package:flutter/material.dart';
import '../widgets/reusable_text_button.dart';
import '../color_scheme.dart';

class LandingScreen extends StatelessWidget {
  final VoidCallback onSelectDetailsBtn;
  final VoidCallback onSelectImageBtn;

  const LandingScreen({
    super.key,
    required this.onSelectDetailsBtn,
    required this.onSelectImageBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: lightColorScheme.outline),
                  ),
                ),
                Center(
                  child: Text(
                    'Snake Identifier App',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 35.0,
                      color: lightColorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 300.0,
              height: 300.0,
              child: Image(
                image: AssetImage(
                  'assets/images/abstract_snake_purple_landing_screen.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Text(
                  'Get Started By',
                  style: TextStyle(
                    color: lightColorScheme.outline,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ReusableTextButton(
                  backgroundColor: lightColorScheme.primaryContainer,
                  textColor: lightColorScheme.onPrimaryContainer,
                  text: 'Adding Details',
                  onTap: onSelectDetailsBtn,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'or',
                  style: TextStyle(
                    color: lightColorScheme.outline,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ReusableTextButton(
                  backgroundColor: lightColorScheme.primary,
                  textColor: lightColorScheme.onPrimary,
                  text: 'Adding Image',
                  onTap: onSelectImageBtn,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
