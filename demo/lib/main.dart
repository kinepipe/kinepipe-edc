import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/localization/module_translation_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        path: 'assets/translations',
        fallbackLocale: const Locale('es', 'ES'),
        assetLoader: ModuleTranslationLoader(),
        child: const ResearchModuleApp(),
      ),
    ),
  );
}

class ResearchModuleApp extends ConsumerWidget {
  const ResearchModuleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'RESEARCH MODULE',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.getDarkTheme(themeState.scheme), // Dynamic theme!
      darkTheme: AppTheme.getDarkTheme(themeState.scheme),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
