import 'dart:math';

import 'package:hive/hive.dart';

part 'debt.g.dart';

@HiveType(typeId: 0)
enum DebtType {
  @HiveField(0)
  annuity,

  @HiveField(1)
  diferentional,
}

@HiveType(typeId: 1)
class Debt {
  @HiveField(0)
  String name;

  @HiveField(1)
  int sum;

  @HiveField(2)
  int percent;

  @HiveField(3)
  int months;

  @HiveField(4)
  DebtType type;

  @HiveField(5)
  int monthlyPayment;

  @HiveField(6)
  int overpay;

  Debt({
    required this.name,
    required this.sum,
    required this.percent,
    required this.months,
    required this.type,
    this.monthlyPayment = 0,
    this.overpay = 0,
  }) {
    monthlyPayment = _calculateMonthlyPayment(sum);
    overpay = _calculateOverpayment();
  }

  int _calculateMonthlyPayment(int sum) {
    double rate = percent / 100 / 12;
    if (type == DebtType.annuity) {
      // Формула аннуитетного платежа
      double payment = sum * rate / (1 - (1 / (pow(1 + rate, months))));
      return payment.round();
    } else {
      // Формула дифференцированного платежа (первый месяц)
      int principalPayment = (sum / months).round();
      int interestPayment = (sum * rate).round();
      return principalPayment + interestPayment;
    }
  }

  int _calculateOverpayment() {
    double rate = percent / 100 / 12;

    if (type == DebtType.annuity) {
      int totalPaid = monthlyPayment * months;
      return totalPaid - sum;
    } else {
      // Для дифференцированного кредита считаем выплаты за каждый месяц
      double remaining = sum.toDouble();
      double totalPaid = 0;

      for (int i = 0; i < months; i++) {
        double interestPayment = remaining * rate;
        double principalPayment = sum / months;
        totalPaid += interestPayment + principalPayment;
        remaining -= principalPayment;
      }

      return totalPaid.round() - sum;
    }
  }
}