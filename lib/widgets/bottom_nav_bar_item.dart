import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarItem extends StatelessWidget {
  final bool isSelected;
  final String iconPath;
  const BottomNavBarItem({required this.isSelected, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          width: 59,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(66),
            color: Color(0x20202099),
          ),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        )
        : SvgPicture.asset(iconPath);
  }
}
