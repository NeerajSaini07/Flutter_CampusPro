import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:get/get.dart';

LineChartBarData chartbardata(List<double> scores, index, String subject) {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  return LineChartBarData(
    spots: scores.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value * 100;
      return FlSpot(index.toDouble(), value);
    }).toList(),
    isCurved: true,
    color: exameAnalysisController.colorPalette[index],
    dotData: const FlDotData(
      show: true,
    ),
    belowBarData: BarAreaData(show: false),
  );
}
