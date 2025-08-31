import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/config/asset/icons_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';
import 'package:olgooproductform/core/widgets/empty_state.widget%20copy.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product.bloc.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product_status.dart';
import 'package:size_config/size_config.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PreferencesOperator preferencesOperator = PreferencesOperator(
    locator(),
  );
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 2️⃣ اضافه کردن listener به اسکرول
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        // وقتی به انتهای لیست رسیدیم، محصولات بیشتر لود می‌کنه
        BlocProvider.of<ProductBloc>(
          context,
        ).add(LoadMoreProductsEvent(type: "defaultCategory"));
      }
    });

    // 3️⃣ بارگذاری اولیه محصولات
    BlocProvider.of<ProductBloc>(
      context,
    ).add(LoadProductsFirstTimeEvent(type: "defaultCategory"));
  }

  @override
  void dispose() {
    // فراموش نکن که ScrollController رو dispose کنی
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
                //UserInfoSection(user: preferencesOperator.getUserData()),
              Divider(color: Theme.of(context).colorScheme.outline),
              DelayedWidget(
                animationDuration: const Duration(milliseconds: 400),
                delayDuration: const Duration(milliseconds: 800),
                animation: DelayedAnimations.SLIDE_FROM_RIGHT,

                child: Center(
                  child: PrimaryButton(
                    isPrimaryColor: true,
                    action: () {
                      context.pushNamed('/AddProductStep1');
                    },
                    child: Text(
                      textAlign: TextAlign.center,

                      'ثبت محصول جدید',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              30.0.verticalSpace,
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state.status is LoadingProductStatus) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status is FetchedProductStatus) {
                    final products = state.products;
                    return Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 1,
                            ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductItem(
                            productName: product.title,
                            productPrice: product.price,
                            productImage: product.imgPath,
                            ontap: () {
                              // رفتن به صفحه جزئیات محصول
                            },
                          );
                        },
                      ),
                    );
                  } else if (state.status is EmptyProductStatus) {
                   return EmptyState(
                    title: 'سفارشی یافت نشد',
                    isError: false,
                    action: () {
                       context.pushNamed('/AddProductStep1');
                      
                    },
                  );
                  } else if (state.status is ErrorProductStatus) {
                     var msg = (state.status as ErrorProductStatus).msg;
                  return EmptyState(
                    title: msg,
                     isError: true,
                    action: () {
                       BlocProvider.of<ProductBloc>(context).add(
                            LoadProductsFirstTimeEvent(type: "defaultCategory"),
                         );
                    }
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key, required this.user});

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 26.h,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: SvgPicture.asset(
            IconPath.profile,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
            width: 26.w,
            height: 26.h,
          ),
        ),
        12.w.horizontalSpacer,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user['name'],
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "dana",
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              user['role'],
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "dana",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          'تکمیل اطلاعات تولیدی',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "dana",
            fontWeight: FontWeight.w600,
            color: Color(0xff367CFF),
          ),
        ),
      ],
    );
  }
}

/*class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status is LoadingProductStatus) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status is FetchedProductStatus) {
           final products = state.products;
          return Expanded(
            child: GridView.builder(
              controller: _scrollController,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 0.8,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
          return ProductItem(
            productName: product.title,
            productPrice: product.price,
            productImage: product.imgPath,
            ontap: () {
              // رفتن به صفحه جزئیات محصول
            },
          );
              },
            ),
          );
        }  else if (state.status is EmptyProductStatus) {
      return const Center(child: Text("هیچ محصولی موجود نیست"));
    } else if (state.status is ErrorProductStatus) {
      return Center(
        child: TextButton(
          child: const Text("خطا! دوباره تلاش کن"),
          onPressed: () {
            BlocProvider.of<ProductBloc>(context).add(LoadProductsFirstTimeEvent(type: "defaultCategory"));
          },
        ),
      );
    } else {
      return Container();
    }
      },
    );
  }
}
*/
class ProductItem extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final int productOldPrice;
  final int productDiscount;
  final int productTimer;
  final VoidCallback ontap;
  const ProductItem({
    required this.ontap,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.productOldPrice = 0,
    this.productDiscount = 0,
    this.productTimer = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE3E3E3)),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        // width: 184.w,
        //height: 194.h,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                "assets/img/img.png",
                width: 184.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                productName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "dana",
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
            ),
            8.0.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${productPrice}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "dana",
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                /*   Visibility(
                  visible: productDiscount > 0? true : false,
                  child: Container(
                    padding: const EdgeInsets.all(
                       12 * 0.5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(40.h),
                    ),
                    child: Text(
                    ' $productDiscount%',
                      
                    ),
                  ),
                )
            */
              ],
            ),
            Spacer(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: 184.w,
                height: 23.h,
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(color: Color(0xffE3E3E3), width: 1),
                    left: BorderSide.none,
                    right: BorderSide.none,
                    bottom: BorderSide.none,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                  ),
                ),
                child: Text(
                  'مشاهده یا ویرایش',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: "dana",
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3280FF),
                  ),
                ),
              ),
            ),
            /*    Visibility(
              visible: productTimer != 0 ? true : false,
              child: Container(
                height: 2.h,
                width: double.infinity,
                color: ColorPallet.lightColorScheme.primary,
              ),
            ),
            Visibility(
              visible: productTimer != 0 ? true : false,
              child: Text(
                '$productTimer',
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
