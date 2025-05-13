import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMicroappSection(
                context,
                title: 'Finanças',
                routes: [
                  ('Dashboard Financeiro', '/finances'),
                  ('Transações', '/finances/transactions'),
                  ('Análises Financeiras (Sidebar)', '/finances/analytics'),
                  ('Relatórios Financeiros (Sidebar)', '/finances/reports'),
                ],
              ),
              _buildDivider(),
              _buildMicroappSection(
                context,
                title: 'Notificações',
                routes: [
                  ('Central de Notificações', '/notifications'),
                  ('Configurações de Notificações', '/notifications/settings'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMicroappSection(
    BuildContext context, {
    required String title,
    required List<(String label, String route)> routes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: routes.map((route) {
            return ElevatedButton(
              onPressed: () => context.go(route.$2),
              child: Text(route.$1),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(thickness: 1),
    );
  }
}
