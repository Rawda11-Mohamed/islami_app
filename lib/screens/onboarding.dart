import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../screens/main_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController pageController = PageController();
  List<Map<String, String>> pages = [
    {'image': 'assets/images/ترحب بكم.png', 'title': 'Welcome To Islmi App'},
    {
      'image': 'assets/images/masjid.png',
      'title': 'Welcome To Islami',
      'describtion': 'We Are Very Excited To Have You In Our Community',
    },
    {
      'image': 'assets/images/moshaf.png',
      'title': 'Reading the Quran',
      'describtion': 'Read, and your Lord is the Most Generous',
    },
    {
      'image': 'assets/images/duaa.png',
      'title': 'Bearish',
      'describtion': 'Praise the name of your Lord, the Most High',
    },
    {
      'image': 'assets/images/mice.png',
      'title': 'Holy Quran Radio',
      'describtion':
          'You can listen to the Holy Quran Radio through the application for free and easily',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/Logo (1).png', width: 290, height: 130),
            Expanded(
              child: PageView.builder(
                itemCount: pages.length,
                controller: pageController,
                onPageChanged: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Image.asset(pages[index]['image']!)),
                      SizedBox(height: 40),
                      Text(
                        pages[index]['title']!,
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Text(
                          pages[index]['describtion'] ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  TextButton(
                    onPressed:
                        currentIndex == 0
                            ? null
                            : () {
                              pageController.previousPage(
                                curve: Curves.bounceIn,
                                duration: Duration(milliseconds: 300),
                              );
                            },
                    child: Text(
                      'Back',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 5,
                      effect: WormEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        dotColor: Colors.grey,
                        activeDotColor: AppColors.primary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        currentIndex == pages.length - 1
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            }
                            : () {
                              pageController.nextPage(
                                curve: Curves.bounceIn,
                                duration: Duration(milliseconds: 300),
                              );
                            },
                    child: Text(
                      currentIndex == 4 ? 'Finsh' : 'Next',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
