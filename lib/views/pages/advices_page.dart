import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:science_fair_app/data/classes/debt.dart';
import 'package:science_fair_app/data/classes/user_info_class.dart';
import 'package:science_fair_app/views/widgets/overpay_chart_widget.dart';

class AdvicesPage extends StatelessWidget {
  const AdvicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Box<Debt> debtsBox = Hive.box<Debt>('debts');
    Box<UserInfo> userInfo = Hive.box<UserInfo>('userInfo');
    int budget = userInfo.get('User') == null ? 0 : userInfo.get('User')!.budget;
    int remainingBudget = budget;

    List<Debt> debts = debtsBox.values.toList();

    for(int i = 0; i < debts.length; i++){
      remainingBudget -= debts[i].monthlyPayment;
    }

    debts.sort((a, b) => b.overpay.compareTo(a.overpay));
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: debtsBox.isEmpty ? Center(child: Text("Нет долгов", style: TextStyle(fontSize: 18, color: Colors.grey),)) : 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("График переплат по вашим долгам:",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                ? Colors.teal[300]
                : Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            SizedBox(height: 15),
            OverpayChartWidget(debtsBox: debtsBox),
            Divider(
              thickness: 1,
              color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
            ),
            SizedBox(height: 20,),
            Text(
              "График выше показывает, сколько денег вы переплачиваете сверх изначальной суммы по вашим текущим долгам. Долги расположены в убывающем порядке по переплате",
              style: TextStyle(
                fontSize: 15,
              ),
            ),SizedBox(height: 20,),
            Text(
              "Рекомендуется уделять больше всего финансов на долг с наивысшей переплатой, что бы минимизировать итоговую переплату.",
              style: TextStyle(
                    fontSize: 16,
                  ),
            ),
            Text(
              "Чем раньше погашается кредит, тем меньше процентов на него накладывается",
             style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
                  ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  "Долг с наивысшей переплатой: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
                  ),
                ),
                Text(
                  debts[0].name,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            SizedBox(height: 20,),
            remainingBudget >= 0 ? 
            budget != 0 ?
            RichText( //if budget is enough
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: DefaultTextStyle.of(context).style.color),
                children: [ 
                  TextSpan(text: 'Рекомендуемая плата по долгу ${debts[0].name}: '),
                  debts[0].monthlyPayment + remainingBudget > debts[0].sum ? 
                  TextSpan( //if the remaining budget exceedes the sum
                    text: '${debts[0].sum}',
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,),
                  ) : 
                  TextSpan( //if the remaining budget does not exceed the sum
                    text: '${debts[0].monthlyPayment + remainingBudget}',
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,),
                  ),
                ],
              ),
            ): 
            Text( //if budget is not enough
              "Прямо сейчас вам не хватает бюджета для выплаты ежемесячных плат всех долгов",
              style: TextStyle(color: Colors.red[300]),
            ) 
            :
            RichText( // if the budget is NOT SET
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: DefaultTextStyle.of(context).style.color),
                children: [
                  TextSpan(text: 'Вы не указали бюджет. Вам следует посчитать сколько денег остается каждый месяц после вычета всех '),
                  TextSpan(text: 'необходимых расходов. \n',
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
                           fontWeight: FontWeight.w500
                           ),
                  ),
                  TextSpan(text: "Важное уточнение: при досрочном погашении кредита (-ов), старайтесь тратить на второстепенные нужды меньше средств, то есть вам следует "),
                  TextSpan(text: "правильно расставить приротеты.",
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
                           fontWeight: FontWeight.w500
                           )
                  ),
                  TextSpan(text: "Например, если вы часто пьете кофе, постарайтесь пить его меньше или сменить на более дешевый вариант. "),
                  TextSpan(text: "Оптимизация расходов ",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                           ? Colors.teal[300]
                           : Colors.teal,
                           fontWeight: FontWeight.w500
                           )
                  ),
                  TextSpan(text: "порой затрачивает меньше времени чем "),
                  TextSpan(text: "поиск новых источников заработка.",
                    style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.w500)
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            if (debts.length > 1 && remainingBudget > 0 && budget != 0) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                "Плата по остальным долгам:",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                         ? Colors.teal[300]
                         : Colors.teal,
                  ),
                ),
                Column(
                  children: debts.skip(1).map((debt) {
                    return Text('${debt.name} : ${debt.monthlyPayment}');
                  }).toList(),
                )
              ]
            )
          ],
        )
      ),
    );
  }
}
