import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';

// ======================================
// 6. Footer Section
// ======================================
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 1.h,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
              SizedBox(height: 48.h),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 48.w,
                runSpacing: 24.h,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                        ),
                        child: Container(
                          color: AppColors.primary,
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.shield,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CLASS OF 2025', // Keeping this hardcoded as it's a specific noun/title
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            AppStrings.footerSecured.tr(),
                            style: AppTextStyle.getMonospace(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.grey,
                          size: 24.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.mail, color: Colors.grey, size: 24.sp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${AppStrings.footerSystemActive.tr()} VER. 2.5\nDIGITAL FORGE © 2025\n${AppStrings.footerTransmissionEnd.tr()}',
                    textAlign: TextAlign.right,
                    style: AppTextStyle.getMonospace(
                      color: Colors.grey,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
