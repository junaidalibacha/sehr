import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sehr/app/index.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "TERMS AND CONDITIONS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          const Text(
              "1۔ سحر پروجیکٹ خالصتاً نیک نیتی اور حسن ظن پر بنیاد رکھتے ہوئےہر شعبہ کے ویلفیر کے لیے ترتیب دیا گیاہے۔"),
          const Text(
              "2۔ کسی بھی شعبہ سے تعلق رکھنے والے افراد سے کسی قسم کی بھی رجسٹریشن فیس / ڈونیش نہیں لی جائے گی۔"),
          const Text(
              "3- تمام فوائد سوبر ٹیکنالوجیز انٹرنیشنل اسلام آباد کی صوابدید پر دیے جائیں گے۔"),
          const Text(
              "4۔ کسی قسم یا کوئی دعوی/claim قانونی طور پر کوئی حیثیت نہیں  رکھے گی"),
          const Text("کمپنی کسی بھی وقت کوئی بھی آفر واپس لے سکتی ہے5"),
        ],
      ),
    );
  }
}
