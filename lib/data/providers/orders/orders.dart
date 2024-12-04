import 'package:flutter/material.dart';

import 'package:flapkap/data/data.dart';
// use json
import 'dart:convert';

import 'package:flutter/services.dart';
import 'dart:convert';

class OrdersProvider extends ChangeNotifier {
  /// The orders loaded
  List<Order> ordersData = [];

  /// Load the orders data from json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/orders.json');
    final data = await json.decode(response);

    // parse all data
    ordersData = (data as List).map((e) => Order.fromJson(e)).toList();

    //
    notifyListeners();
  }
}
