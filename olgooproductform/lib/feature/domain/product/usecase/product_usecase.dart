import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/resource/data_state.dart';
import 'package:olgooproductform/feature/date/product/impl/product_impl_repository.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';

class ProductUseCase {
  ProductRepositoryIMPL api= locator();

  Future<DataState<List<ProductEntity>>> getAllProducts(
      {required int take, required int skip, String? type}) {
    return api.getAllProducts(skip: skip, take: take, type: type);
  }

  Future<DataState<ProductEntity>> createProduct(dynamic productData) {
    return api.createProduct(productData);
  }
}