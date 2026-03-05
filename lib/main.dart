import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graduation_ceremony/screens/landing_page/landing_page.dart';
import 'package:graduation_ceremony/theme/app_theme.dart';
import 'package:graduation_ceremony/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomBinding extends WidgetsFlutterBinding {
  @override
  void dispatchEvent(PointerEvent event, HitTestResult? hitTestResult) {
    // Drop all hover events to prevent mouse_tracker.dart assertions
    // from Scrcpy and fixing the stuttering scroll issue.
    if (event is PointerHoverEvent) {
      return;
    }
    super.dispatchEvent(event, hitTestResult);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // CustomBinding();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations', // fallbackFile is not mandatory
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      child: const ProviderScope(child: GraduationApp()),
    ),
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class GraduationApp extends ConsumerWidget {
  const GraduationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Graduation Invitation 2025',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          scrollBehavior: AppScrollBehavior(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: child,
        );
      },
      child: const LandingPage(),
    );
  }
}
