import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_ceremony/theme/app_colors.dart';

class CyberHoverBuilder extends StatefulWidget {
  final Widget child;
  final bool enableGlow;
  final bool enableScale;
  final bool enableBorder;
  final Color? glowColor;

  const CyberHoverBuilder({
    super.key,
    required this.child,
    this.enableGlow = true,
    this.enableScale = true,
    this.enableBorder = false,
    this.glowColor,
  });

  @override
  State<CyberHoverBuilder> createState() => _CyberHoverBuilderState();
}

class _CyberHoverBuilderState extends State<CyberHoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = widget.glowColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutExpo,
        transform: _isHovered && widget.enableScale
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          boxShadow: _isHovered && widget.enableGlow
              ? [
                  BoxShadow(
                    color: effectiveGlowColor.withValues(alpha: 0.6),
                    blurRadius: 15.r,
                    spreadRadius: 2.r,
                  ),
                ]
              : [],
          border: widget.enableBorder
              ? Border.all(
                  color: _isHovered ? effectiveGlowColor : Colors.transparent,
                  width: 1.w,
                )
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}
