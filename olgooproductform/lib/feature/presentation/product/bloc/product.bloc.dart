import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';
import 'package:olgooproductform/feature/domain/product/usecase/product_usecase.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product_status.dart';

import '../../../../../core/resource/data_state.dart';

part 'product.event.dart';
part 'product.state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase useCases;
  final int pageSize = 10;
  ProductBloc(this.useCases)
      : super(ProductState(InintialProductStatus(), 0, [], true)) {
    
    on<LoadProductsFirstTimeEvent>(
      (event, emit) async {
        emit(ProductState(LoadingProductStatus(), 0, [], true));
        String? type = event.type == "همه" ? null : event.type;
        DataState data =
            await useCases.getAllProducts(take: pageSize, skip: 0, type: type);
        if (data is SuccessData) {
          if (data.data.isEmpty) {
            emit(state.copyWith(newStatus: EmptyProductStatus()));
          } else {
            emit(state.copyWith(
                newStatus: FetchedProductStatus(),
                newProducts: data.data,
                newHasMoreData: data.data.length == pageSize,
                newSkip: pageSize));
          }
        } else {
          emit(state.copyWith(newStatus: ErrorProductStatus(msg: data.error!)));
        }
      },
    );
    on<LoadMoreProductsEvent>(
      (event, emit) async {
        if (!state.hasMoreData) return; // اگر داده‌ای برای لود نیست، خروج
        emit(state.copyWith(newStatus: LoadingProductStatus()));
         String? type = event.type == "همه" ? null : event.type;
        DataState<List<ProductEntity>> data =
            await useCases.getAllProducts(skip: state.skip, take: pageSize , type: type);
        if (data is SuccessData) {
          emit(state.copyWith(
            newStatus: FetchedProductStatus(),
            newProducts: [
              ...state.products,
              ...data.data!,
            ], // داده‌های جدید به لیست اضافه می‌شوند
            newSkip: state.skip + pageSize,
            newHasMoreData: data.data!.length == pageSize,
          ));
        } else {
          emit(state.copyWith(newStatus: ErrorProductStatus(msg: data.error!)));
        }
      },
    );
    on<CreateNewProductEvent>(
      (event, emit) async {
        emit(ProductState(LoadingProductStatus(), 0, [], true));
        DataState data = await useCases.createProduct(event.data);
        if (data is SuccessData) {
          emit(
              state.copyWith(newStatus: CreatedProductStatus(data: data.data)));
        } else {
          emit(state.copyWith(newStatus: ErrorProductStatus(msg: data.error!)));
        }
      },
    ); 
   
  }
}
