import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';

abstract class ProductStatus {}
class InintialProductStatus extends ProductStatus {}

class LoadingProductStatus extends ProductStatus {}

class FetchedProductStatus extends ProductStatus {
}

class ErrorProductStatus extends ProductStatus {
  final String msg;
  ErrorProductStatus({required this.msg});
}

class CreatedProductStatus extends ProductStatus {
  final ProductEntity data;
  CreatedProductStatus({required this.data});
}
class EmptyProductStatus extends ProductStatus {

  EmptyProductStatus();
}
