import 'dart:async';
import 'dart:math';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nakhtm/core/util/resources/extensions_manager.dart';
import 'package:nakhtm/features/home/presentation/controller/state.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../domain/entities/adan_entity.dart';
import '../../domain/entities/hadith_entity.dart';
import '../../domain/entities/tafseer_entity.dart';
import '../../domain/usecase/adan_usecase.dart';
import '../../domain/usecase/hadith_usecase.dart';
import '../../domain/usecase/tafseer_usecase.dart';
import '../screens/azkar/azkar_screen.dart';
import '../screens/donitation/donition_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/quran/quran_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  final AdanUseCase _adanUseCase;
  final TafseerUseCase _tafseerUseCase;
  final HadithUseCase _hadithUseCase;

  HomeCubit({
    required AdanUseCase adanUseCase,
    required TafseerUseCase tafseerUseCase,
    required HadithUseCase hadithUseCase,
  })  : _adanUseCase = adanUseCase,
        _tafseerUseCase = tafseerUseCase,
        _hadithUseCase = hadithUseCase,
        super(Empty());
  static HomeCubit get(context) => BlocProvider.of(context);
  int initialTabIndex = 0;
  List<Widget> homeWidgets = [
    const HomeScreen(),
    const QuranScreen(),
    const AzkarScreen(),
    const SadakaScreen(),
  ];
  void changeNavBottomScreen(int index) {
    initialTabIndex = index;
    emit(ChangeBottomNavBarState());
  }

  List<String> shikhNames = [
  'عبدالباري الثبيتي',
  'عبدالباسط عبدالصمد',
  'أحمد الهواشي',
  'أحمد العجمي',
  'أحمد محمد سلامة',
  'مشاري راشد العفاسي',
  'علي عبدالرحمن الحصفي',
  'علي حجاج السويسي',
  'عبد المجيب بن كيران',
  'فارس عباد',
  'هاني الرفاعي',
  'إبراهيم الدوسري',
  'خالد القحطاني',
  'خالد بركات',
  'خالد الجليل',
  'محمود الرفاعي',
  'محمود علي البنا',
  'محمود الشيمي',
  'محمود سعد درويش',
  'محمود سيد الطيب',
  'محمد الجابري الحياني',
  'محمد القنطاوي',
  'محمد معبود',
  'محمد أنور الشحات',
  'محمد أيوب',
  'محمد صديق المنشاوي',
  'ناصر القطامي',
  'ياسر الدوسري',
  ];

  List<String> shikhId = [
    'abdulbariaththubaity',
    'abdulbasitmujawwad',
    'ahmadalhawashy',
    'ahmedalajmi',
    'ahmedmohamedsalama',
    'alafasy',
    'aliabdurrahmanalhuthaify',
    'alihajjajsouissi',
    'benkirane',
    'faresabbad',
    'haniarrifai',
    'ibrahimaldossari',
    'khaledalqahtani',
    'khaledbarakat',
    'khalidaljalil',
    'mahmoodalrifai',
    'mahmoudalialbanna',
    'mahmoudelsheimy',
    'mahmoudsaaddarouich',
    'mahmoudsayedeltayeb',
    'mohamedaljaberyalheyani',
    'mohamedelkantaoui',
    'mohamedmaabad',
    'muhammadanwarshahat',
    'muhammadayyub',
    'muhammadsiddiqalminshawimujawwad',
    'nasseralqatami',
    'yasseraldossari',
  ];

  String selectedShiekh = 'alafasy';

  List<String> randomHomeSlah = [
    '«إِنَّ اللَّهَ وَمَلَائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ ۚ يَا أَيُّهَا الَّذِينَ آمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا»،( سورة الأحزاب: الآية 56).',
    'اللهم صلّ على محمد وعلى آل محمد، كما صليت على إبراهيم وعلى آل إبراهيم، وبارك على محمد وعلى آل محمد، كما باركت على إبراهيم وعلى آل إبراهيم، إنك حميد مجيد',
    '«اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّد في الأَوَّلِينَ وَالآخِرِينَ، وَفِي الْمَلأِ الأَعْلَى إِلَى يَوْمِ الْدِّينِ. اللهم صل وسلم وبارك على سيدنا محمد وعلى آله وصحبه عدد ما في علم الله، صلاةً دائمة بدوام ملك الله».',
    '«اللهم صل وسلم وبارك على سيدنا محمد وعلى آله وصحبه عدد كمال الله وكما يليق بكماله».',
    '«اللهم صل وسلم وبارك على سيدنا محمد وعلى آله عدد حروف القرآن حرفًا حرفًا، وعدد كل حرف ألفًا ألفًا، وعدد صفوف الملائكة صفًا صفًا، وعدد كل صف ألفًا ألفًا، وعدد الرمال ذرة ذرة، وعدد ما أحاط به علمك، وجرى به قلمك، ونفذ به حكمك في برك وبحرك، وسائر خلقك».',
    '-«اللهم صلِّ وسلم على صاحب الخُلق العظيم والقدر الفخيم مَن أرسلته رحمة للعالمين سيدنا محمد وعلى آله وصحبه، وألحقنا بخُلقه وأدّبنا بأدبه، وأحيي فينا وفي أُمته هذه المعاني يا كريم».',
    '«اللهم صَلِّ وسلم على سيدنا محمد صلاة تحل بها عقدتي، وتفرج بها كربتي، وتمحو بها خطيئتي، وتقضي بها حاجتي».',
    '- «اللهم صل وسلم على سيدنا محمد صلاة تهب لنا بها أكمل المراد وفوق المراد، في دار الدنيا ودار المعاد، وعلى آله وصحبه وبارك وسلم عدد ما علمت وزنة ماعلمت وملء ما علمت».',
    '«اللهم صل على سيدنا محمد صلاة تنجينا بها من جميع الأهوال والآفات، وتقضي بها جميع الحاجات، وتطهرنا بها من جميع السيئات، وترفعنا بها عندك أعلى الدرجات، وتبلغنا بها أقصى الغايات من جميع الخيرات في الحياة وبعد الممات، وعلى آله وصحبه وسلم تسليمًا كثيرًا »',
    '«اللهم صل وسلم على سيدنا محمد وعلى آله، صلاة تكون لنا طريقًا لقربه، وتأكيدًا لحبه، وبابًا لجمعنا عليه، وهدية مقبولة بين يديه، وسلم وبارك كذلك أبدًا، وارض عن آله وصحبه السعداء، واكسنا حُلل الرضا».'
  ];

  Map<String,int> surahsInfo= {};
  List<String>? searchList;
  void searchBySurahName(String name){
    searchList = surahsInfo.keys.where((element) => element.contains(name)).toList();
    print('search ====>>>>> $searchList');
    emit(SearchSurahNameState());
  }

  bool ended = false;

  List<String>? azkarMorning;
  List<String>? azkarEvening;
  List<String>? azkarElsalah;
  List<String>? azkarSleeping;
  List<String>? azkarMasged;
  void initializeLists(){
    azkarMorning = [
      '«اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِي العظيم».',
      '«قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ».',
      '«قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدٌَۢ».',
      '«قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسٌَِۢ».',
      'أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.',
      'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .',
      'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.',
      'اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.',
      'اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.',
      'حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.',
      'بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.',
      'اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.',
      'أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.',
      'سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.',
      'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.',
      'اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ.',
      'اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.',
      'يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ.',
      'أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه.',
      'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.',
      'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.',
      'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.',
      'اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.',
      'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.',
      'أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.',
      'يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ.',
      'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا.',
      'اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسي ، ومن شر كل دابة أنت آخذ بناصيتها ، إن ربي على صراط مستقيم.',
      'لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.',
      'سُبْحـانَ اللهِ وَبِحَمْـدِهِ.',
      'أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ.',
    ];
    azkarEvening = [
      '«اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِي العظيم».',
      '«قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ».',
      '«قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدٌَۢ».',
      '«قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسٌَِۢ».',
      'أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.',
      'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .',
      'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.',
      'اللّهُـمَّ إِنِّـي أَمسيتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.',
      'اللّهُـمَّ ما أَمسى  بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.',
      'حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.',
      'بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.',
      'اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.',
      'أمسينا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.',
      'سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.',
      'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ.',
      'اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ.',
      'اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.',
      'يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ.',
      'أَمْسَيْنا وَأَمْسَى الْمُلْكُ للهِ رَبِّ الْعَالَمَيْنِ، اللَّهُمَّ إِنَّي أسْأَلُكَ خَيْرَ هَذَه اللَّيْلَةِ فَتْحَهَا ونَصْرَهَا، ونُوْرَهَا وبَرَكَتهَا، وَهُدَاهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فيهِا وَشَرَّ مَا بَعْدَهَا.',
      'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.',
      'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.',
      'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.',
      'اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.',
      'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.',
      'أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.',
      'يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ.',
      'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا.',
      'اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسي ، ومن شر كل دابة أنت آخذ بناصيتها ، إن ربي على صراط مستقيم.',
      'لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.',
      'سُبْحـانَ اللهِ وَبِحَمْـدِهِ.',
      'أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ.',
    ];
    azkarElsalah = [
      'أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله.',
      'اللّهُـمَّ أَنْـتَ السَّلامُ ، وَمِـنْكَ السَّلام ، تَبارَكْتَ يا ذا الجَـلالِ وَالإِكْـرام .',
      'لا إلهَ إلاّ اللّهُ وحدَهُ لا شريكَ لهُ، لهُ المُـلْكُ ولهُ الحَمْد، وهوَ على كلّ شَيءٍ قَدير، اللّهُـمَّ لا مانِعَ لِما أَعْطَـيْت، وَلا مُعْطِـيَ لِما مَنَـعْت، وَلا يَنْفَـعُ ذا الجَـدِّ مِنْـكَ الجَـد.',
      'لا إلهَ إلاّ اللّه, وحدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمد، وهوَ على كلّ شيءٍ قدير، لا حَـوْلَ وَلا قـوَّةَ إِلاّ بِاللهِ، لا إلهَ إلاّ اللّـه، وَلا نَعْـبُـدُ إِلاّ إيّـاه, لَهُ النِّعْـمَةُ وَلَهُ الفَضْل وَلَهُ الثَّـناءُ الحَـسَن، لا إلهَ إلاّ اللّهُ مخْلِصـينَ لَـهُ الدِّينَ وَلَوْ كَـرِهَ الكـافِرون.',
      'سُـبْحانَ اللهِ',
      'الحَمْـدُ لله',
      'اللهُ أكْـبَر',
      'لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمْد، وهُوَ على كُلّ شَيءٍ قَـدير.',
      'قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ.',
      'قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.',
      'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.',
      'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِي العظيم.',
      'لا إلهَ إلاّ اللّهُ وحْـدَهُ لا شريكَ لهُ، لهُ المُلكُ ولهُ الحَمْد، يُحيـي وَيُمـيتُ وهُوَ على كُلّ شيءٍ قدير.',
      'اللّهُـمَّ إِنِّـي أَسْأَلُـكَ عِلْمـاً نافِعـاً وَرِزْقـاً طَيِّـباً ، وَعَمَـلاً مُتَقَـبَّلاً. "بعد صلاة الفجر"',
      'اللَّهُمَّ أَجِرْنِي مِنْ النَّار. "بعد الصبح والمغرب"',
      'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ.',
    ];
    azkarSleeping = [
      'بِاسْمِكَ رَبِّـي وَضَعْـتُ جَنْـبي ، وَبِكَ أَرْفَعُـه، فَإِن أَمْسَـكْتَ نَفْسـي فارْحَـمْها ، وَإِنْ أَرْسَلْتَـها فاحْفَظْـها بِمـا تَحْفَـظُ بِه عِبـادَكَ الصّـالِحـين.',
      'اللّهُـمَّ إِنَّـكَ خَلَـقْتَ نَفْسـي وَأَنْـتَ تَوَفّـاهـا لَكَ ممَـاتـها وَمَحْـياها ، إِنْ أَحْيَيْـتَها فاحْفَظْـها ، وَإِنْ أَمَتَّـها فَاغْفِـرْ لَـها . اللّهُـمَّ إِنَّـي أَسْـأَلُـكَ العـافِـيَة.',
      'اللّهُـمَّ قِنـي عَذابَـكَ يَـوْمَ تَبْـعَثُ عِبـادَك.',
      'بِاسْـمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا.',
      'الـحَمْدُ للهِ الَّذي أَطْـعَمَنا وَسَقـانا، وَكَفـانا، وَآوانا، فَكَـمْ مِمَّـنْ لا كـافِيَ لَـهُ وَلا مُـؤْوي.',
      'اللّهُـمَّ عالِـمَ الغَـيبِ وَالشّـهادةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كُـلِّ شَـيءٍ وَمَليـكَه، أَشْهـدُ أَنْ لا إِلـهَ إِلاّ أَنْت، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي، وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم .',
      'اللّهُـمَّ أَسْـلَمْتُ نَفْـسي إِلَـيْكَ، وَفَوَّضْـتُ أَمْـري إِلَـيْكَ، وَوَجَّـهْتُ وَجْـهي إِلَـيْكَ، وَأَلْـجَـاْتُ ظَهـري إِلَـيْكَ، رَغْبَـةً وَرَهْـبَةً إِلَـيْكَ، لا مَلْجَـأَ وَلا مَنْـجـا مِنْـكَ إِلاّ إِلَـيْكَ، آمَنْـتُ بِكِتـابِكَ الّـذي أَنْزَلْـتَ وَبِنَبِـيِّـكَ الّـذي أَرْسَلْـت.',
      'سُبْحَانَ اللَّهِ.',
      'الْحَمْدُ لِلَّهِ.',
      'اللَّهُ أَكْبَرُ.',
      'يجمع كفيه ثم ينفث فيهما والقراءة فيهما: {قل هو الله أحد} و{قل أعوذ برب الفلق} و{قل أعوذ برب الناس} ومسح ما استطاع من الجسد يبدأ بهما على رأسه ووجه وما أقبل من جسده.',
      'آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ. لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤاخذنا إن نسينا أو أخطأنا ربنا ولا تحمل علينا إصرا كما حملته على الذين من قبلنا ربنا ولا تحملنا ما لا طاقة لنا به واعف عنا واغفر لنا وارحمنا أنت مولانا فانصرنا على القوم الكافرين.',
      'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِي العظيم.',
    ];
    azkarMasged = [
      'دُعَاءُ الذَّهَابِ إلَى المَسْجِدِ: اللّهُـمَّ اجْعَـلْ في قَلْبـي نورا ، وَفي لِسـاني نورا، وَاجْعَـلْ في سَمْعي نورا، وَاجْعَـلْ في بَصَري نورا، وَاجْعَـلْ مِنْ خَلْفي نورا، وَمِنْ أَمامـي نورا، وَاجْعَـلْ مِنْ فَوْقـي نورا ، وَمِن تَحْتـي نورا .اللّهُـمَّ أَعْطِنـي نورا',
      'دُعَاءُ دُخُولِ المَسْجِدِ: يَبْدَأُ بِرِجْلِهِ اليُمْنَى، وَيَقُولُ : أَعوذُ باللهِ العَظيـم وَبِوَجْهِـهِ الكَرِيـم وَسُلْطـانِه القَديـم مِنَ الشّيْـطانِ الرَّجـيم، بِسْمِ اللَّهِ، وَالصَّلاةُ وَالسَّلامُ عَلَى رَسُولِ الله، اللّهُـمَّ افْتَـحْ لي أَبْوابَ رَحْمَتـِك.',
      'دُعَاءُ الخُرُوجِ مِنَ المَسْجِدِ : يَبْدَأُ بِرِجْلِهِ الْيُسْرَى، وَيَقُولُ: بِسْـمِ اللَّـهِ وَالصَّلاةُ وَالسَّلامُ عَلَى رَسُولِ اللَّهِ، اللَّهُمَّ إنِّي أَسْأَلُكَ مِنْ فَضْلِكَ، اللَّهُمَّ اعْصِمْنِي مِنَ الشَّيْطَانِ الرَّجِيم.',
    ];
  }
  List<int>? repetitionMasgedNum;
  List<int>? repetitionSleepingNum ;
  List<int>? repetitionElsalahNum;
  List<int>? repetitionEveningNum;
  List<int>? repetitionMorningNum;
  void initializeRepetition(){
    repetitionMorningNum = [
      1,
      3,
      3,
      3,
      1,
      1,
      3,
      4,
      1,
      7,
      3,
      1,
      1,
      3,
      3,
      3,
      1,
      3,
      1,
      1,
      3,
      10,
      3,
      3,
      3,
      3,
      1,
      1,
      10,
      100,
      100
    ];
    repetitionEveningNum = [
      1,
      3,
      3,
      3,
      1,
      1,
      3,
      4,
      1,
      7,
      3,
      1,
      1,
      3,
      3,
      3,
      1,
      3,
      1,
      1,
      3,
      10,
      3,
      3,
      3,
      3,
      1,
      1,
      10,
      100,
      100
    ];
    repetitionElsalahNum = [
      1,
      1,
      1,
      1,
      33,
      33,
      33,
      1,
      3,
      3,
      3,
      1,
      10,
      1,
      7,
      1
    ];
    repetitionSleepingNum = [1, 1, 3, 1, 1, 1, 1, 33, 33, 34, 3, 1, 1];
    repetitionMasgedNum = [1, 1, 1];
    emit(RestAzkarListState());
  }
  String? pickedRandom;
  void pickRandomHomeSlah() {
    pickedRandom = randomHomeSlah[Random().nextInt(randomHomeSlah.length)];
    Future.delayed(const Duration(seconds: 20), pickRandomHomeSlah);
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: ' ',
        text: ' ',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.mohammed.gallya.Nakhtm_Quran',
        chooserTitle: 'شارك بواسطة');
  }
  bool hideCardValue = false;
  void hideCard(bool value) {
    hideCardValue = value;
    emit(HideCardValueState());
  }
  bool ayahPressedValue = false;
  void ayahPressed({bool? value}) {
    ayahPressedValue = value?? !ayahPressedValue;
    emit(AyahOnPressedValueState());
  }

  int currentTasbeehNumber = 0;
  void changeCurrentTasbeehNumber() {
    currentTasbeehNumber++;
    emit(ChangeCurrentTasbeehNumber());
  }
  int totalTasbeeh = 0;
  void saveTotalTasbeeh() async {
    totalTasbeeh = totalTasbeeh + currentTasbeehNumber;
    currentTasbeehNumber = 0;
    await sl<CacheHelper>().put('totalTasbeeh', totalTasbeeh);
    getTotalTasbeeh();
  }
  void getTotalTasbeeh() async {
    totalTasbeeh = await sl<CacheHelper>().get('totalTasbeeh');
    emit(GetTotalTasbeeh());
  }

  void changeRepetitionMasgedNum(int index) {
    repetitionMasgedNum![index]--;
    emit(ChangeRepetitionMasgedNumber());
  }
  void changeRepetitionSleepingNum(int index) {
    repetitionSleepingNum![index]--;
    emit(ChangeRepetitionSleepingNumber());
  }
  void changeRepetitionElsalahNum(int index) {
    repetitionElsalahNum![index]--;
    emit(ChangeRepetitionSalahNumber());
  }
  void changeRepetitionMorinigNum(int index) {
    repetitionMorningNum![index]--;
    emit(ChangeRepetitionMorningNumber());
  }
  void changeRepetitionEveningNum(int index) {
    repetitionEveningNum![index]--;
    emit(ChangeRepetitionEveningNumber());
  }
  bool azkarPressedValue = false;
  void azkarPressed() {
    ayahPressedValue = true;
    emit(AyahOnPressedValueState());
  }
  bool alarmIcon = false;
  void changAlarm() {
    alarmIcon = !alarmIcon;
    emit(AlarmChangeState());
    sl<CacheHelper>().put('adanNotification', alarmIcon);

  }

  List<AdanEntity>? adanResult;
  void adan({
    required String year,
    required String month,
    required String day,
    required String lat,
    required String lng,
    required String method,
  }) async {
    emit(AdanLoadingState());
    final adan = await _adanUseCase(AdanParams(
      year: year,
      month: month,
      day: day,
      lat: lat,
      lng: lng,
      method: method,
    ));
    adan.fold((failure) {
      emit(AdanErrorState());
    }, (data) async{
      adanResult = data;
      sl<CacheHelper>().put('fajr', adanResult![DateTime.now().day - 1].timings.fajr.substring(0, 5));
      sl<CacheHelper>().put('sunrise', adanResult![DateTime.now().day - 1].timings.sunrise.substring(0, 5),);
      sl<CacheHelper>().put('dhuhr', adanResult![DateTime.now().day - 1].timings.dhuhr.substring(0, 5));
      sl<CacheHelper>().put('asr', adanResult![DateTime.now().day - 1].timings.asr.substring(0, 5));
      sl<CacheHelper>().put('maghrib', adanResult![DateTime.now().day - 1].timings.maghrib.substring(0, 5));
      sl<CacheHelper>().put('ishaa', adanResult![DateTime.now().day - 1].timings.ishaa.substring(0, 5));
      emit(AdanSuccessState());

      salahTimes = [
        await sl<CacheHelper>().get('fajr') ?? 'Open Network',
        await sl<CacheHelper>().get('sunrise') ?? 'Open Network',
        await sl<CacheHelper>().get('dhuhr') ?? 'Open Network',
        await sl<CacheHelper>().get('asr') ?? 'Open Network',
        await sl<CacheHelper>().get('maghrib') ?? 'Open Network',
        await sl<CacheHelper>().get('ishaa') ?? 'Open Network',
      ];
      emit(GetSavedDataSuccessState());

    });
  }
  TafseerEntity? tafseerResult;
  void tafseer({
    required int tafseerId,
    required int surahId,
    required int ayahId,
  }) async {
    emit(TafseerLoadingState());
    final tafseer = await _tafseerUseCase(TafseerParams(
      tafseerId: tafseerId,
      surahId: surahId,
      ayahId: ayahId,
    ));
    tafseer.fold((failure) {
      emit(TafseerErrorState());
    }, (data) {
      emit(TafseerSuccessState());
      tafseerResult = data;
    });
  }
  int pageNumber = 1;
  void changeNextPage() {
    pageNumber++;
    emit(NextPageState());
  }
  void changePrevPage() {
    if (pageNumber > 1) {
      pageNumber--;
    }
    emit(PrevPageState());
  }
  List<HadithEntity>? hadithResult;
  List<String>? hadithArabic;
  void getHadith({
    required int pageNum,
    required String bookName,
  }) async {
    hadithResult = null;
    emit(HadithLoadingState());
    final hadith = await _hadithUseCase(HadithParams(
      pageNum: pageNum,
      bookName: bookName,
    ));
    hadith.fold((failure) {
      emit(HadithErrorState());
    }, (data) {
      emit(HadithSuccessState());
      hadithResult = data;
      hadithArabic = hadithResult!.map((e) => e.hadithArabic.replaceAll('‏', '')).toList();
      debugPrintFullText(hadithArabic.toString());

    });
  }

  void getSavedData()async{
    surahNum = await sl<CacheHelper>().get('surahNum')?? 0;
    ayahNum = await sl<CacheHelper>().get('ayahNum')?? 0;
    pageNum = await sl<CacheHelper>().get('pageNum') ?? 0;
    surahName = await sl<CacheHelper>().get('surahName')?? '';
    emit(GetSavedDataSuccessState());
  }

  void getSavedDataTimes()async{

  }

  bool permission = false;
  double? lat;
  double? lng;
  void getLocation()
  async{
    await Geolocator.requestPermission().then((value) async{
      permission = await Geolocator.isLocationServiceEnabled();
      if(permission == true) {
        emit(LoadingGetLocationState());
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        currentLat = position.latitude;
        currentLng = position.longitude;
        lat = position.latitude;
        lng = position.longitude;
      }
    });

    sl<CacheHelper>().put('permission', permission);
    emit(GetLocationState());
  }
  bool changePlayingValue = false;
  void changePlaying({bool? value})
  {
    changePlayingValue= value ?? !changePlayingValue;
    emit(TurnOnSoundState());
  }
  late AudioPlayer player;
  int durationSeconds = 0;
  String duration = '00:00:00';
  late Stream<Duration> positionStream;
  late StreamController<Duration> streamController;
   bool isAudioInit = false;
  void initializeAudio(String link)async{
    player = AudioPlayer();
    isAudioInit = true;
    await player.setAudioSource(AudioSource.uri(Uri.parse(link))).then((value){
      durationSeconds = player.duration!.inSeconds;
      duration = formatDuration(durationSeconds);
      positionStream = Stream.periodic(
          const Duration(seconds: 1), (_) => player.position);
      streamController.addStream(positionStream);
      emit(AudioInitializedState());
    });

  }

  bool isStreamInitialized = false;

  void initializeStream()async{
    streamController = StreamController<Duration>();
    isStreamInitialized = true;
    emit(CloseStreamState());
  }

  void disposeAudio() async{
    isAudioInit = false;
    await player.dispose();
    emit(DisposeAudioState());
  }
  String playingValue = 'start';
  Duration? position;

  void pauseAndPlay({required String value, Duration? audioPosition})
  {
    playingValue= value;
    position = audioPosition ?? const Duration(hours: 0,minutes: 0,seconds: 0,milliseconds: 0,microseconds: 0);
    emit(TurnOnSoundState());
  }


  void showGuide(bool value)
  {
    showGuideValue = value;
    emit(ShowGuideState());
    sl<CacheHelper>().put('guideValue', showGuideValue);
  }

  double fontSizeValue = 20.rSp;
  void zoomIn ()
  {
    fontSizeValue +=2;
    sl<CacheHelper>().put('fontSize', fontSizeValue);
    emit(AddFontSizeState());
  }

  void zoomOut ()
  {
    fontSizeValue -=2;
    sl<CacheHelper>().put('fontSize', fontSizeValue);
    emit(AddFontSizeState());
  }


  Future<void> closeStream()async{
    await streamController.close();
    isStreamInitialized = false;
    emit(CloseStreamState());
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours > 0 ? '${hours.toString().padLeft(2, '0')}:': '';
    String minutesStr = '${minutes.toString().padLeft(2, '0')}:';
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr$minutesStr$secondsStr';
  }

}
