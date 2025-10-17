import 'package:flutter/material.dart';
import 'dart:ui';

/// Base widget for authentication screens with common styling
class BaseAuthScreen extends StatelessWidget {
  final Widget child;
  final Duration animationDuration;

  const BaseAuthScreen({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB8B5D4),
              Color(0xFFD4B5C8),
              Color(0xFFE8C5D8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass card wrapper with backdrop filter
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final String? heroTag;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 32,
    this.padding = const EdgeInsets.all(32),
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );

    // Removed Hero animation to prevent conflicts with page transitions
    return card;
  }
}

/// Reusable input field with consistent styling
class GlassInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final double fontSize;
  final double iconSize;

  const GlassInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.errorText,
    this.onChanged,
    this.fontSize = 16,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: errorText != null
                      ? Colors.red.withOpacity(0.5)
                      : Colors.white.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: controller,
                obscureText: isPassword && obscureText,
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: fontSize,
                  color: const Color(0xFF2D3142),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: const Color(0xFF2D3142).withOpacity(0.4),
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: const Color(0xFF2D3142).withOpacity(0.5),
                    size: iconSize,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return RotationTransition(
                                turns: animation,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              key: ValueKey(obscureText),
                              color: const Color(0xFF2D3142).withOpacity(0.5),
                              size: iconSize - 2,
                            ),
                          ),
                          onPressed: onToggleVisibility,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        if (errorText != null)
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, -10 * (1 - value)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            errorText!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
