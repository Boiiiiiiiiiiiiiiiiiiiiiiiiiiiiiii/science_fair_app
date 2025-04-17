import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:science_fair_app/data/classes/debt.dart';
import 'package:science_fair_app/views/widgets/debt_card_widget.dart';

class DebtsInfoPage extends StatelessWidget {
  const DebtsInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Debt>('debts').listenable(),
      builder: (context, Box<Debt> debtBox, child) {
        return SingleChildScrollView(
          child: Column(
            children: debtBox.isEmpty
                ? [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Нет долгов",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ]
                : List.generate(
                    debtBox.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: DebtCardWidget(debtIndex: index),
                    ),
                  ),
          ),
        );
      },
    );
  }
}