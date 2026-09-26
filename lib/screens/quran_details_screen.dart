import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuranDetailsScreen extends StatefulWidget {
  final String surahName;
  final int? surahNum;
  QuranDetailsScreen({super.key, required this.surahName, this.surahNum});

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  List<String> ayat = [];
  Future<void> loadSurah() async {
    String text = await rootBundle.loadString(
      'assets/surahs_and_hadeeth/Suras/${widget.surahNum}.txt',
    );
    setState(() {
      ayat = text.split('\n');
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
        title: Text(
          widget.surahName,
          style: TextStyle(color: AppColors.primary),
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
                Text(
                  widget.surahName,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
              itemCount: ayat.length,
              itemBuilder: (context, index) {
                return Text(
                  ayat[index],
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
