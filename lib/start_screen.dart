import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
            ),
            IconButton(
              onPressed: () {
                // Handle settings icon click.
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/logo.png',
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            buildClickableTextWithIcon(
              icon: Icons.home,
              text: 'Personalised Routine',
              onTap: () {
                // Do something when the "Personalised Routine" text is clicked.
              },
            ),
            const SizedBox(height: 20),
            buildClickableTextWithIcon(
              icon: Icons.reorder,
              text: 'Reformer',
              onTap: () {
                // Do something when the "Reformer" text is clicked.
              },
            ),
            const SizedBox(height: 20),
            buildClickableTextWithIcon(
              icon: Icons.fitness_center,
              text: 'Strength',
              onTap: () {
                // Do something when the "Strength" text is clicked.
              },
            ),
            const SizedBox(height: 20),
            buildClickableTextWithIcon(
              icon: Icons.accessibility_new,
              text: 'Stretching',
              onTap: () {
                // Do something when the "Stretching" text is clicked.
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableTextWithIcon({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}