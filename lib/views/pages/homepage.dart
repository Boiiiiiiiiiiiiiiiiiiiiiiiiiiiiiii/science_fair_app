import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:science_fair_app/data/classes/debt.dart';
import 'package:science_fair_app/data/classes/user_info_class.dart';
import 'package:science_fair_app/data/constants.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TextEditingController budgetController = TextEditingController();

  TextEditingController debtNameController = TextEditingController();
  TextEditingController debtSumController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController monthsController = TextEditingController();
  DebtType? debtType = DebtType.diferentional;

  late Box<Debt> debtBox;
  late Box<UserInfo> userInfo;

  @override
  void initState() {
    super.initState();
    debtBox = Hive.box<Debt>('debts'); // Get the Hive box
    userInfo = Hive.box<UserInfo>('userInfo');
    budgetController.text = userInfo.get('User') == null ? '0' : userInfo.get('User')!.budget.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Ваш бюджет:", 
              style: KTextStyle.titleTealText, 
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: budgetController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "0 если не знаете",
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 55,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Change this value
                      ),
                    ),
                    onPressed: () {
                      saveBudget();
                    },
                    child: Text("Сохранить",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.teal[300],
            ),
            SizedBox(height: 20),
            Text(
              " Данные о долге",
              style: KTextStyle.titleTealText,
            ),
            Text(
              " Название долга",
              style: KTextStyle.descriptionText,
            ),
            TextField(
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              controller: debtNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            SizedBox(height: 20),
            Text(
              " Сумма долга",
              style: KTextStyle.descriptionText,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: debtSumController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),SizedBox(height: 20),
            Text(
              " Процентная ставка долга",
              style: KTextStyle.descriptionText,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: percentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            SizedBox(height: 20),
            Text(
              " Срок долга(в месяцах)",
              style: KTextStyle.descriptionText,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: monthsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            SizedBox(height: 20),
            Text(
              " Тип долга",
              style: KTextStyle.descriptionText,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: DropdownButtonFormField<DebtType>(
                    value: debtType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.teal.shade200, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: [
                      DropdownMenuItem(value: DebtType.annuity,child: Text('Аннуитетный'),),
                      DropdownMenuItem(value: DebtType.diferentional, child: Text('Диференционный')),
                    ], 
                    onChanged: (DebtType? value) {
                      setState((){
                        debtType = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 55,
                  child: FilledButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Типы долгов",
                                    style: KTextStyle.titleTealText,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'Тип кредита можно найти в Договоре банковского займа в приложении Вашего банка. Ищите слова "Аннуитетный платеж" или "Дифференциированный платеж"',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "Аннуитетный",
                                  style: KTextStyle.descriptionText,
                                ),
                                SizedBox(height: 5,),
                                Text("Аннуитет — график погашения кредита, предполагающий выплату основного долга и процентов по кредиту равными суммами через равные промежутки времени. Проще говоря: вы платите одинаковую сумму каждый месяц. Итоговая переплата выше чем у Диференционного кредита"),
                                SizedBox(height: 20,),
                                Text(
                                  "Диференциированный",
                                  style: KTextStyle.descriptionText,
                                ),
                                SizedBox(height: 5,),
                                Text("Дифференцированный — это платёж, размер которого уменьшается с каждым месяцем. При этом доля процентов и тела займа остаётся неизменной. Такой платеж имеет меньшую итоговую переплату, но ежемесячный платеж по началу является выше чем у Аннуитетного"),
                                SizedBox(height: 10,),
                                Text(
                                  "График отношения размера платежа ко времени:",
                                  style: KTextStyle.descriptionText,
                                ),
                                Image.asset(
                                  "assets/images/types_of_payment.jpg",
                                  width: 300,
                                  height: 170,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Примеры:",
                                  style: KTextStyle.titleTealText,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Аннуитетный пример:",
                                  style: KTextStyle.descriptionText,
                                ),
                                Text(
                                  "- Сумма долга — 1 000 000 ₸, процент — 10% годовых, срок — 12 месяцев.\n"
                                  "- Платёж каждый месяц = 87 915 ₸(там сложная формула, не утруждайтесь).\n"
                                  "- Общая выплата = 87 915 × 12 = 1 054 980 ₸.\n"
                                  "- Переплата = 54 980 ₸.\n"
                                  "- Вы каждый месяц платите одинаково: сначала больше процентов, потом больше основного долга.",
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Дифференцированный пример:",
                                  style: KTextStyle.descriptionText,
                                ),
                                Text(
                                  "- Сумма долга: 1 000 000 ₸, Процент: 10% годовых, Срок: 10 месяцев.\n"
                                  "- Проценты: Годовая ставка / 12 = \n10% / 12 = 0.8333...\n"
                                  "- Выплата по процентам: Остаток * Проценты\n"
                                  '- "Тело" долга: 1 000 000/10(месяцы)\n'
                                  '- Платеж: Тело + плата по процентам'
                                  "- Первый платёж ≈ 100 000 (основной долг) + 8 333 (проценты) = 108 333 ₸,\n"
                                  "- Последний платёж ≈ 100 000 + 833 = 100 833 ₸.\n"
                                  "- Общая выплата ≈ 1 049 996 ₸.\n"
                                  "- Переплата ≈ 49 996 ₸.\n"
                                  "- Платежи уменьшаются со временем, но первые месяцы платить сложнее.",
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    child: Icon(Icons.question_mark_rounded),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: saveDebt, 
                child: Text("Сохранить")
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void saveBudget(){
    int budget = 0;
    if(int.tryParse(budgetController.text) == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Введите коррректный бюджет"), 
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating
        )
      );
    }
    else{
      budget = int.parse(budgetController.text);
    }
    UserInfo info = UserInfo(budget: budget);
    userInfo.put('User', info);
    budgetController.text = "";
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Бюджет сохранен"), 
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating
        )
      );
  }

  void saveDebt() {
    try {
      String name = debtNameController.text;
      int sum = int.tryParse(debtSumController.text) ?? 0;
      int percent = int.tryParse(percentController.text) ?? 0;
      int months = int.tryParse(monthsController.text) ?? 0;

      if (name.isEmpty || sum <= 0 || percent < 0 || months <= 0 || debtType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Пожалуйста, заполните все поля корректно"))
        );
        return;
      }

      Debt newDebt = Debt(
        name: name,
        sum: sum,
        percent: percent,
        months: months,
        type: debtType!,
      );

      debtBox.put(newDebt.name, newDebt); // Save the debt object

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Долг сохранен"))
      );

      // Clear fields after saving
      debtNameController.clear();
      debtSumController.clear();
      percentController.clear();
      monthsController.clear();
      setState(() {
        debtType = DebtType.diferentional;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка при сохранении: $e"))
      );
    }
  }

}