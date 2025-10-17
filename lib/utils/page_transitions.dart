import 'package:flutter/material.dart';

/// Custom page transitions for smoother navigation
class PageTransitions {
  /// Fade transition only - simplest and smoothest
  static Route<T> fadeTransition<T>({
    required Widget page,
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      opaque: true,
      barrierColor: null,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
          reverseCurve: Curves.easeInOutCubic,
        );

        // Fade out the old page
        final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeInOutCubic,
          ),
        );

        return Stack(
          children: [
            FadeTransition(
              opacity: fadeOut,
              child: Container(color: Colors.transparent),
            ),
            FadeTransition(
              opacity: fadeTween.animate(curvedAnimation),
              child: child,
            ),
          ],
        );
      },
    );
  }

  /// Fade and slide transition
  static Route<T> fadeSlideTransition<T>({
    required Widget page,
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      opaque: true,
      barrierColor: null,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.02);
        const end = Offset.zero;
        final slideTween = Tween(begin: begin, end: end);
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: fadeTween.animate(curvedAnimation),
          child: SlideTransition(
            position: slideTween.animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  /// Shared axis transition (Material Design 3) - improved version
  static Route<T> sharedAxisTransition<T>({
    required Widget page,
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      opaque: true,
      barrierColor: null,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Entering page slides from right and fades in
        final enterSlide = Tween<Offset>(
          begin: const Offset(0.03, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
        ));

        final enterFade = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ));

        // Exiting page slides to left and fades out
        final exitSlide = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.03, 0.0),
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: const Interval(0.0, 0.7, curve: Curves.easeInCubic),
        ));

        final exitFade = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
        ));

        return Stack(
          children: [
            SlideTransition(
              position: exitSlide,
              child: FadeTransition(
                opacity: exitFade,
                child: Container(color: Colors.transparent),
              ),
            ),
            SlideTransition(
              position: enterSlide,
              child: FadeTransition(
                opacity: enterFade,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Scale and fade transition
  static Route<T> scaleFadeTransition<T>({
    required Widget page,
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      opaque: true,
      barrierColor: null,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
