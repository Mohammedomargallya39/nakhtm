import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nakhtm/cubit/cubit.dart';
import 'package:nakhtm/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhtm/shared/components/components.dart';
import 'package:nakhtm/shared/components/constants.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SebhaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    tz.initializeTimeZones();
    final location = tz.getLocation('Africa/Cairo');
    DateTime date = tz.TZDateTime.from(DateTime.now(), location);
    Coordinates coordinates = Coordinates(26.820553, 30.802498);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();
    params.madhab = Madhab.Hanafi;
    PrayerTimes prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
    DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, location);
    DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, location);
    DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
    DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, location);
    DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, location);
    DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, location);
    String current = prayerTimes.currentPrayer(date: DateTime.now()); // date: date
    String next = prayerTimes.nextPrayer();
    SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
    DateTime lastThirdOfTheNight = tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, location);
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(height: size.height * 0.02,),
              Image.asset(
                'assets/images/background.jpg',
                height: size.height,
                width: size.width,
                fit: BoxFit.cover,
              ),
              SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/1.svg',
                          height: size.height * 0.3,
                          width: size.width,
                        ),
                        SizedBox(height: size.height * 0.04,),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              size.width * marginLeft,
                              size.width * marginTop,
                              size.width * marginRight,
                              size.width * marginBottom
                          ),
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(size.width * 0.02),
                          ),
                          child: expentionTile(
                            mainText: "مواعيد الصلاة",
                            mainTextSize: size.width * mainFontSize,
                            secondreyMainFontSize: size.width * thirdFontSize,
                            sizedBoxWidth: size.width * 0.03,
                            thirdFontSize: size.width * thirdFontSize,
                            elFagrText: '$fajrTime'.substring(11,19),
                            elDuhaText: '$sunriseTime'.substring(11,19),
                            elZuhrText: '$dhuhrTime'.substring(11,19),
                            elAsrText:  '$asrTime'.substring(11,19),
                            elMaghrebText: '$maghribTime'.substring(11,19),
                            elEshaaText: '$ishaTime'.substring(11,19),
                            qiamAlayl: '$lastThirdOfTheNight'.substring(11,19),
                            current: current,
                            next: next,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04,),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              size.width * marginLeft,
                              size.width * marginTop,
                              size.width * marginRight,
                              size.width * marginBottom
                          ),
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(size.width * 0.02),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'سبحة',
                              style: TextStyle(
                                  fontSize: size.width * mainFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            children: [
                              Container(
                                margin: EdgeInsets.all(size.width * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.cyan.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(size.width * 0.05),
                                ),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    AppCubit.get(context).sebha();
                                    AppCubit.get(context).countSubhanAllah ++ ;
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'سبحان الله',
                                            style: TextStyle(
                                                fontSize: size.width * secondFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0.02
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${AppCubit.get(context).countSubhanAllah}',
                                            style: TextStyle(
                                                fontSize: size.width * thirdFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(size.width * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(size.width * 0.05),
                                ),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    AppCubit.get(context).sebha();
                                    AppCubit.get(context).countAlhamdullah ++ ;
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'الحمد الله',
                                            style: TextStyle(
                                                fontSize: size.width * secondFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0.02
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${AppCubit.get(context).countAlhamdullah}',
                                            style: TextStyle(
                                                fontSize: size.width * thirdFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(size.width * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(size.width * 0.05),
                                ),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    AppCubit.get(context).sebha();
                                    AppCubit.get(context).countAllahAkbar ++ ;
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            ' الله أكبر',
                                            style: TextStyle(
                                                fontSize: size.width * secondFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0.02
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${AppCubit.get(context).countAllahAkbar}',
                                            style: TextStyle(
                                                fontSize: size.width * thirdFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(size.width * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(size.width * 0.05),
                                ),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    AppCubit.get(context).sebha();
                                    AppCubit.get(context).countLaElahElaAllah ++ ;
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0.02,
                                            size.width * 0,
                                            size.width * 0.02,
                                            size.width * 0
                                        ),
                                        child: Center(
                                          child: Text(
                                            'لا إله إلا الله وحده لا شريك له له المك وله الحمد و هو علي كل شئ قدير',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.width * secondFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0,
                                            size.width * 0.02
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${AppCubit.get(context).countLaElahElaAllah}',
                                            style: TextStyle(
                                                fontSize: size.width * thirdFontSize,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.width * 0.02),
                            color: Colors.cyan,
                          ),
                          width: size.width,
                          margin: EdgeInsets.fromLTRB(
                              size.width * 0.02,
                              0,
                              size.width * 0.02,
                              0
                          ),
                          child: ExpansionTile(
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'أدعية' ,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * mainFontSize
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: size.height * 0.0001,
                                      width: size.width,
                                      color: Colors.black,
                                    ),
                                  ),

                                  listTiles(
                                      mainText: 'دعاء قضاء الدين',
                                      secondText: 'اللهم اكفني بحلالك عن حرامك و أغنني بفضلك عمن سواك',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),


                                  listTiles(
                                      mainText: 'دعاء الإستسقاء',
                                      secondText: 'اللهم اسق عبادك و بهائمك و انشر رحمتك و أحيي بلدك الميت',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء قبل الطعام',
                                      secondText: 'إذا أكل أحدكم الطعام فليقل: بسم الله فإن نسي في أوله فليقل: بسم الله في أوله و آخره. و من أطعمه الله الطعام فليقل: اللهم بارك لنا فيه و أطعمنا خيرا منه و من سقاه الله لبنا فليقل: اللهم بارك لنا فيه و زدنا فيه',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء بعد الطعام',
                                      secondText: 'الحمد لله الذي أعمني هذا و رزقني من غير حول مني ولا قوة الحمد لله حمدا كثيرا طيبا مباركا فيه غير مكفي ولا مودع ولا مستغني عنه ربنا',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء رؤية الهلال',
                                      secondText: 'الله أكبر اللهم أهله علينا بالأمن و الإيمان و السلامة و السلام و التوفيق لما تحب ربنا و ترضي',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء نزول المطر',
                                      secondText: 'اللهم صيبا نافعا',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء نزول المطر',
                                      secondText: 'اللهم صيبا نافعا',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء نزول المطر',
                                      secondText: 'مطرنا بفضل الله ورحمته',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء نزول المطر',
                                      secondText: 'اللهم حوالينا ولا علينا. اللهم علي الآكام و الظراب و بطون الأدوية و منابت الشجر',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء زيارة القبور',
                                      secondText: 'السلام عليكم أهل الديار من المؤمنين و المسلمين و إنا إن شاء الله بكم لاحقون[ويرحم الله المستقدمين منا و المستأخرين] أسأل الله لنا و لكم العافية',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'الدعاء للميت في الصلاة عليه',
                                      secondText: 'اللهم أغفر لحينا و ميتنا و شاهدنا و غائبنا و صغيرنا و كبيرنا و ذكرنا و أنثانا. اللهم من أحييته منا فأحيه علي الإسلام و من توفيته منا فتوفه علي الإيمان. اللهم لا تحرمنا أجره ولا تضلنا بعده',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),


                                  listTiles(
                                      mainText: 'الدعاء للميت في الصلاة عليه',
                                      secondText: 'اللهم أغفر له و ارحمه وعافه واعف عنه و أكرم نزله ووسع مدخله و اغسله بالماء و الثلج و البرد و نقه من الخطايا كما ينقي الثوب الأبيض من الدنس وأبدله دارا خيرا من داره و أهلا خيرا من أهله و زوجا خيرا من زوجه و أدخله الجنة و أعذه من عذاب القبر و من عذاب النار',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'الدعاء للميت في الصلاة عليه',
                                      secondText: 'اللهم إن فلان بن فلان في ذمتك و حبل جوارك فقه من فتنة القبر و عذاب النار و أنت أهل الوفاء و الحق. فاغفر له وارحمه إنك أنت الغفور الرحيم',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'الدعاء للميت في الصلاة عليه',
                                      secondText: 'اللهم عبدك و إبن عبدك و ابن أمتك احتاج إلي رحمتك وأنت غني من عذابه إن كان محسنا فزده في حسناته و إن كان مسيئا فتجاوز عنه',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء المرض',
                                      secondText: 'اللهم إني أسألك من عظيم لطفك و كرمك و سترك الجميل أن تشفيه و تمده بالصحة و العافية',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء المرض',
                                      secondText: 'اللهم رب الناس مذهب البأس اشفه أنت الشافي لا شافي إلا أنت',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء المرض',
                                      secondText: 'أسأل الله العظيم رب العرش العظيم أن يشفيك. أسأل الله العظيم رب العرش العظيم أن يشفيك. أسأل الله العظيم رب العرش العظيم أن يشفيك. أسأل الله العظيم رب العرش العظيم أن يشفيك. أسأل الله العظيم رب العرش العظيم أن يشفيك. ',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء المرض',
                                      secondText: 'اللهم أشفه شفاء ليس بعده سقم أبدا. اللهم خذ بيده. اللهم احرسه بعينك التي لا تنام و اكفه بركنك الذي لا يرام و احفظه بعزك الذي لا يضان و اكلأه في الليل و في النهار و ارحمه بقدرتك عليه. أنت ثقته و رجائه يا كاشف الهم يا مفرج الكرب يا مجيب دعوة المضطرين',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء السفر',
                                      secondText: 'الله أكبر. الله أكبر"سبحان الذي سخر لنا هذا وما كنا له مقرنين* و إنا إلي ربنا لمنقلبون" اللهم إنا نسألك في سفرنا هذا البر و التقوي و من العمل ما ترضي. اللهم هون علينا سفرنا هذا واطو عنا بعده. اللهم أنت الصاحب في السفر و الخليفة في الأهل. اللهم إني أعوذ بك من وعثاء السفر وكآبة المنظر و سوء المنقلب في المال و الأهل. و إذا رجع قالهم و زاد فيهن آيبون و تائبون و عابدون لربنا حامدون',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء الهم و الحزن',
                                      secondText: 'اللهم إني عبدك ابن عبدك ابن امتك ناصيتي بيدك ماضي في حكمك عدل في قضاؤك أسألك بكل اسم هو لك سميت به نفسك أو أنزلته في كتابك أو علمته أحدا من خلقك أو استأثرت به في علم الغيب عندك أن تجعل القرآن ربيع قلبي و نور صدري و جلاء حزني و ذهاب همي',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء الهم و الحزن',
                                      secondText: 'اللهم إني أعوذ بك من الهم و الحزن و العجز و الكسل و البخل و الجبن و ضلع الدين و غلبة الرجال',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء دخول الخلاء و الخروج منه',
                                      secondText: 'فعندما دخل قال: بسم الله اللهم إني أعوذ بك من الخبث و الخبائث و إذا خرج قال: غفرانك',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء الذهاب للمسجد',
                                      secondText: 'اللَّهُمَّ اجْعَلْ في قَلْبِي نُورًا، وفي بَصَرِي نُورًا، وفي سَمْعِي نُورًا، وعَنْ يَمِينِي نُورًا، وعَنْ يَسارِي نُورًا، وفَوْقِي نُورًا، وتَحْتي نُورًا، وأَمامِي نُورًا، وخَلْفِي نُورًا، واجْعَلْ لي نُورًا',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء دخول المسجد',
                                      secondText: 'أعوذُ باللهِ العَظيمِ وبوَجْهِه الكَريمِ وسُلطانِه القَديمِ مِنَ الشَّيطانِ الرَّجيمِ',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء الخروج من المسجد',
                                      secondText: 'بسم الله والصلاة والسلام على رسُول الله، اللهم إنِّي أسألك من فضلك، اللَّهم اعصمني من الشيطان الرجيم',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),

                                  listTiles(
                                      mainText: 'دعاء صلاة الإستخارة',
                                      secondText: 'اللَّهُمَّ إنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ فَإِنَّكَ تَقْدِرُ وَلا أَقْدِرُ، وَتَعْلَمُ وَلا أَعْلَمُ، وَأَنْتَ عَلامُ الْغُيُوبِ. اللَّهُمَّ إنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ (هنا تسمي حاجتك) خَيْرٌ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ. اللَّهُمَّ وَإِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ (هنا تسمي حاجتك) شَرٌّ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي فَاصْرِفْهُ عَنِّي وَاصْرِفْنِي عَنْهُ وَاقْدُرْ لِي الْخَيْرَ حَيْثُ كَانَ ثُمَّ ارْضِنِي بِهِ. (وَيُسَمِّي حَاجَتَهُ)',
                                      sizeWidth: size.width,
                                      sizeHeight: size.height
                                  ),


                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  )
              )
            ],
          ),
        );
      }
    );
  }
}
