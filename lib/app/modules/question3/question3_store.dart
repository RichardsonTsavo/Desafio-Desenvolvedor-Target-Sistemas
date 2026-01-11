import 'dart:math';

import 'package:mobx/mobx.dart';

import '../../shared/utils/utils.dart';
import 'model/day_model.dart';
import 'model/month_model.dart';

part 'question3_store.g.dart';

// ignore: library_private_types_in_public_api
class Question3Store = _Question3StoreBase with _$Question3Store;

abstract class _Question3StoreBase with Store {
  final random = Random();

  List<MonthModel> billing = [];

  void setBilling() {
    DateTime now = DateTime.now();
    billing.clear();
    billing.addAll([
      MonthModel(
        month: 'Janeiro',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 1, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Fevereiro',
        days: List.generate(28, (index) {
          DateTime date = DateTime(now.year, 2, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Março',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 3, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Abril',
        days: List.generate(30, (index) {
          DateTime date = DateTime(now.year, 4, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Maio',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 5, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Junho',
        days: List.generate(30, (index) {
          DateTime date = DateTime(now.year, 6, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Julho',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 7, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Agosto',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 8, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Setembro',
        days: List.generate(30, (index) {
          DateTime date = DateTime(now.year, 9, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Outubro',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 10, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Novembro',
        days: List.generate(30, (index) {
          DateTime date = DateTime(now.year, 11, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
      MonthModel(
        month: 'Dezembro',
        days: List.generate(31, (index) {
          DateTime date = DateTime(now.year, 12, index + 1);
          return DayModel(
            day: index + 1,
            value: Utils.isWeekend(date) ? 0.0 : random.nextDouble() * 5000,
          );
        }),
      ),
    ]);
  }

  double totalMonth(MonthModel month) {
    return month.days.fold(0.0, (sum, day) => sum + day.value);
  }

  MonthModel getMonthWithLowestValue() {
    late MonthModel value;
    double lowestValue = double.infinity;

    for (final month in billing) {
      double total = totalMonth(month);

      if (total < lowestValue) {
        lowestValue = total;
        value = month;
      }
    }

    return value;
  }

  DayModel getLowValueOfMonth(MonthModel month) {
    List<DayModel> validDays = month.days.where((day) => day.value > 0).toList();
    return validDays.reduce((a, b) => a.value < b.value ? a : b);
  }

  MonthModel getMonthWithHighestValue() {
    late MonthModel value;
    double highestValue = 0;

    for (var month in billing) {
      double total = month.days.fold(0.0, (sum, day) => sum + day.value);

      if (total > highestValue) {
        highestValue = total;
        value = month;
      }
    }

    return value;
  }

  DayModel getHighValueOfMonth(MonthModel month) {
    return month.days.reduce((a, b) => a.value > b.value ? a : b);
  }

  int getDaysAboveAnnualAverage() {
    double total = 0.0;
    int totalDays = 0;

    for (var month in billing) {
      for (final day in month.days) {
        if (day.value > 0) {
          total += day.value;
          totalDays++;
        }
      }
    }

    if (totalDays == 0) return 0;

    double annualAverage = total / totalDays;

    int daysAboveAverage = 0;

    for (var month in billing) {
      for (var day in month.days) {
        if (day.value > 0 && day.value > annualAverage) {
          daysAboveAverage++;
        }
      }
    }

    return daysAboveAverage;
  }

  double getAnnualAverage() {
    double totalYear = 0.0;
    int totalDays = 0;

    for (var month in billing) {
      for (var day in month.days) {
        if (day.value > 0) {
          totalYear += day.value;
          totalDays++;
        }
      }
    }

    if (totalDays == 0) return 0.0;

    return totalYear / totalDays;
  }

  int countDaysAboveAnnualAverage() {
    double annualAverage = getAnnualAverage();
    int count = 0;

    for (final month in billing) {
      for (final day in month.days) {
        if (day.value > annualAverage) {
          count++;
        }
      }
    }

    return count;
  }
}
