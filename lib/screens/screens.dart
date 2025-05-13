import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageA1 extends StatelessWidget {
  const PageA1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Page A1')),
        body: Center(child: Text('This is Page A1')),
      );
}

class PageA2 extends StatelessWidget {
  const PageA2({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Page A2')),
        body: Center(child: Text('This is Page A2')),
      );
}

class PageB1 extends StatelessWidget {
  const PageB1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Column(
          children: [
            Text('Sidebar Page B1'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/b2');
              },
              child: Text('To B2'),
            ),
          ],
        )),
      );
}

class PageB2 extends StatelessWidget {
  const PageB2({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Column(
          children: [
            Text('Sidebar Page B2'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/a2');
              },
              child: Text('To A2'),
            ),
          ],
        )),
      );
}

class PageB3 extends StatelessWidget {
  const PageB3({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: Text('Sidebar Page B3')),
      );
}
