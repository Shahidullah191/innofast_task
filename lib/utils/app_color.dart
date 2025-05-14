import 'package:flutter/material.dart';

extension AppColors on ColorScheme {
  static Color get confirmedOrderColor => const Color(0xff009EA8);
  static Color get startedOrderColor => const Color(0xff0079FF);
  static Color get rescheduledOrderColor => const Color(0xffFF9900);
  static Color get cancelledOrderColor => const Color(0xffC60000);
  static Color get completedOrderColor => const Color(0xff1E9400);
  static Color get pendingPaymentStatusColor => const Color(0xffFF9900);
  static Color get failedPaymentStatusColor => const Color(0xffC60000);
  static Color get successPaymentStatusColor => const Color(0xff1E9400);
}
