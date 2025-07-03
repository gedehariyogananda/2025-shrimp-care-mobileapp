import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shrimp_care_mobileapp/features/sampling/views/model/sampling_data.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class SamplingPage extends StatefulWidget {
  @override
  _SamplingPageState createState() => _SamplingPageState();
}

class _SamplingPageState extends State<SamplingPage> {
  String selectedMetric = "MBW";
  String selectedTimeframe = "Mingguan";

  final List<String> metrics = ["MBW", "SIZE", "ADG"];
  final List<String> timeframes = ["Harian", "Mingguan"];

  List<SamplingData> samplingData = [];
  List<Map<String, dynamic>> chartData = [];

  @override
  void initState() {
    super.initState();
    samplingData = SamplingDataRepository.getSamplingData();
    chartData = SamplingDataRepository.getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with dropdowns
            _buildHeader(),
            const SizedBox(height: 20),

            // Chart
            _buildChart(),
            const SizedBox(height: 20),

            // Detail Sampling Section
            _buildDetailSampling(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grafik',
            style: MyTextStyle.text16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: selectedMetric,
                  items: metrics,
                  onChanged: (value) {
                    setState(() {
                      selectedMetric = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: selectedTimeframe,
                  items: timeframes,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeframe = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.formInputBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: MyTextStyle.text14.copyWith(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: _getHorizontalInterval(),
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 2,
                getTitlesWidget: (value, meta) {
                  return Text(
                    'D${value.toInt()}',
                    style:
                        MyTextStyle.text10.copyWith(color: MyColor.secondary),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: _getHorizontalInterval(),
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _formatYAxisValue(value),
                    style:
                        MyTextStyle.text10.copyWith(color: MyColor.secondary),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 1,
          maxX: 20,
          minY: _getMinY(),
          maxY: _getMaxY(),
          lineBarsData: [
            LineChartBarData(
              spots: _getSpots(),
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  MyColor.primary,
                  MyColor.primary.withOpacity(0.8),
                ],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: MyColor.primary,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    MyColor.primary.withOpacity(0.3),
                    MyColor.primary.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getSpots() {
    return chartData.map((data) {
      double value = 0;
      switch (selectedMetric) {
        case "MBW":
          value = data['mbw'];
          break;
        case "SIZE":
          value = data['size'];
          break;
        case "ADG":
          value = data['adg'];
          break;
      }
      return FlSpot(data['doc'].toDouble(), value);
    }).toList();
  }

  double _getMinY() {
    final spots = _getSpots();
    final minValue =
        spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    return minValue * 0.8;
  }

  double _getMaxY() {
    final spots = _getSpots();
    final maxValue =
        spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return maxValue * 1.2;
  }

  double _getHorizontalInterval() {
    double range = _getMaxY() - _getMinY();
    return range / 5;
  }

  String _formatYAxisValue(double value) {
    if (selectedMetric == "SIZE") {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(1);
    }
  }

  Widget _buildDetailSampling() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Sampling',
            style: MyTextStyle.text16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 16),

          // Show last 5 records
          ...samplingData.reversed
              .take(5)
              .map((data) => _buildSamplingCard(data)),
        ],
      ),
    );
  }

  Widget _buildSamplingCard(SamplingData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.softPrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.docId,
                style: MyTextStyle.text14.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${data.location}, ${DateFormat('dd MMM yyyy').format(data.date)}',
                style: MyTextStyle.text12.copyWith(color: MyColor.secondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  label: "MBW",
                  value: "${data.values['MBW']}",
                  unit: "g/ekor",
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  label: "SIZE",
                  value: "${data.values['SIZE']?.toInt()}",
                  unit: "ekor",
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  label: "ADG",
                  value: "${data.values['ADG']}",
                  unit: "g/hari",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: MyTextStyle.text10.copyWith(color: MyColor.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: MyTextStyle.text16.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          unit,
          style: MyTextStyle.text10.copyWith(color: MyColor.secondary),
        ),
      ],
    );
  }
}
