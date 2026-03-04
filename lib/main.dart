import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/screens/landing_page/landing_page.dart';
import 'package:graduation_ceremony/theme/app_theme.dart';

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

void main() {
  // CustomBinding();
  runApp(const GraduationApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class GraduationApp extends StatelessWidget {
  const GraduationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Graduation Invitation 2025',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          scrollBehavior: AppScrollBehavior(),
          home: child,
        );
      },
      child: const LandingPage(),
    );
  }
}
