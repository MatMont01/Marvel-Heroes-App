import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color silverColor = Color(0xFFC0C0C0);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color redColor = Color(0xFFED1D24);
  static const Color greyColor = Color(0xFF808080);
  static const Color darkColor = Color(0xFF000000);
  static const Color greenColor = Color(0xFF00FF00);
  static const Color blackColor = Color(0xFF000000);

  // Existing styles
  static const TextStyle heavy20px = TextStyle(
    fontFamily: 'Heavy',
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle medium10px = TextStyle(
    fontFamily: 'Medium',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle bold18px = TextStyle(
    fontFamily: 'Bold',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: redColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle medium14px = TextStyle(
    fontFamily: 'Medium',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: greyColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle semibold14px = TextStyle(
    fontFamily: 'SemiBold',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: greyColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle heavy32px = TextStyle(
    fontFamily: 'Heavy',
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: darkColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle heavy40px = TextStyle(
    fontFamily: 'Heavy',
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle medium16px = TextStyle(
    fontFamily: 'Medium',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle medium12px = TextStyle(
    fontFamily: 'Medium',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static const TextStyle regular12px = TextStyle(
    fontFamily: 'Regular',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: whiteColor,
    letterSpacing: 1.2,
    height: 1.2,
  );

  static BoxDecoration boxShadow(Color color) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.12),
          spreadRadius: 1,
          blurRadius: 20,
          offset: Offset(0, 12),
        ),
      ],
    );
  }

  static BoxDecoration gradientBackground(Color startColor, Color endColor) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [startColor, endColor],
      ),
      borderRadius: BorderRadius.circular(28),
    );
  }
}
