import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_ceremony/providers/app_state_provider.dart';

/// ViewModel chứa logic dùng chung cho Landing Page.
class LandingPageViewModel {
  LandingPageViewModel._();

  /// Chuyển đổi ngôn ngữ với shimmer overlay.
  static Future<void> switchLanguage({
    required WidgetRef ref,
    required Locale locale,
    required BuildContext context,
    VoidCallback? onBeforeSwitch,
  }) async {
    if (ref.read(isLoadingProvider)) return;

    // Capture tất cả references TRƯỚC khi pop (vì pop dispose context)
    final locDelegate = EasyLocalization.of(context);
    final loadingNotifier = ref.read(isLoadingProvider.notifier);

    // Pop drawer (nếu có)
    onBeforeSwitch?.call();

    // Show shimmer
    loadingNotifier.setLoading(true);

    try {
      await Future.delayed(const Duration(milliseconds: 200));

      // Đổi locale — wrap trong try/catch vì delegate có thể bị lỗi
      // sau khi drawer dispose
      try {
        locDelegate?.setLocale(locale);
      } catch (e) {
        debugPrint('[ViewModel] setLocale error: $e');
      }

      await Future.delayed(const Duration(milliseconds: 1000));
    } finally {
      // ĐẢM BẢO shimmer luôn tắt dù có exception hay không
      loadingNotifier.setLoading(false);
    }
  }
}
