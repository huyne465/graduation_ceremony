import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';
import 'rsvp_form_dialog.dart';

// ======================================
// 5. RSVP Section
// ======================================
class RsvpSection extends StatelessWidget {
  const RsvpSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 96.h),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900.w),
          child: Container(
            // The black container
            decoration: BoxDecoration(
              color: isDark ? AppColors.dmSurface : Colors.black,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : Colors.black38,
                  blurRadius: 30.r,
                  offset: Offset(0, 15.h),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  height: 4.h,
                  width: double.infinity,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 64.h,
                      horizontal: 32.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.rsvpTitle.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyle.getDisplayLarge(
                            color: Colors.white,
                          ).copyWith(fontSize: 48.sp),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppStrings.rsvpSubtitle.tr(),
                          style: AppTextStyle.getMonospace(
                            color: Colors.grey,
                            fontSize: isMobile ? 28 : 14,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 40.h),

                        // Tech Button
                        ElevatedButton(
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'RSVP Form',
                              barrierColor: Colors.black.withValues(alpha: 0.8),
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder: (context, anim1, anim2) {
                                return const RsvpFormDialog();
                              },
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
                                    return FadeTransition(
                                      opacity: anim1,
                                      child: ScaleTransition(
                                        scale:
                                            Tween<double>(
                                              begin: 0.95,
                                              end: 1.0,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: anim1,
                                                curve: Curves.easeOutCubic,
                                              ),
                                            ),
                                        child: child,
                                      ),
                                    );
                                  },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return AppColors.neonBlue.withValues(
                                      alpha: 0.2,
                                    ); // Hover glow background
                                  }
                                  return AppColors.primary; // Default Red
                                }),
                            elevation: WidgetStateProperty.resolveWith<double>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.hovered)) {
                                return 15.0; // Raise on hover
                              }
                              return 0.0;
                            }),
                            shadowColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return AppColors.neonBlue;
                                }
                                return Colors.transparent;
                              },
                            ),
                            shape:
                                WidgetStateProperty.resolveWith<OutlinedBorder>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.hovered)) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                          color: AppColors.neonBlue,
                                          width: 2.w,
                                        ),
                                      );
                                    }
                                    return const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide.none,
                                    );
                                  },
                                ),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 24.h,
                              ),
                            ),
                          ),
                          child: Builder(
                            builder: (context) {
                              // Builder gives us context below the button to get states if needed
                              // But for simple internal changes, we can just use the button style
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    AppStrings.rsvpButton.tr(),
                                    style: AppTextStyle.getMonospace(
                                      color: Colors.white,
                                      fontWeight: FontWeightManager.bold,
                                      letterSpacing: 2,
                                      fontSize: isMobile ? 30 : 16,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
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
