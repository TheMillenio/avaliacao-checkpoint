class PriceFormatter {
  PriceFormatter._();

  static String formatBrl(double value) {
    final formatted = value.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $formatted';
  }
}
