import 'dart:math';

import 'package:flapkap/navigator_settings.dart';
import 'package:flutter/material.dart';

//
import 'package:flapkap/viwes/constants/constants.dart';

// the data
import 'package:flapkap/data/data.dart';
import 'package:provider/provider.dart';

//
import "package:collection/collection.dart";

//
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  /// The orders
  List<Order> ordersData = [];

  void onBack() => AppNavigationHandler.popPage();

  @override
  void didChangeDependencies() {
    //
    ordersData = Provider.of<OrdersProvider>(context, listen: true).ordersData;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //
    Map<DateTime, List<Order>> data = groupBy<Order, DateTime>(
      ordersData.where((element) => element.registered != null),
      (order) => DateTime(order.registered!.year, order.registered!.month),
    );

    /// The max number of orders per month
    int maxOrdersByMonth = data.values.fold(
      0,
      (previousValue, element) =>
          previousValue > element.length ? previousValue : element.length,
    );

    List<DateTime> ordersDatesSorted = data.keys.sorted();

    // populate the data points
    // x is date on the x line
    // y is the orders count in that month
    final List<FlSpot> chartData = ordersDatesSorted.mapIndexed(
      (index, date) {
        return FlSpot(index.toDouble(), data[date]!.length.toDouble());
      },
    ).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //
            20.h.verticalSpace,

            // big title
            Stack(
              children: [
                // name
                Align(
                  child: Text(
                    'Orders Stats',
                    style: AppTextStyle.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //
                IconButton(
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 18.sp,
                  ),
                ),
              ],
            ),

            //
            20.h.verticalSpace,

            // The graph
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true, // Make lines curved
                      color: Colors.blue, // Line color
                      dotData: FlDotData(show: true), // Show data points
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.2),
                      ), // Area under the line
                    ),
                  ],
                  // Chart title

                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Orders Count',
                        style: AppTextStyle.textStyle12,
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        maxIncluded: true,
                        reservedSize: 40.r,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            child: Text('$value'),
                            axisSide: AxisSide.left,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Time/month',
                        style: AppTextStyle.textStyle12,
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30.dg,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          child: Text(
                            dateDayFormatter(ordersDatesSorted[value.toInt()]),
                            style: AppTextStyle.textStyle8.copyWith(),
                          ),
                          angle: -20,
                          axisSide: AxisSide.bottom,
                        ),
                      ),
                    ),
                  ),

                  borderData: FlBorderData(show: false), // Hide border
                  gridData: FlGridData(show: true), // Show grid lines

                  // Time points
                  minX: 0,
                  maxX: max(0, (ordersDatesSorted.length - 1).toDouble()),
                  // orders count
                  minY: 0,
                  maxY: maxOrdersByMonth.toDouble(),
                ),
                duration: Duration(milliseconds: 150),
                curve: Curves.linear,
              ),
            )
          ],
        ),
      ),
    );
  }

  String dateDayFormatter(DateTime date) {
    return DateFormat('yy/M').format(date);
  }
}
