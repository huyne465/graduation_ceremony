import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/theme/app_strings.dart';

// ======================================
// 3. Operation Section
// ======================================
class OperationDateSection extends StatelessWidget {
  const OperationDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 24.w),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100.w),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left block
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[ ${AppStrings.operationDateTitle.tr()} ]',
                    style: AppTextStyle.getMonospace(
                      color: Colors.grey,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    '${AppStrings.operationDateMonthValue.tr()} ${AppStrings.operationDateDayValue.tr()}RD',
                    style: AppTextStyle.getDisplayMedium().copyWith(
                      fontSize: 60.sp,
                      letterSpacing: -1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: AppColors.primary, width: 4.w),
                      ),
                    ),
                    child: Text(
                      '1700 HOURS', // Will keep this as hardcoded for now, or you can add to localization if needed
                      style: AppTextStyle.getMonospace(
                        fontSize: 18,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ),
                ],
              ),

              if (!isMobile)
                Transform.rotate(
                  angle: 12 * pi / 180,
                  child: Container(
                    width: 1.w,
                    height: 128.h,
                    color: Colors.grey[300],
                  ),
                ),

              if (isMobile) SizedBox(height: 32.h),

              // Right Block
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),
                width: isMobile ? double.infinity : 400.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.h,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '[ CANDIDATE PROFILE ]',
                          style: AppTextStyle.getMonospace(
                            color: Colors.grey,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Highly trained and ready for deployment into the real world. Specialized in critical thinking and problem-solving. This mission marks the completion of phase one.',
                      style: AppTextStyle.getBodyLarge().copyWith(height: 1.5),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.circle, size: 8.sp, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Icon(Icons.circle, size: 8.sp, color: Colors.grey),
                      ],
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
}
