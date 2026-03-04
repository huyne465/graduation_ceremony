import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late AnimationController _gridController;

  @override
  void initState() {
    super.initState();
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 64.h : 96.h,
        horizontal: 16.w,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Corner accents (TopLeft, BottomRight) hidden on mobile
          if (!isMobile)
            Positioned(
              top: -20.h,
              left: 20.w,
              child: Container(
                width: 96.w,
                height: 96.h,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black12),
                    left: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.up,
            children: [
              // Hero Text Block
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      'GRADUATION\n2025',
                      textAlign: isMobile ? TextAlign.center : TextAlign.right,
                      style: AppTextStyle.getDisplayLarge().copyWith(
                        fontSize: isMobile ? 60.sp : 120.sp,
                        height: 0.9,
                        letterSpacing: -2,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 128.w,
                          height: 4.h,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'STATUS: CONFIRMED\nAGENT: CLASS OF \'25',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.right,
                          style: AppTextStyle.getMonospace(
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 64.h, width: 48.w),

              // Image Radar Spin Section
              SizedBox(
                width: isMobile ? 256.w : 320.w,
                height: isMobile ? 256.h : 320.h,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Outer spinning dash ring
                    AnimatedBuilder(
                      animation: _gridController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _gridController.value * 2 * pi,
                          child: Container(
                            width: (isMobile ? 256.w : 320.w) + 40.w,
                            height: (isMobile ? 256.h : 320.h) + 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                style: BorderStyle.none,
                                width: 2.w,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Rotating square Frame
                    AnimatedBuilder(
                      animation: _gridController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: 45 * pi / 180 + (_gridController.value * 0.1),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                width: 1.w,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Main Image Container
                    Transform.rotate(
                      angle: 45 * pi / 180,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 15.r,
                            ),
                          ],
                          color: Colors.grey[300],
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDt1BmaLSr2Jo0yi3av4p0_DbyxxfxOzsEP_efbI8p9ZcGeS0L_7T9rKCCxsYRqSmgFYbBki4ZD1ibl5Ikit8TMDIU7gZ0NFZzrmPX5o4clkL86feMcOhQPw87BFfzBvQ5OcGOoefN6TQJUD0oYwhtO0dIVK_YK6WXBCqtdYkAaHxesHGtfhffxK2mP5TgDVVmt5w2tTKzhTzVpN96FKWnb7kQeOBFdZpd-txkBlbIrxB4Arbj2O1mO_Pxdei-fr2l5sNZrGs2GQJAK',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // ID Overlay Text
                    Positioned(
                      right: -30.w,
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
                        child: Text(
                          'ID: 8492-AX',
                          style: AppTextStyle.getMonospace(
                            color: AppColors.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
