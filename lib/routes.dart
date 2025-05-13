import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_router/screens/screens.dart';
import 'package:two_router/screens/sidebar_screen.dart';
import 'screens/home_screen.dart';

// Classe Base para Rotas
class WebBaseRoute {
  final String path;
  final Widget Function(BuildContext) builder;
  final bool openOnSidebar;

  const WebBaseRoute({
    required this.path,
    required this.builder,
    this.openOnSidebar = false,
  });
}

// Mixin para Rotas da Sidebar
mixin SidebarBaseRoute on WebBaseRoute {}

// Lista de rotas
final List<WebBaseRoute> appRoutes = [
  WebBaseRoute(path: '/', builder: (context) => HomeScreen()),
  WebBaseRoute(path: '/a1', builder: (context) => PageA1()),
  WebBaseRoute(path: '/a2', builder: (context) => PageA2()),
  WebBaseRoute(
      path: '/b1', builder: (context) => PageB1(), openOnSidebar: true),
  WebBaseRoute(
      path: '/b2', builder: (context) => PageB2(), openOnSidebar: true),
];

// Função para gerar as rotas com GoRouter
List<GoRoute> generateRoutes() {
  return appRoutes.map((route) {
    return GoRoute(
      path: route.path,
      pageBuilder: (context, state) {
        // Verifica se a rota é da sidebar
        if (route.openOnSidebar) {
          return NoTransitionPage(
              child: SidebarScreen(child: route.builder(context)));
        } else {
          return NoTransitionPage(child: route.builder(context));
        }
      },
    );
  }).toList();
}
