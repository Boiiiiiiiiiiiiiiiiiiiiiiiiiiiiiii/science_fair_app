import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:science_fair_app/data/classes/debt.dart';
 // Убедись, что путь к модели правильный

class OverpayChartWidget extends StatelessWidget {
  final Box<Debt> debtsBox;

  const OverpayChartWidget({super.key, required this.debtsBox});

  @override
  Widget build(BuildContext context) {
    List<Debt> debts = debtsBox.values.toList();
    debts.sort((a, b) => b.overpay.compareTo(a.overpay));
    debts = debts.take(9).toList();

    final List<double> overpays = debts.map((d) => d.overpay.toDouble()).toList();
    final double maxOverpay = overpays.isNotEmpty ? overpays.reduce((a, b) => a > b ? a : b) : 1;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          groupsSpace: 30,
          maxY: 1,
          alignment: BarChartAlignment.start,
          barGroups: debts.asMap().entries.map((entry) {
            final index = entry.key;
            final debt = entry.value;
            final normalized = debt.overpay / maxOverpay;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: normalized,
                  width: 16,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= debts.length) return const SizedBox.shrink();
                  return Text(
                    debts[index].name.length > 6
                    ? debts[index].name.substring(0, 6)
                    : debts[index].name,
                    style: const TextStyle(fontSize: 9),
                    overflow: TextOverflow.ellipsis,
                  );
                },
                reservedSize: 20,
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 65,
                getTitlesWidget: (value, meta) {
                  final real = value * maxOverpay;
                  return Text(real.round().toString(), style: const TextStyle(fontSize: 10));
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false
            ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
