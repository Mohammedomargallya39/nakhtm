void printLongString(dynamic text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}

late int constJuza;
late int constAyahNum;
late int constAyatSurahNum;
late int constSurahNum;
late String constSurahName;
late String constAyah;

double paddingTop = 0.15;
double paddingBottom = 0.15;
double paddingLeft = 0.05;
double paddingRight = 0.05;

double marginTop = 0;
double marginBottom = 0;
double marginRight = 0.02;
double marginLeft = 0.02;

double mainFontSize = 0.07;
double secondFontSize = 0.06;
double thirdFontSize = 0.05;

double trailingPadding = 0.02;
double trailingIconSize = 0.05;






