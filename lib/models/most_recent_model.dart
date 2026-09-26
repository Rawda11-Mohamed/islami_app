class MostRecentModel {
  final String surahEnglish;
  final int ayatNum;
  final int surahNum;
  final String text;

  MostRecentModel({
    required this.text,
    required this.ayatNum,
    required this.surahNum,
    required this.surahEnglish,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'ayatNum': ayatNum,
      'surahNum': surahNum,
      'surahEnglish': surahEnglish,
    };
  }

  factory MostRecentModel.fromMap(Map<String, dynamic> map) {
    return MostRecentModel(
      text: map['text'],
      ayatNum: map['ayatNum'],
      surahNum: map['surahNum'],
      surahEnglish: map['surahEnglish'],
    );
  }
}
