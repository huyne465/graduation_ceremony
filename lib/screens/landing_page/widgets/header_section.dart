import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';
import 'package:graduation_ceremony/theme/app_text_style.dart';

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
                const TextSpan(text: 'TARGET: '),
                TextSpan(
                  text: 'GRADUATION',
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
              const _NavText('BRIEFING'),
              const _NavText('INTEL'),
              const _NavText('EXTRACT'),
              SizedBox(width: 24.w),
              // Dummy barcode
              Container(
                width: 128.w,
                height: 24.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/e/e9/UPC-A-036000291452.svg',
                    ),
                    fit: BoxFit.fill,
                    opacity: 0.5,
                  ),
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

class _NavText extends StatelessWidget {
  final String text;
  const _NavText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        text,
        style: AppTextStyle.getMonospace(
          color: Colors.black54,
          fontSize: 12,
          fontWeight: FontWeightManager.bold,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
