import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/models/product.dart';
import 'package:demo_assignment/routes/routes_import.gr.dart';
import 'package:demo_assignment/services/api_setup/configure_dio.dart';
import 'package:demo_assignment/services/api_setup/fetch_products.dart';
import 'package:demo_assignment/services/shared_prefrence/shared_prefrence_config.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  final _dioInstance = DioConfig.instance;
  List<Product> data = [];

  bool isAtTop(BuildContext context) => AutoRouter.of(context).isRoot;

  void handleBackClick(BuildContext context) {
    AutoRouter.of(context).pop();
  }

  void init(BuildContext context) {
    fetchProducts(context);
  }

  void fetchProducts(BuildContext context) async {
    setBusy(true);
    final value = await FetchProducts.fetchProducts(_dioInstance);
    var instance = await SharedPrefSingleton().getInstance();
    await instance.setString('userLogin',
        DateTime.now().add(const Duration(seconds: 100)).toIso8601String());
    if (value.data != null) {
      data = value.data;
    } else if (value.error != null && context.mounted) {
      Functions.showSnackbar(context, 'Some error ocurred');
    }
    setBusy(false);
  }

  onItemClick(Product product, BuildContext context) {
    AutoRouter.of(context).push(DetailsRoute(product: product));
  }
}
