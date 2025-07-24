// utils/date_utils.dart
import 'package:intl/intl.dart';

class DateUtils {
  // Formate une date en "dd/MM/yyyy"
  static String format(DateTime? date) {
    if (date == null) return 'Non défini';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Optionnel : format avec heure
  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
