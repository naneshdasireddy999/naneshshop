import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';
import 'package:naneshshop/modules/product_overiew/widgets/app_drawer.dart';
import 'package:naneshshop/modules/product_overiew/widgets/product_overview_error.dart';
import 'package:naneshshop/modules/product_overiew/widgets/product_overview_loading.dart';
import 'package:naneshshop/modules/product_overiew/widgets/product_overview_success.dart';

enum Filteroption { favourites, all }

class ProductOverview extends StatelessWidget {
  const ProductOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProductoverviewCubit>();
    final cubit2 = context.watch<CartCubit>();
    cubit2.fetchcartitems();

    cubit.fetchproducts();
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (Filteroption f) {
              if (f == Filteroption.favourites) {
                cubit.showfavoonly();
              } else {
                cubit.showall();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Filteroption.favourites,
                child: Text('only fav'),
              ),
              const PopupMenuItem(
                value: Filteroption.all,
                child: Text('all'),
              )
            ],
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: Badge(
                  badgeContent: Text(cubit2.cl.length.toString()),
                  child: const Icon(Icons.shopping_cart)))
        ],
        title: const Text('my shop'),
      ),
      body: cubit.state is ProductoverviewInitialstate
          ? const ProductOverviewLoading()
          : cubit.state is Productoverviewsuccessstate
              ? const ProductOverViewSuccess()
              : const ProductOverviewError(),
    );
  }
}
