import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graduation_ceremony/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/screens/landing_page/landing_page_viewmodel.dart';

// ======================================
// Desktop NavText (with hover + scroll callback)
// ======================================
class NavText extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const NavText(this.text, {super.key, this.onTap});

  @override
  State<NavText> createState() => _NavTextState();
}

class _NavTextState extends State<NavText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _isHovered ? AppColors.primary : Colors.transparent,
                  width: 2.h,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              widget.text,
              style:
                  AppTextStyle.getMonospace(
                    color: _isHovered
                        ? AppColors.primary
                        : (isDark ? AppColors.dmTextSecondary : Colors.black54),
                    fontSize: 12,
                    fontWeight: FontWeightManager.bold,
                    letterSpacing: 2.0,
                  ).copyWith(
                    shadows: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 8.r,
                            ),
                          ]
                        : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================
// Desktop Theme Toggle (sun/moon icon)
// ======================================
class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => ref.read(themeModeProvider.notifier).toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              key: ValueKey(isDark),
              color: AppColors.primary,
              size: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================
// Desktop Language Toggle
// ======================================
class LanguageToggle extends ConsumerStatefulWidget {
  const LanguageToggle({super.key});

  @override
  ConsumerState<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends ConsumerState<LanguageToggle> {
  bool _isHovered = false;

  void _switchLanguage(Locale locale) {
    LandingPageViewModel.switchLanguage(
      ref: ref,
      locale: locale,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovered ? AppColors.primary : Colors.transparent,
            width: 1.w,
          ),
          color: _isHovered
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: _isHovered
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _switchLanguage(const Locale('en')),
                    child: Text(
                      'EN',
                      style: AppTextStyle.getMonospace(
                        color: currentLocale == 'en'
                            ? AppColors.primary
                            : Colors.grey,
                        fontWeight: currentLocale == 'en'
                            ? FontWeightManager.bold
                            : FontWeightManager.regular,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    ' | ',
                    style: AppTextStyle.getMonospace(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _switchLanguage(const Locale('vi')),
                    child: Text(
                      'VN',
                      style: AppTextStyle.getMonospace(
                        color: currentLocale == 'vi'
                            ? AppColors.primary
                            : Colors.grey,
                        fontWeight: currentLocale == 'vi'
                            ? FontWeightManager.bold
                            : FontWeightManager.regular,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                '[ ${currentLocale == 'vi' ? 'VN' : 'EN'} ]',
                style: AppTextStyle.getMonospace(
                  color: AppColors.primary,
                  fontWeight: FontWeightManager.bold,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
