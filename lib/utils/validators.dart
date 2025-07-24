// utils/validators.dart
class Validators {
  static String? validateRequired(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Le champ $field est obligatoire';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Le numéro est obligatoire';
    final phoneRegex = RegExp(r'^[+]?[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Numéro de téléphone invalide';
    }
    return null;
  }

  static String? validateDateRange(DateTime start, DateTime end) {
    if (start.isAfter(end)) {
      return 'La date de sortie ne peut pas être antérieure à la date d’entrée';
    }
    return null;
  }
}
