import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/models/product.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailsScreenViewModel extends BaseViewModel {
  Product? product;

  bool get isProductAvailable => product != null;

  DetailsScreenViewModel({this.product});

  void handleBackClick(BuildContext context) {
    AutoRouter.of(context).pop();
  }
}
