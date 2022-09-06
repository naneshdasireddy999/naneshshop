import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/product_overiew/widgets/app_drawer.dart';
import 'package:naneshshop/modules/user_products/cubit/user_products_cubit.dart';
import 'package:naneshshop/modules/user_products/widgets/user_product_error.dart';
import 'package:naneshshop/modules/user_products/widgets/user_product_loading.dart';
import 'package:naneshshop/modules/user_products/widgets/user_products_success.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserProductsCubit>();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addproduct', arguments: -1);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: cubit.state is UserProductsInitialstate
          ? const UserProductLoading()
          : cubit.state is UserProductssuccessstate
              ? const UserProductsSuccess()
              : const UserProductError(),
    );
  }
}
