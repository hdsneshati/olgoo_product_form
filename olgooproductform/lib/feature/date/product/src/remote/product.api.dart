import 'package:dio/dio.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/utils/api.interceptor.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';

class ProductApiProvider {
  final PreferencesOperator preferencesOperator = PreferencesOperator(locator());
  final DioClient _dio = locator<DioClient>();
final List<Map<String, dynamic>> _products = List.generate(20, (index) {
   return {
  "id": index,
  "title": "محصول $index",
  "status": "200",
  "type": "همه",
  "registerDate": "2025-08-${31 - index}T12:00:00.000Z",
  "imgPath": "assets/img/img.png",
  "price": 10000 + index * 500,        // قیمت محصول
  "oldPrice": 12000 + index * 500,     // قیمت قبل تخفیف (اختیاری)
  "discount": index % 3 == 0 ? 10 : 0, // درصد تخفیف (اختیاری)
  "category": {
    "id": index,
    "title": index % 2 == 0 ? "کتاب" : "لوازم التحریر",
    "isCustom": index % 2 == 0
  }
};

  });
  // شبیه‌سازی متد گرفتن همه محصولات
  Future<Response> getAllProducts({
    required int take,
    required int skip,
    String? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // شبیه‌سازی تاخیر شبکه

    // فیلتر کردن بر اساس type اگر داده شده باشد
    List<Map<String, dynamic>> filtered = _products;
    if (type != null && type.isNotEmpty) {
      filtered = filtered.where((p) => p['type'] == type).toList();
    }

    // شبیه‌سازی pagination
    final paginated = filtered.skip(skip).take(take).toList();

    // ساخت Response شبیه Dio
    return Response(
      requestOptions: RequestOptions(path: "/products"),
      statusCode: 200,
      data: {
        "count": filtered.length,
        "products": paginated,
      },
    );
  }


  // شبیه‌سازی ایجاد محصول
  Future<Response> createProduct(dynamic productData) async {
    productData["id"] = DateTime.now().millisecondsSinceEpoch;

    await Future.delayed(const Duration(seconds: 1));

    return Response(
      requestOptions: RequestOptions(path: "product"),
      statusCode: 201,
      data: productData,
    );
  }
}
