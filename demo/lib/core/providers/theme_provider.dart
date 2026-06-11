import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProgressIndicatorStyle {
  circularSidebar,
  linearHeader
}

// State definition for the theme and UI preferences
class ThemeState {
  final FlexScheme scheme;
  final ProgressIndicatorStyle progressIndicatorStyle;
  
  ThemeState({
    required this.scheme,
    this.progressIndicatorStyle = ProgressIndicatorStyle.circularSidebar,
  });
  
  ThemeState copyWith({
    FlexScheme? scheme,
    ProgressIndicatorStyle? progressIndicatorStyle,
  }) {
    return ThemeState(
      scheme: scheme ?? this.scheme,
      progressIndicatorStyle: progressIndicatorStyle ?? this.progressIndicatorStyle,
    );
  }

  bool get isDark => true; // Por ahora siempre oscuro según diseño premium
}

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    return ThemeState(scheme: FlexScheme.cyanM3);
  }

  void setScheme(FlexScheme scheme) {
    state = state.copyWith(scheme: scheme);
  }

  void setProgressStyle(ProgressIndicatorStyle style) {
    state = state.copyWith(progressIndicatorStyle: style);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(ThemeNotifier.new);
