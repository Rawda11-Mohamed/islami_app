import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SebhaTap extends StatefulWidget {
  const SebhaTap({super.key});

  @override
  State<SebhaTap> createState() => _SebhaTapState();
}

class _SebhaTapState extends State<SebhaTap>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  int currentIndex = 0;
  int counter = 0;

  double currentAngle = 0;

  final double anglePerTap = (2 * 3.14159265359) / 33;

  final List<String> sebha = ['سبحان الله', 'الحمد لله', 'الله أكبر'];

  @override
  void initState() {
    super.initState();

    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    rotationAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(rotationController);
  }

  void rotateSebha() {
    final double newAngle = currentAngle + anglePerTap;

    rotationAnimation = Tween<double>(
      begin: currentAngle,
      end: newAngle,
    ).animate(
      CurvedAnimation(parent: rotationController, curve: Curves.easeOut),
    );

    currentAngle = newAngle;

    rotationController
      ..reset()
      ..forward();
  }

  void onSebhaTap() {
    setState(() {
      counter++;

      if (counter == 33) {
        counter = 0;

        if (currentIndex < sebha.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
      }
    });

    rotateSebha();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/Logo (1).png'),

        Text(
          'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
          style: TextStyle(color: AppColors.white, fontSize: 36),
        ),

        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating Sebha
              AnimatedBuilder(
                animation: rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: rotationAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/shapes/SebhaBody 1.png',
                  width: 300,
                  height: 400,
                ),
              ),

              // Tap area + text
              GestureDetector(
                onTap: onSebhaTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      sebha[currentIndex],
                      style: TextStyle(color: AppColors.white, fontSize: 36),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '$counter',
                      style: TextStyle(color: AppColors.white, fontSize: 36),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
