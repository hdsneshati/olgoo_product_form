import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/utils/api.interceptor.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';

class ProductApiProvider{
 final PreferencesOperator preferencesOperator = PreferencesOperator(locator());
  final DioClient _dio = locator<DioClient>();
  
   Future<dynamic> getAllProducts(
      {required int take, required int skip, String? type}) async {
    String url;
    if (type != null) {
      type = Uri.encodeComponent(type);
      url = "product?take=$take&skip=$skip&type=$type";
    } else {
      url = "product?take=$take&skip=$skip";
    }
    var response = await _dio.client.get(url);
    return response;
  }


   Future<dynamic> createProduct(dynamic productData) async {
    String url = "product";

    var response = await _dio.client.post(url, data: productData);
    return response;
  }
}