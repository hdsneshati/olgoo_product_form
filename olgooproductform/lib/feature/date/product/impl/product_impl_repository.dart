import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/resource/data_state.dart';
import 'package:olgooproductform/core/utils/error.handler.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';
import 'package:olgooproductform/feature/date/product/src/remote/product.api.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryIMPL {
 final ProductApiProvider apiProvider ;
 PreferencesOperator preferencesOperator =
      PreferencesOperator(locator<SharedPreferences>());
   ProductRepositoryIMPL({required this.apiProvider});
 
    Future<DataState<List<ProductEntity>>> getAllProducts({required int take , required int skip , String? type}) async {
    try {
      Response response = await apiProvider.getAllProducts(take:  take  ,skip:   skip ,type:   type);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["products"];
        List<ProductEntity> products =
            data.map((json) => ProductEntity.fromJson(json)).toList();
        return SuccessData(products);
      } else {
        return const FailedData("یه مشکلی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }
  

 
  Future<DataState<ProductEntity>> createProduct(dynamic productData) async {
    try {
      Response response = await apiProvider.createProduct(productData);
      if (response.statusCode == 201) {
        ProductEntity product = ProductEntity.fromJson(response.data);
        return SuccessData(product);
      } else {
        return const FailedData("یه مشکلی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }





 
}