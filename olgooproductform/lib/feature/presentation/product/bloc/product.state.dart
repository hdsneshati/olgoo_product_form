part of 'product.bloc.dart';

class ProductState {
  final ProductStatus status;
  final int skip;
  final List<ProductEntity> products;
  final bool hasMoreData;
  ProductState(this.status, this.skip, this.products, this.hasMoreData);
 ProductState copyWith(
      {ProductStatus? newStatus,
      int? newSkip,
      List<ProductEntity>? newProducts,
      bool? newHasMoreData}) {
    return ProductState(
      newStatus ?? status,
      newSkip ?? skip,
      newProducts ?? products,
      newHasMoreData ?? hasMoreData,
    );
  }

}