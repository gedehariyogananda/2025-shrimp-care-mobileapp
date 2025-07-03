class SamplingData {
  final String docId;
  final DateTime date;
  final Map<String, double> values;
  final String location;

  SamplingData({
    required this.docId,
    required this.date,
    required this.values,
    required this.location,
  });
}

class SamplingDataRepository {
  static List<SamplingData> getSamplingData() {
    return [
      SamplingData(
        docId: "DOC 1",
        date: DateTime(2025, 4, 1),
        values: {"MBW": 0.85, "SIZE": 450, "ADG": 0.3},
        location: "Selasa",
      ),
      SamplingData(
        docId: "DOC 2",
        date: DateTime(2025, 4, 2),
        values: {"MBW": 1.12, "SIZE": 485, "ADG": 0.6},
        location: "Rabu",
      ),
      SamplingData(
        docId: "DOC 3",
        date: DateTime(2025, 4, 3),
        values: {"MBW": 1.45, "SIZE": 520, "ADG": 0.8},
        location: "Kamis",
      ),
      SamplingData(
        docId: "DOC 4",
        date: DateTime(2025, 4, 4),
        values: {"MBW": 1.38, "SIZE": 505, "ADG": 0.7},
        location: "Jumat",
      ),
      SamplingData(
        docId: "DOC 5",
        date: DateTime(2025, 4, 5),
        values: {"MBW": 1.72, "SIZE": 565, "ADG": 1.1},
        location: "Minggu",
      ),
      SamplingData(
        docId: "DOC 6",
        date: DateTime(2025, 4, 7),
        values: {"MBW": 1.95, "SIZE": 590, "ADG": 1.3},
        location: "Senin",
      ),
      SamplingData(
        docId: "DOC 7",
        date: DateTime(2025, 4, 8),
        values: {"MBW": 1.88, "SIZE": 575, "ADG": 1.2},
        location: "Selasa",
      ),
      SamplingData(
        docId: "DOC 8",
        date: DateTime(2025, 4, 9),
        values: {"MBW": 2.35, "SIZE": 625, "ADG": 1.6},
        location: "Rabu",
      ),
      SamplingData(
        docId: "DOC 9",
        date: DateTime(2025, 4, 10),
        values: {"MBW": 2.68, "SIZE": 670, "ADG": 1.9},
        location: "Kamis",
      ),
      SamplingData(
        docId: "DOC 10",
        date: DateTime(2025, 4, 11),
        values: {"MBW": 2.52, "SIZE": 655, "ADG": 1.7},
        location: "Jumat",
      ),
      SamplingData(
        docId: "DOC 11",
        date: DateTime(2025, 4, 12),
        values: {"MBW": 3.15, "SIZE": 720, "ADG": 2.3},
        location: "Sabtu",
      ),
      SamplingData(
        docId: "DOC 12",
        date: DateTime(2025, 4, 13),
        values: {"MBW": 3.48, "SIZE": 765, "ADG": 2.6},
        location: "Minggu",
      ),
      SamplingData(
        docId: "DOC 13",
        date: DateTime(2025, 4, 14),
        values: {"MBW": 3.22, "SIZE": 745, "ADG": 2.4},
        location: "Senin",
      ),
      SamplingData(
        docId: "DOC 14",
        date: DateTime(2025, 4, 15),
        values: {"MBW": 3.89, "SIZE": 795, "ADG": 2.9},
        location: "Selasa",
      ),
      SamplingData(
        docId: "DOC 15",
        date: DateTime(2025, 4, 16),
        values: {"MBW": 4.25, "SIZE": 825, "ADG": 3.2},
        location: "Rabu",
      ),
      SamplingData(
        docId: "DOC 16",
        date: DateTime(2025, 4, 17),
        values: {"MBW": 4.08, "SIZE": 810, "ADG": 3.0},
        location: "Kamis",
      ),
      SamplingData(
        docId: "DOC 17",
        date: DateTime(2025, 4, 18),
        values: {"MBW": 4.68, "SIZE": 870, "ADG": 3.6},
        location: "Jumat",
      ),
      SamplingData(
        docId: "DOC 18",
        date: DateTime(2025, 4, 19),
        values: {"MBW": 5.12, "SIZE": 920, "ADG": 4.0},
        location: "Sabtu",
      ),
      SamplingData(
        docId: "DOC 19",
        date: DateTime(2025, 4, 20),
        values: {"MBW": 4.95, "SIZE": 905, "ADG": 3.8},
        location: "Minggu",
      ),
      SamplingData(
        docId: "DOC 20",
        date: DateTime(2025, 4, 21),
        values: {"MBW": 5.45, "SIZE": 950, "ADG": 4.3},
        location: "Senin",
      ),
    ];
  }

  static List<Map<String, dynamic>> getChartData() {
    final data = getSamplingData();
    return data.map((item) {
      final docNumber = int.parse(item.docId.split(' ')[1]);
      return {
        'doc': docNumber,
        'mbw': item.values['MBW'],
        'size': item.values['SIZE'],
        'adg': item.values['ADG'],
      };
    }).toList();
  }
}
