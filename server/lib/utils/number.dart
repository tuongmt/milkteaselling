import 'package:intl/intl.dart';

String numberFormatter(double amount) {
  return NumberFormat.decimalPattern('vi_VN').format(amount) + "₫";
}
