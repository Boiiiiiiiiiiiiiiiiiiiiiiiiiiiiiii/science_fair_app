import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:science_fair_app/data/classes/debt.dart';
import 'package:science_fair_app/data/constants.dart';

class DebtCardWidget extends StatelessWidget {
  const DebtCardWidget({
    super.key,
    required this.debtIndex,
  });

  final int debtIndex;

  @override
  Widget build(BuildContext context) {
    final Box<Debt> debtBox = Hive.box<Debt>('debts'); // Access the Hive box
    if (debtIndex >= debtBox.length) {
      return const SizedBox(); // Prevent index out-of-bounds errors
    }

    final Debt debt = debtBox.getAt(debtIndex)!; // Retrieve debt object

    String debtType = (debt.type == DebtType.diferentional)
        ? "Дифференционный"
        : "Аннуитетный";

    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  debt.name,
                  style: CardTextStyle.cardTitleText(context),
                ),
              ),
              const Divider(thickness: 1, color: Colors.teal),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " ${debt.sum}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 50,
                    child: FilledButton(
                      onPressed: deleteDebt, 
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                      ),
                      child: Icon(Icons.delete_forever)
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        " ${debt.percent}",
                        style: CardTextStyle.cardDataText(context)
                      ),
                      Text("%", style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " ${debt.months}",
                        style: CardTextStyle.cardDataText(context)
                      ),
                      Text(" месяцев", style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " $debtType",
                        style: CardTextStyle.cardDataText(context),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteDebt(){
    final box = Hive.box<Debt>('debts');
    box.deleteAt(debtIndex);
  }
}