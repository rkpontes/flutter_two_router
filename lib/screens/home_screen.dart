import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/a1'),
              child: Text('Go to A1'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/a2'),
              child: Text('Go to A2'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/b1'),
              child: Text('Go to B1 (Sidebar)'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/b2'),
              child: Text('Go to B2 (Sidebar)'),
            ),
          ],
        ),
      ),
    );
  }
}
