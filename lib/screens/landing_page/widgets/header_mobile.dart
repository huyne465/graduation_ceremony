import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graduation_ceremony/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';
import 'package:graduation_ceremony/providers/app_state_provider.dart';

// ======================================
// Mobile Menu Overlay (Cyberpunk style)
// ======================================
class MobileMenuOverlay extends StatelessWidget {
  final VoidCallback? onBriefingTap;
  final VoidCallback? onIntelTap;
  final VoidCallback? onExtractTap;

  const MobileMenuOverlay({
    super.key,
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
                      fontSize: 28,
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
                MobileNavItem(
                  text: AppStrings.navBriefing.tr(),
                  index: '01',
                  onTap: onBriefingTap,
                ),
                MobileNavItem(
                  text: AppStrings.navIntel.tr(),
                  index: '02',
                  onTap: onIntelTap,
                ),
                MobileNavItem(
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

                // Language switcher
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: MobileLanguageToggle(),
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
                  child: MobileThemeToggle(),
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
class MobileNavItem extends StatefulWidget {
  final String text;
  final String index;
  final VoidCallback? onTap;

  const MobileNavItem({
    super.key,
    required this.text,
    required this.index,
    this.onTap,
  });

  @override
  State<MobileNavItem> createState() => _MobileNavItemState();
}

class _MobileNavItemState extends State<MobileNavItem> {
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
                  fontSize: 28,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                widget.text,
                style: AppTextStyle.getMonospace(
                  color: _isHovered ? Colors.white : AppColors.primary,
                  fontSize: 28,
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
class MobileLanguageToggle extends ConsumerStatefulWidget {
  const MobileLanguageToggle({super.key});

  @override
  ConsumerState<MobileLanguageToggle> createState() =>
      _MobileLanguageToggleState();
}

class _MobileLanguageToggleState extends ConsumerState<MobileLanguageToggle> {
  Future<void> _switchLanguage(Locale locale) async {
    if (ref.read(isLoadingProvider)) return;

    // 1. Capture references TRƯỚC khi pop
    final nav = Navigator.of(context);
    final loadingNotifier = ref.read(isLoadingProvider.notifier);

    // 2. Set locale TRƯỚC khi pop (context còn mounted)
    context.setLocale(locale);

    // 3. Pop drawer
    nav.pop();

    // 4. Show shimmer + wait + hide
    loadingNotifier.setLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
    } finally {
      loadingNotifier.setLoading(false);
    }
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
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

// ======================================
// Mobile Theme Toggle
// ======================================
class MobileThemeToggle extends ConsumerWidget {
  const MobileThemeToggle({super.key});

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
