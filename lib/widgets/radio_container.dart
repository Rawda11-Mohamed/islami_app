import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadioContainer extends StatelessWidget {
  final String text;
  RadioContainer({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 141,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/shapes/image_bottom_decoration.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
          ),
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 9),
            Row(
              children: [
                Spacer(),
                SvgPicture.asset('assets/icons/play_icon.svg'),
                SizedBox(width: 7),
                SvgPicture.asset('assets/icons/sound_icon.svg'),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
