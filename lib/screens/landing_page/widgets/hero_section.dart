import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';

// ======================================
// 2. Hero Section
// ======================================
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _textGlowController;
  late bool _isInitialized;

  @override
  void initState() {
    super.initState();
    _isInitialized = false;

    // Glow animation for the title text
    _textGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Initialize video player
    _videoController =
        VideoPlayerController.asset(
            'assets/mp4/Radar_spots_agent_in_vietnam_delpmaspu_remove_water_mark.mp4',
          )
          ..initialize().then((_) {
            if (!mounted) return;
            _isInitialized = true;
            _videoController.setVolume(0); // Mute video
            _videoController.setLooping(true);
            _videoController.play();
            setState(() {}); // Trigger rebuild to show video
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _textGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      // Adjust height to better fit the contained image without excessive letterboxing
      height: isMobile ? 300.h : 700.h,
      color: Colors.black, // Add strict black background for letterboxing
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Background: Animated radar video ──
          Positioned.fill(
            child: _isInitialized
                ? FittedBox(
                    fit: BoxFit
                        .contain, // Fit to width/height to show everything
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                : const SizedBox(),
          ),

          // ── Dark overlay for readability ──
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
          ),

          // ── Scan-line effect overlay ──
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _ScanLinePainter()),
            ),
          ),

          // ── Campaign title text ──
          Positioned(
            right: isMobile ? 135.w : 305.w,
            bottom: isMobile ? 0.h : 0.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Top decorative line
                Container(
                  width: isMobile ? 32.w : 64.w,
                  height: 2.h,
                  color: AppColors.primary,
                ),
                SizedBox(height: isMobile ? 12.h : 24.h),

                // "CHIẾN DỊCH" label
                AnimatedBuilder(
                  animation: _textGlowController,
                  builder: (context, child) {
                    final glowOpacity = 0.4 + (_textGlowController.value * 0.6);
                    return Text(
                      'CHIẾN DỊCH',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.getMonospace(
                        fontSize: isMobile ? 26 : 24,
                        letterSpacing: isMobile ? 8 : 12,
                        color: AppColors.primary.withValues(alpha: glowOpacity),
                      ),
                    );
                  },
                ),

                SizedBox(height: 8.h),

                // Main title
                Text(
                  'THƯ MỜI\nTHAM DỰ',
                  textAlign: TextAlign.right,
                  style: AppTextStyle.getDisplayLarge().copyWith(
                    fontSize: isMobile ? 64.sp : 64.sp,
                    height: 1,
                    letterSpacing: -2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.8),
                        blurRadius: 20,
                      ),
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                ),

                // Bottom decorative line
                Container(
                  width: isMobile ? 32.w : 64.w,
                  height: 2.h,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Subtle horizontal scan-line overlay for a CRT / tactical feel.
class _ScanLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.06)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
