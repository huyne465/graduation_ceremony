import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';

class RsvpFormDialog extends StatefulWidget {
  const RsvpFormDialog({super.key});

  @override
  State<RsvpFormDialog> createState() => _RsvpFormDialogState();
}

class _RsvpFormDialogState extends State<RsvpFormDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? 0.9.sw : 600.w,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.dmSurface.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.95),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.6),
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 30.r,
                spreadRadius: 5.r,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1.w,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.rsvpFormTitle.tr(),
                      style: AppTextStyle.getMonospace(
                        color: AppColors.primary,
                        fontSize: isMobile ? 24 : 16,
                        letterSpacing: 2.0,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.primary,
                        size: isMobile ? 28.sp : 24.sp,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      AppStrings.rsvpFormName.tr(),
                      _nameController,
                      isMobile,
                      isDark,
                    ),
                    SizedBox(height: 24.h),
                    _buildInputField(
                      AppStrings.rsvpFormPhone.tr(),
                      _phoneController,
                      isMobile,
                      isDark,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 24.h),
                    _buildInputField(
                      AppStrings.rsvpFormEmail.tr(),
                      _emailController,
                      isMobile,
                      isDark,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 48.h),

                    // Submit action
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle submission logic
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.hovered)) {
                                  return AppColors.neonBlue.withValues(
                                    alpha: 0.2,
                                  );
                                }
                                return AppColors.primary;
                              }),
                          elevation: WidgetStateProperty.resolveWith<double>(
                            (Set<WidgetState> states) =>
                                states.contains(WidgetState.hovered)
                                ? 15.0
                                : 0.0,
                          ),
                          shape:
                              WidgetStateProperty.resolveWith<OutlinedBorder>((
                                Set<WidgetState> states,
                              ) {
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
                              }),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(vertical: 24.h),
                          ),
                        ),
                        child: Text(
                          AppStrings.rsvpFormSubmit.tr(),
                          style: AppTextStyle.getMonospace(
                            color: Colors.white,
                            fontWeight: FontWeightManager.bold,
                            letterSpacing: 2,
                            fontSize: isMobile ? 24 : 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    bool isMobile,
    bool isDark, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4.w, height: 4.h, color: AppColors.primary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyle.getMonospace(
                color: isDark ? Colors.grey[400] : Colors.grey[700],
                fontSize: isMobile ? 20 : 12,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyle.getMonospace(
            fontSize: isMobile ? 28 : 16,
            color: isDark ? AppColors.dmTextPrimary : Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: isMobile ? 20.h : 16.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: AppColors.primary, width: 2.w),
            ),
            filled: true,
            fillColor: isDark ? Colors.black26 : Colors.grey[100],
          ),
          cursorColor: AppColors.primary,
        ),
      ],
    );
  }
}
