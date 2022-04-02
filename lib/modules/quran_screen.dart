import 'dart:ui';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../shared/components/components.dart';
import 'soura_screen.dart';

class QuranScreen extends StatelessWidget {
  var searchController = TextEditingController();
  List<String> souraName =
  [
    'الفَاتِحَة','البَقَرَة','آل عِمرَان','النِّسَاء','المَائدة','الأنعَام','الأعرَاف','الأنفَال','التوبَة','يُونس','هُود','يُوسُف','الرَّعْد',
    'إبراهِيم','الحِجْر','النَّحْل','الإسْرَاء','الكهْف','مَريَم','طه	','الأنبيَاء','الحَج','المُؤمنون','النُّور','الفُرْقان',
    'الشُّعَرَاء','النَّمْل','القَصَص','العَنكبوت','الرُّوم','لقمَان','السَّجدَة','الأحزَاب','سَبَأ','فَاطِر','يس','الصَّافات',
    'ص','الزُّمَر','غَافِر','فُصِّلَتْ','الشُّورَى','الزُّخْرُف','الدخَان','الجَاثيَة','الأحْقاف','محَمَّد','الفَتْح','الحُجرَات',
    'ق','الذَّاريَات','الطُّور','النَّجْم','القَمَر','الرَّحمن','الوَاقِعَة','الحَديد','المجَادلة','الحَشر','المُمتَحنَة','الصَّف',
    'الجُمُعَة','المنَافِقون','التغَابُن','الطلَاق','التحْريم','المُلْك','القَلَم','الحَاقَّة','المعَارج','نُوح','الجِن','المُزَّمِّل',
    'المُدَّثِّر','القِيَامَة','الإنسَان','المُرسَلات','النَّبَأ','النّازعَات','عَبَس','التَّكوير','الانفِطار','المطفِّفِين','الانْشِقَاق','البرُوج','الطَّارِق',
    'الأَعْلى','الغَاشِية','الفَجْر','البَلَد','الشَّمْس','الليْل','الضُّحَى','الشَّرْح','التِّين','العَلَق','القَدْر','البَينَة',
    'الزلزَلة','العَادِيات','القَارِعة','التَّكَاثر','العَصْر','الهُمَزَة','الفِيل','قُرَيْش','المَاعُون','الكَوْثَر','الكَافِرُون','النَّصر',
    'المَسَد','الإخْلَاص','الفَلَق','النَّاس',
  ];
  List<String> souraNum =
  [
    '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25',
    '26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50',
    '51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75',
    '76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100',
    '101','102','103','104','105','106','107','108','109','110','111','112','113','114'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05,),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.01,
                    size.width * 0.02,
                    size.width * 0.01,
                    size.width * 0.02
                ),
                child: Container(
                  height: size.height * 0.2,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    //color: Colors.purple
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple , Colors.blue]
                    )
                  ),
                  margin: EdgeInsets.all(size.width * 0.05),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.05,
                        size.width * 0.15,
                        size.width * 0.05,
                        size.width * 0.15
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                '30%',
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                            const Spacer(),
                            Text(
                                'معدل الختمة (للمره الواحدة)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: size.height* 0.02,),
                        LinearProgressIndicator(
                          value: 0.3,
                          color: Colors.white,
                          backgroundColor: Colors.grey.shade700,
                          minHeight: size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                  'السور',
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                  color: Colors.cyan,
                ),
                height: size.height * 0.008,
                width: size.width,
                margin: EdgeInsets.fromLTRB(
                    size.width * 0.3,
                    0,
                    size.width * 0.3,
                    0
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)
                  {
                    return Column(
                      children: [
                        SizedBox(height: size.height * 0.02,),
                        InkWell(
                          child: soura(
                            firstContainerWidth: size.width,
                            firstContainerHeight: size.height * 0.07,
                            secondContainerWidth: size.width * 0.2,
                            secondContainerHeight: size.height * 0.07,
                            souraNum: souraNum[index],
                            souraNumSize: size.width * 0.05,
                            souraName: souraName[index],
                            souraNameSize: size.width * 0.05,
                            bottomMargin: size.height * 0.01,
                            leftMargin: size.width * 0.1,
                            rightMargin: size.width * 0.1,
                            topMargin: size.height * 0.01,
                            firstContainerColor: Colors.cyan.withOpacity(0.1),
                            secondContainerColor: Colors.cyan.withOpacity(0.1),
                            souraNameColor: Colors.black,
                            souraNameWeight: FontWeight.bold,
                            souraNumColor: Colors.black,
                            souraNumWeight: FontWeight.bold,
                            bottomPadding: size.height * 0,
                            leftPadding: size.width * 0,
                            rightPadding: size.width * 0.07,
                            topPadding: size.height * 0,
                          ),
                          onTap: ()
                          {
                            print(souraNum[index]);
                            print(souraName[index]);
                           var numberOfSurah = int.parse(souraNum[index]);
                            navigateTo(context, SouraScreen(
                                numOfSoura: numberOfSurah
                            ),
                            );

                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context,index) => SizedBox(
                  width: size.width,
                  height: size.height * 0,
                ),
                  itemCount: souraNum.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
