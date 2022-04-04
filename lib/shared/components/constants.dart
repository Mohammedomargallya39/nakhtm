void printLongString(dynamic text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}

// int? juzaNumC;
// int? ayahNumC;
// String? surahNameC;
// String? ayahC;
int juza = 0;
int ayahNum = 0;
String surahName = '';
String ayah = '';
