import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graduation_ceremony/providers/app_state_provider.dart';
import 'package:graduation_ceremony/providers/theme_provider.dart';

// ======================================
// 1. Header (Sticky)
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
    final iconColor = Colors.white;
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
            child: Icon(Icons.code, color: iconColor, size: 20.sp),
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
              _NavText(AppStrings.navBriefing.tr(), onTap: onBriefingTap),
              _NavText(AppStrings.navIntel.tr(), onTap: onIntelTap),
              _NavText(AppStrings.navExtract.tr(), onTap: onExtractTap),
              SizedBox(width: 16.w),
              const _ThemeToggle(),
              SizedBox(width: 8.w),
              const _LanguageToggle(),
              SizedBox(width: 24.w),
              // Dummy barcode
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
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: 'Mobile Menu',
                barrierColor: Colors.black54,
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, anim1, anim2) {
                  return _MobileMenuOverlay(
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
                    position:
                        Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: anim1,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  );
                },
              );
            },
          ),
      ],
    );
  }
}

// ======================================
// Theme Toggle (sun/moon icon)
// ======================================
class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle();

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
// Mobile Menu Overlay (Cyberpunk style)
// ======================================
class _MobileMenuOverlay extends StatelessWidget {
  final VoidCallback? onBriefingTap;
  final VoidCallback? onIntelTap;
  final VoidCallback? onExtractTap;

  const _MobileMenuOverlay({
    this.onBriefingTap,
    this.onIntelTap,
    this.onExtractTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceDark.withValues(alpha: 0.97),
            border: Border(
              left: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.6),
                width: 2.w,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 30.r,
                offset: Offset(-10.w, 0),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 28.sp,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height: 16.h),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    '// NAVIGATION',
                    style: AppTextStyle.getMonospace(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      fontSize: 10,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 1.h,
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),

                // Nav items
                _MobileNavItem(
                  text: AppStrings.navBriefing.tr(),
                  index: '01',
                  onTap: onBriefingTap,
                ),
                _MobileNavItem(
                  text: AppStrings.navIntel.tr(),
                  index: '02',
                  onTap: onIntelTap,
                ),
                _MobileNavItem(
                  text: AppStrings.navExtract.tr(),
                  index: '03',
                  onTap: onExtractTap,
                ),

                SizedBox(height: 32.h),

                // Language section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    '// LANGUAGE',
                    style: AppTextStyle.getMonospace(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      fontSize: 10,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 1.h,
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),

                // Language switcher for mobile
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _MobileLanguageToggle(),
                ),

                SizedBox(height: 32.h),

                // Theme section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    '// THEME',
                    style: AppTextStyle.getMonospace(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      fontSize: 10,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 1.h,
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                SizedBox(height: 16.h),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _MobileThemeToggle(),
                ),

                const Spacer(),

                // Bottom decoration
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'SYSTEM.V2.4.1\nSTATUS: ONLINE',
                    style: AppTextStyle.getMonospace(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      fontSize: 9,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================
// Mobile Nav Item with neon hover
// ======================================
class _MobileNavItem extends StatefulWidget {
  final String text;
  final String index;
  final VoidCallback? onTap;

  const _MobileNavItem({required this.text, required this.index, this.onTap});

  @override
  State<_MobileNavItem> createState() => _MobileNavItemState();
}

class _MobileNavItemState extends State<_MobileNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.15),
                width: 2.w,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.index,
                style: AppTextStyle.getMonospace(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                widget.text,
                style: AppTextStyle.getMonospace(
                  color: _isHovered ? Colors.white : AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeightManager.bold,
                  letterSpacing: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================
// Mobile Language Toggle
// ======================================
class _MobileLanguageToggle extends ConsumerStatefulWidget {
  const _MobileLanguageToggle();

  @override
  ConsumerState<_MobileLanguageToggle> createState() =>
      _MobileLanguageToggleState();
}

class _MobileLanguageToggleState extends ConsumerState<_MobileLanguageToggle> {
  Future<void> _switchLanguage(Locale locale) async {
    if (ref.read(isLoadingProvider)) return;

    // Capture references BEFORE popping (pop disposes this widget)
    final notifier = ref.read(isLoadingProvider.notifier);
    final easyLoc = EasyLocalization.of(context);

    Navigator.of(context).pop(); // Close drawer

    notifier.setLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));

    easyLoc?.setLocale(locale);

    await Future.delayed(const Duration(milliseconds: 1000));

    notifier.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;

    return Row(
      children: [
        _langButton('EN', 'en', currentLocale),
        SizedBox(width: 12.w),
        _langButton('VN', 'vi', currentLocale),
      ],
    );
  }

  Widget _langButton(String label, String code, String currentLocale) {
    final isActive = currentLocale == code;
    return GestureDetector(
      onTap: () => _switchLanguage(Locale(code)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.3),
            width: 1.w,
          ),
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
        child: Text(
          label,
          style: AppTextStyle.getMonospace(
            color: isActive ? AppColors.primary : Colors.white54,
            fontWeight: isActive
                ? FontWeightManager.bold
                : FontWeightManager.regular,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ======================================
// Mobile Theme Toggle
// ======================================
class _MobileThemeToggle extends ConsumerWidget {
  const _MobileThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _modeButton(
          icon: Icons.wb_sunny_rounded,
          label: 'LIGHT',
          isActive: !isDark,
          onTap: () {
            if (isDark) ref.read(themeModeProvider.notifier).toggle();
          },
        ),
        SizedBox(width: 12.w),
        _modeButton(
          icon: Icons.nightlight_round,
          label: 'DARK',
          isActive: isDark,
          onTap: () {
            if (!isDark) ref.read(themeModeProvider.notifier).toggle();
          },
        ),
      ],
    );
  }

  Widget _modeButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.3),
            width: 1.w,
          ),
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : Colors.white54,
              size: 14.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyle.getMonospace(
                color: isActive ? AppColors.primary : Colors.white54,
                fontWeight: isActive
                    ? FontWeightManager.bold
                    : FontWeightManager.regular,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================
// Desktop NavText (with hover + scroll callback)
// ======================================
class _NavText extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _NavText(this.text, {this.onTap});

  @override
  State<_NavText> createState() => _NavTextState();
}

class _NavTextState extends State<_NavText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
                        : (Theme.of(context).brightness == Brightness.dark
                              ? AppColors.dmTextSecondary
                              : Colors.black54),
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
// Desktop Language Toggle
// ======================================
class _LanguageToggle extends ConsumerStatefulWidget {
  const _LanguageToggle();

  @override
  ConsumerState<_LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends ConsumerState<_LanguageToggle> {
  bool _isHovered = false;

  Future<void> _switchLanguage(Locale locale) async {
    if (ref.read(isLoadingProvider)) return;

    ref.read(isLoadingProvider.notifier).setLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      context.setLocale(locale);
    }

    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      ref.read(isLoadingProvider.notifier).setLoading(false);
    }
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
