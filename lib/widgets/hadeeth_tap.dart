import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../screens/hadeeth_details_screen.dart';

class HadeethTap extends StatefulWidget {
  HadeethTap({super.key});
  @override
  State<HadeethTap> createState() => _HadeethTapState();
}

class _HadeethTapState extends State<HadeethTap> {
  List<String> hadeeth = [];
  Future<void> loadHadeeth() async {
    List<String> loadedHadeeth = [];
    for (int i = 1; i <= 50; i++) {
      String text = await rootBundle.loadString(
        'assets/surahs_and_hadeeth/Hadeeth/h$i.txt',
      );
      loadedHadeeth.add(text);
    }
    setState(() {
      hadeeth = loadedHadeeth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHadeeth();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/Logo (1).png', width: 290, height: 130),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hadeeth.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HadeethDetailsScreen(hadeethNum: index + 1);
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/shapes/img_left_corner.png',
                            color: AppColors.secondary,
                            width: 93,
                            height: 100,
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/shapes/img_right_corner.png',
                            color: AppColors.secondary,
                            width: 93,
                            height: 100,
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              hadeeth[index],
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/shapes/image_bottom_decoration.png',
                        color: AppColors.secondary,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
