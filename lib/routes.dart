import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_router/screens/screens.dart';
import 'package:two_router/screens/sidebar_screen.dart';
import 'screens/home_screen.dart';

// Classe Base para Rotas
class BaseRoute {
  final String path;
  final Widget Function(BuildContext) builder;

  /// openOnSidebar: compatible only web
  final bool openOnSidebar;

  const BaseRoute({
    required this.path,
    required this.builder,
    this.openOnSidebar = false,
  });
}

// Classe para gerenciar a última rota raiz
class LastRootRouteNotifier extends ChangeNotifier {
  Widget _lastRootWidget = HomeScreen();
  Widget get lastRootWidget => _lastRootWidget;

  String _lastRootPath = '/';
  String get lastRootPath => _lastRootPath;

  void updateLastRoot(Widget widget, String path) {
    _lastRootWidget = widget;
    _lastRootPath = path;
    notifyListeners();
  }
}

// Lista de rotas com notifier
final lastRootRouteNotifier = LastRootRouteNotifier();
final List<BaseRoute> appRoutes = [
  BaseRoute(path: '/', builder: (context) => HomeScreen()),
  BaseRoute(path: '/a1', builder: (context) => PageA1()),
  BaseRoute(path: '/a2', builder: (context) => PageA2()),
  BaseRoute(path: '/b1', builder: (context) => PageB1(), openOnSidebar: true),
  BaseRoute(path: '/b2', builder: (context) => PageB2(), openOnSidebar: true),
];

// Função para gerar as rotas com GoRouter
List<GoRoute> generateRoutes() {
  return appRoutes.map((route) {
    return GoRoute(
      path: route.path,
      pageBuilder: (context, state) {
        final currentWidget = route.builder(context);

        // Para web, verifica se a rota deve abrir no sidebar ou não
        if (kIsWeb) {
          // Se não for uma rota de sidebar, atualiza o último widget raiz
          if (!route.openOnSidebar) {
            lastRootRouteNotifier.updateLastRoot(currentWidget, route.path);
            return NoTransitionPage(child: currentWidget);
          }

          // Se for rota de sidebar, mostra o último widget raiz com o sidebar
          return NoTransitionPage(
            child: Stack(
              children: [
                // Widget da última rota raiz
                ListenableBuilder(
                  listenable: lastRootRouteNotifier,
                  builder: (context, _) => lastRootRouteNotifier.lastRootWidget,
                ),
                // Sidebar com o widget atual
                SidebarScreen(
                  lastRootPath: lastRootRouteNotifier.lastRootPath,
                  child: currentWidget,
                ),
              ],
            ),
          );
        }

        // Para dispositivos móveis, apenas retorna o widget atual
        return NoTransitionPage(child: currentWidget);
      },
    );
  }).toList();
}
