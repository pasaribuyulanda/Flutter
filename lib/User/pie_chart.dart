import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class MyPieChart extends StatelessWidget {
  final List<double> data;
  final List<Color> colors;

  const MyPieChart({
    required this.data,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text("Data Anggota"),
        PieChart(
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOutQuint,
          PieChartData(
            sections: List.generate(data.length, (index) {
              // Generate PieChartSectionData dynamically based on the data and colors
              return PieChartSectionData(
                value: data[index],
                color: colors[index],
                titleStyle: TextStyle(color: Colors.white),
              );
            }),
          ),
        ),
      ],
    );
  }
}
