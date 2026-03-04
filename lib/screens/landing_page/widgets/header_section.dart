import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';

import 'header_desktop.dart';
import 'header_mobile.dart';

// ======================================
// Header (Sticky SliverAppBar)
// ======================================
class Header extends StatelessWidget {
  final VoidCallback? onBriefingTap;
  final VoidCallback? onIntelTap;
  final VoidCallback? onExtractTap;

  const Header({
    super.key,
    this.onBriefingTap,
    this.onIntelTap,
    this.onExtractTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final headerBg = isDark
        ? AppColors.dmSurface.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.9);
    final iconBoxColor = isDark ? AppColors.primary : Colors.black;
    final menuIconColor = isDark ? AppColors.dmTextPrimary : Colors.black;
    final borderColor = isDark ? AppColors.dmBorder : Colors.grey[300];

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: headerBg,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(color: borderColor, height: 1.h),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            color: iconBoxColor,
            child: Icon(Icons.code, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          RichText(
            text: TextSpan(
              style: AppTextStyle.getTitleLarge().copyWith(
                fontWeight: FontWeightManager.bold,
                letterSpacing: -0.5,
                color: isDark ? AppColors.dmTextPrimary : null,
              ),
              children: [
                TextSpan(text: AppStrings.target.tr()),
                TextSpan(
                  text: AppStrings.graduation.tr(),
                  style: const TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (!isMobile)
          Row(
            children: [
              NavText(AppStrings.navBriefing.tr(), onTap: onBriefingTap),
              NavText(AppStrings.navIntel.tr(), onTap: onIntelTap),
              NavText(AppStrings.navExtract.tr(), onTap: onExtractTap),
              SizedBox(width: 16.w),
              const ThemeToggle(),
              SizedBox(width: 8.w),
              const LanguageToggle(),
              SizedBox(width: 24.w),
              SizedBox(
                width: 128.w,
                height: 24.h,
                child: SvgPicture.asset('assets/svg/p_code.svg', width: 100.w),
              ),
              SizedBox(width: 16.w),
            ],
          )
        else
          IconButton(
            icon: Icon(Icons.menu, color: menuIconColor, size: 24.sp),
            onPressed: () => _showMobileMenu(context),
          ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Mobile Menu',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return MobileMenuOverlay(
          onBriefingTap: () {
            Navigator.of(context).pop();
            onBriefingTap?.call();
          },
          onIntelTap: () {
            Navigator.of(context).pop();
            onIntelTap?.call();
          },
          onExtractTap: () {
            Navigator.of(context).pop();
            onExtractTap?.call();
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }
}
