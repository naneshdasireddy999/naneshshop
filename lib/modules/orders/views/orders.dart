import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/orders/cubit/order_cubit.dart';
import 'package:naneshshop/modules/orders/widgets/orders_error.dart';
import 'package:naneshshop/modules/orders/widgets/orders_loading.dart';
import 'package:naneshshop/modules/orders/widgets/orders_success.dart';
import 'package:naneshshop/modules/product_overiew/widgets/app_drawer.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrderCubit>();

    cubit.fetchorders();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: cubit.state is OrderInitialstate
          ? const OrdersLoading()
          : cubit.state is Ordersuccessstate
              ? const OrderSuccess()
              : const OrdersError(),
    );
  }
}
