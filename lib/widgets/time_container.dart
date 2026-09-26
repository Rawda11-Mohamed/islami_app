import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TimeContainer extends StatelessWidget {
  final String salah;
  final String time;
  final String amOrPm;
  TimeContainer({
    super.key,
    required this.time,
    required this.salah,
    required this.amOrPm,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(18),
      width: 86,
      height: 106,
      decoration: BoxDecoration(
        color: AppColors.secondary.withAlpha(200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 10,
        children: [
          Text(salah, style: TextStyle(color: AppColors.white, fontSize: 20)),
          Text(time, style: TextStyle(color: AppColors.white, fontSize: 24)),
          Text(amOrPm, style: TextStyle(color: AppColors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
