import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings.title')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Theme Selector
          Text(tr('settings.theme'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: FlexScheme.values.where((s) => s != FlexScheme.custom).map((scheme) {
              final color = FlexColor.schemes[scheme]!.dark.primary;
              final isSelected = themeState.scheme == scheme;
              return InkWell(
                onTap: () {
                  ref.read(themeProvider.notifier).setScheme(scheme);
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                    ],
                  ),
                  child: isSelected ? const Icon(LucideIcons.check, color: Colors.white) : null,
                ),
              );
            }).toList(),
          ),
          const Divider(height: 48),
          // Progress Style Selector
          Text(tr('settings.progress_indicator'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          RadioListTile<ProgressIndicatorStyle>(
            title: Text(tr('settings.indicator_circular')),
            subtitle: const Text('Muestra el avance en una barra lateral con círculos'),
            value: ProgressIndicatorStyle.circularSidebar,
            groupValue: themeState.progressIndicatorStyle,
            onChanged: (val) => ref.read(themeProvider.notifier).setProgressStyle(val!),
          ),
          RadioListTile<ProgressIndicatorStyle>(
            title: Text(tr('settings.indicator_linear')),
            subtitle: const Text('Muestra el avance en una barra lineal superior'),
            value: ProgressIndicatorStyle.linearHeader,
            groupValue: themeState.progressIndicatorStyle,
            onChanged: (val) => ref.read(themeProvider.notifier).setProgressStyle(val!),
          ),
          const Divider(height: 48),
          // Language Selector
          Text(tr('settings.language'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(LucideIcons.languages),
            title: const Text('Español'),
            trailing: context.locale.languageCode == 'es' ? const Icon(LucideIcons.check, color: Colors.green) : null,
            onTap: () {
              context.setLocale(const Locale('es', 'ES'));
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.languages),
            title: const Text('English'),
            trailing: context.locale.languageCode == 'en' ? const Icon(LucideIcons.check, color: Colors.green) : null,
            onTap: () {
              context.setLocale(const Locale('en', 'US'));
            },
          ),
        ],
      ),
    );
  }
}
