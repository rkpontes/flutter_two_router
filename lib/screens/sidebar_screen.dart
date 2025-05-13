import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SidebarScreen extends StatefulWidget {
  final Widget child;
  final String lastRootPath;

  const SidebarScreen({
    super.key,
    required this.child,
    required this.lastRootPath,
  });

  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> _isDrawerOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openEndDrawer();
    });
  }

  @override
  void dispose() {
    _isDrawerOpen.dispose();
    super.dispose();
  }

  void _navigateToLastRoot() {
    GoRouter.of(context).replace(widget.lastRootPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawerScrimColor: Colors.transparent,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          width: 300,
          child: SafeArea(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          html.window.history.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Menu Lateral',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: _navigateToLastRoot,
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: _isDrawerOpen,
          builder: (context, isOpen, child) {
            return GestureDetector(
              onTap: _navigateToLastRoot,
              child: Container(
                color: isOpen ? Colors.black54 : Colors.transparent,
              ),
            );
          },
        ),
        onEndDrawerChanged: (isOpened) {
          _isDrawerOpen.value = isOpened;
          if (!isOpened) {
            GoRouter.of(context).pop();
          }
        },
      ),
    );
  }
}
