void printLongString(dynamic text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}

int constJuza = 0;
int constAyahNum = 0;
int constAyatSurahNum=0;
int constSurahNum = 0;
String constSurahName = '';
String constAyah = '';
