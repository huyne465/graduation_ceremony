import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graduation_ceremony/providers/app_state_provider.dart';

// ======================================
// 1. Header (Sticky)
// ======================================
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(color: Colors.grey[300], height: 1.h),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            color: Colors.black,
            child: Icon(Icons.code, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          RichText(
            text: TextSpan(
              style: AppTextStyle.getTitleLarge().copyWith(
                fontWeight: FontWeightManager.bold,
                letterSpacing: -0.5,
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
        if (MediaQuery.of(context).size.width > 768)
          Row(
            children: [
              _NavText(AppStrings.navBriefing.tr()),
              _NavText(AppStrings.navIntel.tr()),
              _NavText(AppStrings.navExtract.tr()),
              SizedBox(width: 24.w),
              const _LanguageToggle(),
              SizedBox(width: 24.w),
              // Dummy barcode
              Container(
                width: 128.w,
                height: 24.h,
                child: SvgPicture.asset(
                  'assets/svg/p_code.svg',
                  width: 100.w, // Có thể chỉnh kích thước
                ),
              ),
              SizedBox(width: 16.w),
            ],
          )
        else
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 24.sp),
            onPressed: () {},
          ),
      ],
    );
  }
}

class _NavText extends StatefulWidget {
  final String text;
  const _NavText(this.text);

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
                  color: _isHovered ? AppColors.primary : Colors.black54,
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
    );
  }
}

class _LanguageToggle extends ConsumerStatefulWidget {
  const _LanguageToggle();

  @override
  ConsumerState<_LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends ConsumerState<_LanguageToggle> {
  bool _isHovered = false;

  Future<void> _switchLanguage(Locale locale) async {
    // Prevent clicking if already loading
    if (ref.read(isLoadingProvider)) return;

    // 1. Show shimmer overlay
    ref.read(isLoadingProvider.notifier).setLoading(true);

    // 2. Small delay to let shimmer render visibly
    await Future.delayed(const Duration(milliseconds: 200));

    // 3. Switch locale (synchronous, triggers rebuild)
    if (mounted) {
      context.setLocale(locale);
    }

    // 4. Wait for the frame to finish rebuilding with new locale
    await Future.delayed(const Duration(milliseconds: 1000));

    // 5. Hide shimmer – content underneath already has new translations
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
