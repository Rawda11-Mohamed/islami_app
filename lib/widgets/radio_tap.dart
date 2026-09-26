import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/radio_container.dart';

class RadioTap extends StatefulWidget {
  RadioTap({super.key});
  @override
  State<RadioTap> createState() => _RadioTapState();
}

class _RadioTapState extends State<RadioTap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/Logo (1).png', width: 290, height: 130),
        Row(
          children: [
            Expanded(
              child: Container(
                width: 185,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Radio',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                width: 185,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Reciters',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 10),
              RadioContainer(text: 'Radio Ibrahim Al-Akdar'),
              SizedBox(height: 10),
              RadioContainer(text: 'Radio Al-Qaria Yassen'),
              SizedBox(height: 10),
              RadioContainer(text: 'Radio Ahmed Al-trabulsi'),
              SizedBox(height: 10),
              RadioContainer(text: 'Radio Addokali Mohammad Alalim'),
            ],
          ),
        ),
      ],
    );
  }
}
