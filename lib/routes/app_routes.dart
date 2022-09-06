import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/add_products/cubit/add_products_cubit.dart';
import 'package:naneshshop/modules/add_products/views/add_product.dart';
import 'package:naneshshop/modules/add_products/views/add_products.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/cart/views/cart.dart';
import 'package:naneshshop/modules/orders/cubit/order_cubit.dart';
import 'package:naneshshop/modules/orders/views/orders.dart';
import 'package:naneshshop/modules/product_detail/views/product_detail.dart';
import 'package:naneshshop/modules/product_overiew/cubit/auth_cubit.dart';
import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';
import 'package:naneshshop/modules/product_overiew/views/product_overview.dart';
import 'package:naneshshop/modules/product_overiew/widgets/auth_screen.dart';
import 'package:naneshshop/modules/user_products/cubit/user_products_cubit.dart';
import 'package:naneshshop/modules/user_products/views/user_products.dart';

class Approutes {
  static final poc = ProductoverviewCubit();
  static final cc = CartCubit();
  static final oc = OrderCubit();
  static final upc = UserProductsCubit();
  static final apc = AddProductsCubit();
  static final ac = AuthCubit();

  static Map<String, Widget Function(BuildContext)> myroutes() {
    return {
      '/': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ProductoverviewCubit>.value(
                value: poc,
              ),
              BlocProvider<CartCubit>.value(
                value: cc,
              ),
              BlocProvider<AuthCubit>.value(
                value: ac,
              ),
            ],
            child: const ProductOverview(),
          ),
      '/detail': (context) => BlocProvider.value(
            value: poc,
            child: const ProductDetail(),
          ),
      '/cart': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<CartCubit>.value(
                value: cc,
              ),
              BlocProvider<ProductoverviewCubit>.value(
                value: poc,
              ),
              BlocProvider<OrderCubit>.value(
                value: oc,
              ),
            ],
            child: const Cart(),
          ),
      '/order': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<OrderCubit>.value(
                value: oc,
              ),
            ],
            child: const Orders(),
          ),
      '/userproducts': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<UserProductsCubit>.value(
                value: upc,
              ),
              BlocProvider<ProductoverviewCubit>.value(
                value: poc,
              ),
            ],
            child: const UserProducts(),
          ),
      '/addproduct': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AddProductsCubit>.value(
                value: apc,
              ),
              BlocProvider<UserProductsCubit>.value(
                value: upc,
              ),
              BlocProvider<ProductoverviewCubit>.value(
                value: poc,
              ),
            ],
            child: AddProduct(),
          ),
    };
  }
}
