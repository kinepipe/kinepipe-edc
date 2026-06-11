import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/glassmorphism.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/providers/module_manager_provider.dart';
import '../../../core/providers/theme_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/auth/auth_models.dart';
import '../../configuration/presentation/qr_scanner_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLang = context.locale.languageCode;
    final moduleState = ref.watch(moduleManagerProvider);
    final activeRoute = moduleState.activeRoute;

    final authState = ref.watch(authProvider);
    final hasModulePermission = ref.read(authProvider.notifier).hasPermission(PermissionType.createModule);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('dashboard.title'), style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Text(
              authState?.name.split(' ').first ?? 'Staff',
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.logOut),
            tooltip: 'Cerrar Sesión',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.settings),
            tooltip: 'Opciones y Configuraciones',
            onPressed: () {
              context.push('/settings');
            },
          ),
          TextButton(
            onPressed: () {
              if (currentLang == 'es') {
                context.setLocale(const Locale('en', 'US'));
              } else {
                context.setLocale(const Locale('es', 'ES'));
              }
            },
            child: Text(
              currentLang.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2072&auto=format&fit=crop'),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 2.5,
                children: [
                  _buildMainActionCard(
                    context,
                    title: activeRoute == null ? 'Crear ruta de evaluación' : tr('dashboard.action_new_eval'),
                    subtitle: activeRoute?.name,
                    icon: LucideIcons.playCircle,
                    color: Colors.greenAccent,
                    onTap: () {
                      if (activeRoute == null) {
                        context.push('/module_manager');
                      } else {
                        context.push('/evaluation');
                      }
                    },
                    trailing: moduleState.routes.length > 1 ? PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.greenAccent),
                      onSelected: (id) => ref.read(moduleManagerProvider.notifier).setActiveRoute(id),
                      itemBuilder: (ctx) => moduleState.routes.map((r) => PopupMenuItem(
                        value: r.id,
                        child: Text(r.name, style: TextStyle(fontWeight: r.id == activeRoute?.id ? FontWeight.bold : FontWeight.normal)),
                      )).toList(),
                    ) : null,
                  ),
                  _buildMainActionCard(
                    context,
                    title: tr('dashboard.action_resume'),
                    icon: LucideIcons.history,
                    color: Colors.orangeAccent,
                    onTap: () {},
                  ),
                  if (hasModulePermission)
                    _buildMainActionCard(
                      context,
                      title: 'Gestor de Módulos',
                      subtitle: 'Diseñar Protocolos',
                      icon: LucideIcons.layers,
                      color: Colors.blueAccent,
                      onTap: () {
                        context.push('/module_manager');
                      },
                    ),
                  _buildMainActionCard(
                    context,
                    title: 'Escanear Ruta (QR)',
                    subtitle: 'Importar protocolo desde Windows',
                    icon: LucideIcons.scanLine,
                    color: Colors.cyanAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const QrScannerScreen()),
                      );
                    },
                  ),
                  if (authState?.role == UserRole.admin)
                    _buildMainActionCard(
                      context,
                      title: 'Gestor de Usuarios',
                      subtitle: 'Administrar Staff',
                      icon: LucideIcons.users,
                      color: Colors.orangeAccent,
                      onTap: () {
                        context.push('/user_manager');
                      },
                    ),
                  _buildMainActionCard(
                    context,
                    title: tr('dashboard.action_settings'),
                    subtitle: 'Idioma, tema y preferencias',
                    icon: LucideIcons.sliders,
                    color: Colors.purpleAccent,
                    onTap: () {
                      context.push('/settings');
                    },
                  ),
                ],
              ).animate().fade(duration: 500.ms).scale(begin: const Offset(0.95, 0.95)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainActionCard(BuildContext context, {required String title, String? subtitle, required IconData icon, required Color color, required VoidCallback onTap, Widget? trailing}) {
    return GlassContainer(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 56, color: color),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    ]
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
