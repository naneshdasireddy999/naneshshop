import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';

class ProductOverViewSuccess extends StatelessWidget {
  const ProductOverViewSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProductoverviewCubit>();
    final cubit2 = context.watch<CartCubit>();
    cubit2.fetchcartitems();
    return GridView.builder(
        itemCount: cubit.pl.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: index);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                  footer: GridTileBar(
                    leading: IconButton(
                        onPressed: () {
                          cubit.changefavourite(
                              cubit.pl[index].id, cubit.pl[index]);
                        },
                        icon: Icon(
                          cubit.pl[index].isfavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.deepOrange,
                        )),
                    trailing: IconButton(
                        onPressed: () {
                          cubit2.zaddnewcartitem(cubit.pl[index].id,
                              cubit.pl[index].price, cubit.pl[index].title);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('added  item to cart'),
                              action: SnackBarAction(
                                  label: 'undo',
                                  onPressed: () {
                                    cubit2.removesinglecartitem(
                                        cubit.pl[index].id);
                                  }),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.deepOrange,
                        )),
                    backgroundColor: Colors.black87,
                    title: Text(
                      cubit.pl[index].title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  child: Image.network(
                    cubit.pl[index].imageurl,
                    fit: BoxFit.cover,
                  )),
            ),
          );
        });
  }
}
