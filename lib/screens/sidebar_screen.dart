import 'package:flutter/material.dart';

class SidebarScreen extends StatefulWidget {
  final Widget child;

  const SidebarScreen({super.key, required this.child});

  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background escuro
        const Positioned.fill(
          child: ColoredBox(
            color: Colors.black54,
          ),
        ),
        // Scaffold com endDrawer
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          endDrawer: Drawer(
            width: 300,
            child: SafeArea(
              child: Column(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Menu Lateral',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
          body: Container(),
          onEndDrawerChanged: (isOpened) {
            if (!isOpened) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
