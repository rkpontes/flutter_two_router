import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widget base para páginas não-sidebar
class BasePageScreen extends StatelessWidget {
  final String title;
  final List<(String label, String route)> navigationButtons;
  final Widget? content;

  const BasePageScreen({
    super.key,
    required this.title,
    this.navigationButtons = const [],
    this.content,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (content != null) ...[
                Expanded(child: Center(child: content!)),
                const Divider(),
              ],
              if (navigationButtons.isNotEmpty) ...[
                const Text('Navegação:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: navigationButtons
                      .map((nav) => ElevatedButton(
                            onPressed: () => context.go(nav.$2),
                            child: Text(nav.$1),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      );
}

// Widget base para páginas de sidebar
class BaseSidebarScreen extends StatelessWidget {
  final String title;
  final List<(String label, String route)> navigationButtons;
  final Widget? content;
  final Color? headerColor;

  const BaseSidebarScreen({
    super.key,
    required this.title,
    this.navigationButtons = const [],
    this.content,
    this.headerColor,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (headerColor != null)
                Container(
                  width: double.infinity,
                  height: 4,
                  color: headerColor,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (content != null) ...[
                const SizedBox(height: 16),
                Expanded(child: Center(child: content)),
                const Divider(),
              ],
              if (navigationButtons.isNotEmpty) ...[
                const Text('Navegação:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: navigationButtons
                      .map((nav) => ElevatedButton(
                            onPressed: () => context.go(nav.$2),
                            child: Text(nav.$1),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      );
}

// Páginas do módulo Finances
class FinancesPage extends StatelessWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) => BasePageScreen(
        title: 'Finanças',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.account_balance_wallet, size: 64),
            const SizedBox(height: 16),
            Text(
              'Gestão Financeira',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Text('Gerencie suas finanças de forma eficiente'),
          ],
        ),
        navigationButtons: const [
          ('Transações', '/finances/transactions'),
          ('Análises (Sidebar)', '/finances/analytics'),
          ('Relatórios (Sidebar)', '/finances/reports'),
          ('Central de Notificações', '/notifications'),
        ],
      );
}

class FinancesTransactionsPage extends StatelessWidget {
  const FinancesTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) => BasePageScreen(
        title: 'Transações',
        content: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Supermercado'),
              subtitle: Text('12/05/2025'),
              trailing: Text('-R\$ 235,50'),
            ),
            ListTile(
              leading: Icon(Icons.local_gas_station),
              title: Text('Combustível'),
              subtitle: Text('12/05/2025'),
              trailing: Text('-R\$ 150,00'),
            ),
            ListTile(
              leading: Icon(Icons.paid),
              title: Text('Salário'),
              subtitle: Text('05/05/2025'),
              trailing: Text('+R\$ 5.000,00'),
            ),
          ],
        ),
        navigationButtons: const [
          ('Dashboard Financeiro', '/finances'),
          ('Análises (Sidebar)', '/finances/analytics'),
          ('Central de Notificações', '/notifications'),
        ],
      );
}

class FinancesAnalyticsPage extends StatelessWidget {
  const FinancesAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) => BaseSidebarScreen(
        title: 'Análises Financeiras',
        content: Column(
          children: [
            const Text('Resumo Mensal - Maio 2025'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricCard('Receitas', 'R\$ 5.000,00', Colors.green),
                _buildMetricCard('Despesas', 'R\$ 2.350,00', Colors.red),
                _buildMetricCard('Saldo', 'R\$ 2.650,00', Colors.blue),
              ],
            ),
          ],
        ),
        headerColor: Colors.blue,
        navigationButtons: const [
          ('Dashboard Financeiro', '/finances'),
          ('Relatórios (Sidebar)', '/finances/reports'),
          ('Central de Notificações', '/notifications'),
        ],
      );
}

class FinancesReportsPage extends StatelessWidget {
  const FinancesReportsPage({super.key});

  @override
  Widget build(BuildContext context) => BaseSidebarScreen(
        title: 'Relatórios Financeiros',
        content: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Exportar Relatório'),
            ),
            const SizedBox(height: 24),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Relatório Mensal - Maio 2025'),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total de Transações:'),
                        Text('45'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Volume Total:'),
                        Text('R\$ 8.500,00'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        headerColor: Colors.green,
        navigationButtons: const [
          ('Dashboard Financeiro', '/finances'),
          ('Análises (Sidebar)', '/finances/analytics'),
          ('Central de Notificações', '/notifications'),
        ],
      );
}

// Páginas do módulo Notifications
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => BasePageScreen(
        title: 'Notificações',
        content: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Nova transação registrada'),
              subtitle: Text('Há 5 minutos'),
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Alerta de orçamento'),
              subtitle: Text('Há 2 horas'),
            ),
          ],
        ),
        navigationButtons: const [
          ('Configurações de Notificações', '/notifications/settings'),
          ('Dashboard Financeiro', '/finances'),
        ],
      );
}

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BasePageScreen(
        title: 'Configurações de Notificações',
        content: const Column(
          children: [
            SwitchListTile(
              value: true,
              onChanged: null,
              title: Text('Notificações de transações'),
              subtitle: Text('Receba alertas de novas transações'),
            ),
            SwitchListTile(
              value: false,
              onChanged: null,
              title: Text('Alertas de orçamento'),
              subtitle: Text('Notificações quando atingir limites'),
            ),
          ],
        ),
        navigationButtons: const [
          ('Central de Notificações', '/notifications'),
          ('Dashboard Financeiro', '/finances'),
        ],
      );
}

// Widget auxiliar para métricas
Widget _buildMetricCard(String title, String value, Color color) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
