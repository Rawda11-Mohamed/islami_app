import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HadeethDetailsScreen extends StatefulWidget {
  final int? hadeethNum;
  HadeethDetailsScreen({super.key, required this.hadeethNum});

  @override
  State<HadeethDetailsScreen> createState() => _HadeethDetailsScreenState();
}

class _HadeethDetailsScreenState extends State<HadeethDetailsScreen> {
  List<String> hadeethText = [];
  Future<void> loadSurah() async {
    String text = await rootBundle.loadString(
      'assets/surahs_and_hadeeth/Hadeeth/h${widget.hadeethNum}.txt',
    );
    setState(() {
      hadeethText = text.split('\n');
    });
  }

  @override
  void initState() {
    super.initState();
    loadSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.primary),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Image.asset(
                  'assets/shapes/img_left_corner.png',
                  width: 92,
                  height: 92,
                ),

                Spacer(),
                Image.asset(
                  'assets/shapes/img_right_corner.png',
                  width: 92,
                  height: 92,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hadeethText.length,
              itemBuilder: (context, index) {
                return Text(
                  hadeethText[index],
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/shapes/image_bottom_decoration.png',
              height: 8,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
