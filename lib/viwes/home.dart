import 'package:flutter/material.dart';

///
import 'package:flapkap/navigator_settings.dart';

import 'package:expandable/expandable.dart';
import 'package:flapkap/viwes/constants/constants.dart';

// the data
import 'package:flapkap/data/data.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart' show DateFormat;

/// stats screen
import 'stats.dart';

String priceTowFractionDigits({
  required double price,
}) {
  return price.toStringAsFixed(2);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// The orders
  List<Order> ordersData = [];

  //
  void onShowGraphScreen() {
    // push the stats screen
    AppNavigationHandler.pushPage(
      childPageToPage: StatsScreen(),
    );
  }

  @override
  void initState() {
    // load the data
    Provider.of<OrdersProvider>(context, listen: false).readJson();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //
    ordersData = Provider.of<OrdersProvider>(context, listen: true).ordersData;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int returnedOrdersCount =
        ordersData.where((element) => element.isReturned).length;

    double averagePrice = ordersData.isEmpty
        ? 0
        : (ordersData.fold<double>(
                0,
                (previousValue, element) =>
                    previousValue + (element.price ?? 0)) /
            ordersData.length);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 50.h,
          bottom: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // big title
            Align(
              child: Text(
                'User Orders',
                style: AppTextStyle.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //
            20.h.verticalSpace,

            // orange top
            Container(
              width: 1.sw,
              height: 35.h,
              padding: EdgeInsetsDirectional.only(
                start: 10.w,
                end: 10.w,
                top: 5.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.sp),
                  topRight: Radius.circular(12.sp),
                ),
              ),
              alignment: AlignmentDirectional.topStart,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Orders Summary',
                    style: AppTextStyle.textStyle16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Icon
                  IconButton(
                    onPressed: onShowGraphScreen,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    icon: Row(
                      children: [
                        Icon(
                          Icons.auto_graph_sharp,
                          color: Colors.white,
                        ),

                        //
                        1.w.horizontalSpace,

                        //
                        Text(
                          'Show stats',
                          style: AppTextStyle.textStyle12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // bottom half
            Container(
              constraints: BoxConstraints(
                minHeight: 60.h,
                minWidth: 1.sw,
              ),
              padding: EdgeInsetsDirectional.only(
                start: 10.w,
                top: 8.h,
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray26,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.sp),
                  bottomLeft: Radius.circular(12.sp),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 35,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              alignment: AlignmentDirectional.topStart,
              child: Column(
                children: [
                  // total count
                  summaryItem(
                    label: 'Total count',
                    value: ordersData.length.toString(),
                  ),

                  //
                  2.h.verticalSpace,

                  //
                  summaryItem(
                    label: 'Returned Orders count',
                    value: returnedOrdersCount.toString(),
                  ),

                  //
                  2.h.verticalSpace,

                  //
                  summaryItem(
                    label: 'Average Price',
                    value: priceTowFractionDigits(price: averagePrice),
                  ),
                ],
              ),
            ),

            //
            10.h.verticalSpace,

            //
            // Orders

            Expanded(
              child: ListView.separated(
                itemCount: ordersData.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                  // start: 15.w,
                  // end: 15.w,
                  //
                  top: 10.h,
                  bottom: 10.h,
                ),
                separatorBuilder: (context, index) => 15.h.verticalSpace,
                itemBuilder: (context, index) {
                  return _OrderBox(
                    order: ordersData[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget summaryItem({
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: Text(
            '$label: ',
            style: AppTextStyle.textStyle12.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        //
        3.w.horizontalSpace,

        //
        Text(
          value,
          style: AppTextStyle.textStyle12,
        ),
      ],
    );
  }

  //
}

class _OrderBox extends StatefulWidget {
  //
  final Order order;

  const _OrderBox({
    super.key,
    required this.order,
  });

  @override
  State<_OrderBox> createState() => _OrderBoxState();
}

/// Order box header
class _OrderBoxState extends State<_OrderBox> {
  //
  ExpandableController controller =
      ExpandableController(initialExpanded: false);

  void toggle() => controller.toggle();

  @override
  Widget build(BuildContext context) {
    double minHeight = 88.h;

    //
    BorderRadius borderRadius = BorderRadius.circular(13.sp);

    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: borderRadius,
      ),
      child: TextButton(
        onPressed: toggle,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        //
        child: ExpandablePanel(
          controller: controller,
          collapsed: const SizedBox.shrink(),
          theme: const ExpandableThemeData(
            hasIcon: false,
            useInkWell: false,
          ),

          //
          // Header
          header: SizedBox(
            height: minHeight,
            width: 1.sw,
            child: _OrderBoxHeader(
              order: widget.order,
            ),
          ),

          //
          // expanded body
          expanded: _OrderBoxBody(
            order: widget.order,
          ),
        ),
      ),
    );
  }
}

class _OrderBoxHeader extends StatelessWidget {
  //
  final Order order;

  const _OrderBoxHeader({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 6.w,
        end: 6.w,
        //
        top: 6.h,
        bottom: 6.h,
      ),
      child: Row(
        children: [
          // image
          Container(
            height: 76.h,
            width: 83.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Image.asset(
              'assets/images/logo.jpg',
            ),
          ),

          //
          8.w.horizontalSpace,

          // Name
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 5.5.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.company ?? ' ',
                    style: AppTextStyle.textStyle16.copyWith(),
                  ),

                  //
                  24.h.verticalSpace,

                  // price
                  Text(
                    '${priceTowFractionDigits(price: order.price ?? 0)} \$',
                    style: AppTextStyle.textStyle10.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Order body
class _OrderBoxBody extends StatelessWidget {
  //
  final Order order;

  const _OrderBoxBody({
    super.key,
    required this.order,
  });
  @override
  Widget build(BuildContext context) {
    //
    List<(String, String)> data = [
      ('Order id', order.id ?? ''),
      ('Company', order.company ?? ''),
      ('Buyer', order.buyer ?? ''),
      if (order.registered != null)
        ('Date', DateFormat(' dd/MM/yyy | HH:mm a').format(order.registered!)),
      if (order.tags != null) ('Tags', order.tags!.join(' ')),
    ];

    return Container(
      constraints: BoxConstraints(minHeight: 191.h, minWidth: 1.sw),
      padding: EdgeInsetsDirectional.only(
        start: 90.w,
        end: 6.w,
        //
        top: 4.h,
        bottom: 8.h,
      ),
      child: ListView.separated(
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.lightGray12),
            ),
          ),
        ),
        itemBuilder: (context, index) {
          (String, String) item = data[index];

          return ConstrainedBox(
            constraints: BoxConstraints(minWidth: 1.sw, minHeight: 32.h),
            child: labelField(
              label: item.$1,
              value: item.$2,
            ),
          );
        },
      ),
    );
  }

  Widget labelField({
    required String label,
    required String value,
  }) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        SizedBox(
          width: 50.w,
          child: Text(
            '$label:',
            style: AppTextStyle.textStyle10.copyWith(
              color: AppColors.lighterBlack6,
            ),
          ),
        ),

        //
        5.w.horizontalSpace,

        //
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.textStyle13.copyWith(
              color: AppColors.lighterBlack7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
