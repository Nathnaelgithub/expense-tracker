import 'package:intl/intl.dart';

class Formatter {
  static final _currency = NumberFormat.currency(symbol: "\$");
  static final _date = DateFormat.yMMMd();

  static String currency(double amount) => _currency.format(amount);

  static String date(DateTime time) => _date.format(time);
}
