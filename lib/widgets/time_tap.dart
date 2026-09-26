import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/time_container.dart';

class TimeTap extends StatefulWidget {
  TimeTap({super.key});
  @override
  State<TimeTap> createState() => _TimeTapState();
}

class _TimeTapState extends State<TimeTap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            children: [
              Image.asset(
                'assets/images/Logo (1).png',
                width: 290,
                height: 130,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 390,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/shapes/pray_time_shape.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                        color: Color(0xFF856B3F),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  '16 Jul\n 2024',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Pray Time\n Tuesday',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '09 Muh\n 1446',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                TimeContainer(
                                  time: '5:00',
                                  salah: 'Fajr',
                                  amOrPm: 'AM',
                                ),
                                TimeContainer(
                                  time: '1:00',
                                  salah: 'Zohr',
                                  amOrPm: 'PM',
                                ),
                                TimeContainer(
                                  time: '4:00',
                                  salah: 'Asr',
                                  amOrPm: 'PM',
                                ),
                                TimeContainer(
                                  time: '7:00',
                                  salah: 'Magrb',
                                  amOrPm: 'PM',
                                ),
                                TimeContainer(
                                  time: '8:10',
                                  salah: 'Eshaa',
                                  amOrPm: 'PM',
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Next Pray - 02:32',
                                style: TextStyle(color: AppColors.secondary),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/icons/sound_icon.svg',
                                  width: 23,
                                  height: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text('Azkar'),
              Row(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 160,
                      height: 255,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset('assets/images/Group 15.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 160,
                    height: 255,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset('assets/images/Group 16.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
