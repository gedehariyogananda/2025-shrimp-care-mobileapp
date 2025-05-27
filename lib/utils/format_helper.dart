String formatPercentage(double value) {
  return value.toStringAsFixed(2);
}

String formatDateTime(DateTime dateTime) {
  final months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  final day = dateTime.day.toString().padLeft(2, '0');

  final month = months[dateTime.month - 1];

  final year = dateTime.year;

  return '$day $month $year';
}
