import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami/models/most_recent_model.dart';
import '../constants/colors.dart';
import '../screens/quran_details_screen.dart';

class QuranTap extends StatefulWidget {
  final List<String> surahNames;
  final List<int> surahNums;
  final List<String> surahNamesEnglish;
  final List<String> surahAyatNums;

  const QuranTap({
    super.key,
    required this.surahNames,
    required this.surahNums,
    required this.surahAyatNums,
    required this.surahNamesEnglish,
  });

  @override
  State<QuranTap> createState() => _QuranTapState();
}

class _QuranTapState extends State<QuranTap> {
  String searchText = '';
  List<MostRecentModel> mostRecent = [];

  @override
  void initState() {
    super.initState();
    loadMostRecent();
  }

  Future<void> loadMostRecent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMostRecent = prefs.getStringList('mostRecent') ?? [];
      final loaded = <MostRecentModel>[];

      for (final item in savedMostRecent) {
        try {
          final decoded = jsonDecode(item);
          if (decoded is Map<String, dynamic>) {
            loaded.add(MostRecentModel.fromMap(decoded));
          }
        } catch (_) {
          // ignore corrupted saved data
        }
      }

      mostRecent = loaded;
      if (mounted) setState(() {});
    } catch (_) {
      if (mounted) setState(() {});
    }
  }

  Future<void> addToMostRecent(
    String text,
    int ayatNum,
    int surahNum,
    String surahEnglish,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final newSurah = MostRecentModel(
        text: text,
        ayatNum: ayatNum,
        surahNum: surahNum,
        surahEnglish: surahEnglish,
      );

      mostRecent.removeWhere((item) => item.surahNum == surahNum);
      mostRecent.insert(0, newSurah);

      if (mostRecent.length > 10) {
        mostRecent = mostRecent.take(10).toList();
      }

      final savedMostRecent =
          mostRecent.map((item) => jsonEncode(item.toMap())).toList();

      await prefs.setStringList('mostRecent', savedMostRecent);

      if (mounted) setState(() {});
    } catch (_) {
      // prevent save errors from blocking screen navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = searchText.trim().toLowerCase();

    final filteredIndexes =
        List.generate(widget.surahNames.length, (index) => index).where((
          index,
        ) {
          if (query.isEmpty) return true;

          final arabic = widget.surahNames[index].toLowerCase();
          final english = widget.surahNamesEnglish[index].toLowerCase();

          return arabic.contains(query) || english.contains(query);
        }).toList();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset('assets/images/Logo (1).png'),
          ),
          const SizedBox(height: 10),
          TextField(
            style: TextStyle(color: AppColors.white),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'surah name',
              hintStyle: TextStyle(color: AppColors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset('assets/icons/surah_name_icon.svg'),
              ),
            ),
          ),
          if (mostRecent.isNotEmpty) ...[
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Most Recent',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mostRecent.length,
                itemBuilder: (context, index) {
                  final recent = mostRecent[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return QuranDetailsScreen(
                              surahName: recent.text,
                              surahNum: recent.surahNum,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 283,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recent.surahEnglish,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    recent.text,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${recent.ayatNum} Ayat'),
                                ],
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/img_most_recent.png',
                            width: 120,
                            height: 130,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
          Expanded(
            child: ListView.builder(
              itemCount: filteredIndexes.length,
              itemBuilder: (context, index) {
                final surahIndex = filteredIndexes[index];

                return GestureDetector(
                  onTap: () async {
                    await addToMostRecent(
                      widget.surahNames[surahIndex],
                      int.parse(
                        widget.surahAyatNums[surahIndex].split(' ').first,
                      ),

                      widget.surahNums[surahIndex],
                      widget.surahNamesEnglish[surahIndex],
                    );

                    if (!mounted) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return QuranDetailsScreen(
                            surahName: widget.surahNames[surahIndex],
                            surahNum: widget.surahNums[surahIndex],
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(
                                'assets/icons/img_sur_number_frame.svg',
                              ),
                            ),
                            Text(
                              '${widget.surahNums[surahIndex]}',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.surahNamesEnglish[surahIndex],
                              style: TextStyle(color: AppColors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${widget.surahAyatNums[surahIndex]} ',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          widget.surahNames[surahIndex],
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
