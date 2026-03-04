import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:graduation_ceremony/providers/app_state_provider.dart';

import 'widgets/footer_section.dart';
import 'widgets/header_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/mission_parameters_section.dart';
import 'widgets/operation_date_section.dart';
import 'widgets/rsvp_section.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _scanAnimation = Tween<double>(
      begin: -0.1,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _scanController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark, // slate-200 equivalent
      body: Stack(
        children: [
          // Radial overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.6, -0.6), // 80% 20%
                  colors: [Colors.transparent, Colors.black12],
                  radius: 1.5,
                ),
              ),
            ),
          ),

          // Tech Grid pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: CustomPaint(painter: GridPainter()),
            ),
          ),

          // Static Pulse Lines & Spinners
          Positioned(
            top: 80.h,
            left: 40.w,
            child: Container(
              width: 256.w,
              height: 1.h,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          Positioned(
            bottom: 128.h,
            right: 40.w,
            child: Container(
              width: 384.w,
              height: 1.h,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),

          // TV Statics GIF Overlay (simulated via very transparent image)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.03,
                child: Image.network(
                  'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDdtYnJrcG14YnJrcG14YnJrcG14YnJrcG14YnJrcG14YnJrcG14YnJrcG14/xT9Igk31lY1nZ31zXa/giphy.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              Header(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Stack(
                    children: [
                      // Content is ALWAYS built – responds to locale changes
                      Column(
                        children: [
                          HeroSection(),
                          OperationDateSection(),
                          MissionParametersSection(),
                          RsvpSection(),
                          FooterSection(),
                        ],
                      ),
                      // Shimmer overlay fades in/out on top
                      IgnorePointer(
                        ignoring: !isLoading,
                        child: AnimatedOpacity(
                          opacity: isLoading ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.backgroundDark,
                            highlightColor: AppColors.primary.withValues(
                              alpha: 0.15,
                            ),
                            period: const Duration(milliseconds: 1200),
                            child: Container(
                              height: 2000.h,
                              width: double.infinity,
                              color: AppColors.backgroundDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),

          // Scan Beam (Animated) OVERLAY
          AnimatedBuilder(
            animation: _scanAnimation,
            builder: (context, child) {
              final topPosition =
                  MediaQuery.of(context).size.height * _scanAnimation.value;
              return Positioned(
                top: topPosition,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Scan trail
                      Container(
                        height: 150.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.primary.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Scan beam
                      Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.8),
                              blurRadius: 15.r,
                            ),
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.8),
                              blurRadius: 30.r,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Overlay Texts
          Positioned(
            top: -48.h,
            left: 40.w,
            child: Text(
              'SCANNING SECTOR 7...',
              style: AppTextStyle.getMonospace(
                color: AppColors.primary,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 1.w;
    for (double i = 0; i < size.width; i += 50.w) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 50.h) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
