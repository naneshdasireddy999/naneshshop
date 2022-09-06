import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/cart/widgets/cart_error.dart';
import 'package:naneshshop/modules/cart/widgets/cart_loading.dart';
import 'package:naneshshop/modules/cart/widgets/cart_success.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CartCubit>();
    cubit.carttotal();
    cubit.fetchcartitems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart'),
      ),
      body: cubit.state is CartInitialstate
          ? const CartLoading()
          : cubit.state is Cartsuccessstate
              ? const CartSuccess()
              : const CartError(),
    );
  }
}
