import 'package:demo_assignment/models/custom_response.dart';
import 'package:demo_assignment/models/product.dart';
import 'package:dio/dio.dart';

class FetchProducts {
  static Future<CustomResponse> fetchProducts(Dio instance) async {
    try {
      final value = await instance.get('/products');
      if (value.statusCode == 200) {
        final productList = <Product>[];
        final data = value.data as List;
        for (var element in data) {
          var parsedData = Product.fromJson(element);
          if (parsedData.id == -1) continue;
          productList.add(parsedData);
        }
        return CustomResponse(data: productList, error: null);
      } else {
        return const CustomResponse(data: null, error: 'Error');
      }
    } catch (e) {
      return const CustomResponse(data: null, error: 'Error');
    }
  }

  static Future<CustomResponse> fetchSingleProducts(
      Dio instance, int productId) async {
    try {
      final value = await instance.get('/products/$productId');
      if (value.statusCode == 200) {
        final data = Product.fromJson(value.data);
        return CustomResponse(data: data, error: null);
      } else {
        return const CustomResponse(data: null, error: 'Error');
      }
    } catch (e) {
      return const CustomResponse(data: null, error: 'Error');
    }
  }
}
