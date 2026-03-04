import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:graduation_ceremony/screens/landing_page/widgets/cyber_hover_builder.dart';

// ======================================
// 4. Mission Parameters
// ======================================
class MissionParametersSection extends StatelessWidget {
  const MissionParametersSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 96.h),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200.w),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: Colors.grey[400],
                  ),
                  Container(
                    color: AppColors.backgroundDark,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'MISSION PARAMETERS',
                      style: AppTextStyle.getHeadlineMedium().copyWith(
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20.h,
                    child: Text(
                      'DECRYPTING...',
                      style: AppTextStyle.getMonospace(
                        color: AppColors.primary,
                        fontSize: 10,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64.h),

              if (isMobile)
                Column(
                  children: [
                    _AttireCard(),
                    SizedBox(height: 32.h),
                    _LocationCard(),
                    SizedBox(height: 32.h),
                    _TimelineCardTech(),
                  ],
                )
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _AttireCard()),
                      SizedBox(width: 32.w),
                      Expanded(child: _LocationCard()),
                      SizedBox(width: 32.w),
                      Expanded(child: _TimelineCardTech()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BaseTechCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String secCode;
  final Widget content;

  const _BaseTechCard({
    required this.title,
    required this.iconData,
    required this.secCode,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CyberHoverBuilder(
      enableBorder: true,
      glowColor: AppColors.primary,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: EdgeInsets.all(32.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Corner decorators
            Positioned(
              top: -32.h,
              left: -32.w,
              child: const _Corner(Alignment.topLeft),
            ),
            Positioned(
              bottom: -32.h,
              right: -32.w,
              child: const _Corner(Alignment.bottomRight),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 48.w,
                    height: 48.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: 45 * pi / 180,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                            ),
                          ),
                        ),
                        Icon(iconData, color: AppColors.primary, size: 24.sp),
                      ],
                    ),
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyle.getTitleLarge().copyWith(
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                content,
              ],
            ),

            Positioned(
              bottom: -16.h,
              right: -16.w,
              child: Text(
                secCode,
                style: AppTextStyle.getMonospace(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final Alignment auth;
  const _Corner(this.auth);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        border: Border(
          top: auth == Alignment.topLeft
              ? BorderSide(color: AppColors.primary, width: 2.w)
              : BorderSide.none,
          left: auth == Alignment.topLeft
              ? BorderSide(color: AppColors.primary, width: 2.w)
              : BorderSide.none,
          bottom: auth == Alignment.bottomRight
              ? BorderSide(color: AppColors.primary, width: 2.w)
              : BorderSide.none,
          right: auth == Alignment.bottomRight
              ? BorderSide(color: AppColors.primary, width: 2.w)
              : BorderSide.none,
        ),
      ),
    );
  }
}

class _AttireCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BaseTechCard(
      title: 'ATTIRE PROTOCOL',
      iconData: Icons.style,
      secCode: 'SEC-01',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TechListItem('FORMAL SUIT / GOWN'),
          SizedBox(height: 12.h),
          const _TechListItem('REGALIA MANDATORY'),
          SizedBox(height: 12.h),
          const _TechListItem('TACTICAL ELEGANCE'),
        ],
      ),
    );
  }
}

class _TechListItem extends StatelessWidget {
  final String text;
  const _TechListItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4.w, height: 4.h, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          text,
          style: AppTextStyle.getMonospace(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BaseTechCard(
      title: 'EXTRACTION POINT',
      iconData: Icons.pin_drop,
      secCode: 'SEC-02',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 96.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCUfyTkPG8ylr8axzCdtQMpPuwEo1c0IeQaDAS8JuGMjbv8cyQMHWFwihYg1b3bjtpHNvBH6Ylr_chjnJ_wTM3Kp1iVVqje2PH7keK1RN18FWYk_zWT39T70YqqfM76acLEFx8hW62EIzMhZX-ocoD9kJN4inr-7LZxKCL9XjXaIrQ55VKU7JD7q6Vg8wj60_uha4ygVXt1BFs4uu6DQ9PhoDwDd3GMlPlf89Rx7IdxPq-yoxzy54v92EVOXgGjUL_KeaRbnlEQOwql',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.multiply,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 16.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                  ),
                ),
                Container(
                  width: 1.w,
                  height: double.infinity,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Grand Convention Center\nSector 7, Main Hall',
            style: AppTextStyle.getMonospace(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _TimelineCardTech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _BaseTechCard(
      title: 'TIMELINE',
      iconData: Icons.schedule,
      secCode: 'SEC-03',
      content: Column(
        children: [
          _RowTime('INFILTRATION', '17:00'),
          _RowTime('CEREMONY', '18:30', isHighlight: true),
          _RowTime('DEBRIEF', '20:30'),
        ],
      ),
    );
  }
}

class _RowTime extends StatelessWidget {
  final String label;
  final String time;
  final bool isHighlight;

  const _RowTime(this.label, this.time, {this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.getMonospace(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            time,
            style: AppTextStyle.getMonospace(
              fontWeight: FontWeightManager.bold,
              fontSize: 14,
              color: isHighlight ? AppColors.primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
