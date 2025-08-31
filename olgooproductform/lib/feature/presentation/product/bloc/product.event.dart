part of 'product.bloc.dart';

sealed class ProductEvent extends Equatable{
  const  ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsFirstTimeEvent extends ProductEvent {
  final  String type;

  const LoadProductsFirstTimeEvent({ required this.type}); 
}

class LoadMoreProductsEvent extends ProductEvent {
  final String type;

  const LoadMoreProductsEvent({required this.type});

}
class CreateNewProductEvent extends ProductEvent {
  final Map<String, dynamic> data;

  const CreateNewProductEvent({required this.data});
}