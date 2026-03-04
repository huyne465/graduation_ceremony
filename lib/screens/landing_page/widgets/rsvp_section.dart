import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';

// ======================================
// 5. RSVP Section
// ======================================
class RsvpSection extends StatelessWidget {
  const RsvpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 96.h),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900.w),
          child: Container(
            // The black container
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
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
                          'CONFIRM ATTENDANCE',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.getDisplayLarge(
                            color: Colors.white,
                          ).copyWith(fontSize: 48.sp),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'RESPONSE REQUIRED. DEADLINE IMMINENT.',
                          style: AppTextStyle.getMonospace(
                            color: Colors.grey,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 40.h),

                        // Tech Button
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.fingerprint,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          label: Text(
                            'INITIATE RSVP',
                            style: AppTextStyle.getMonospace(
                              color: Colors.white,
                              fontWeight: FontWeightManager.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 24.h,
                            ),
                          ).copyWith(elevation: WidgetStateProperty.all(0)),
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
