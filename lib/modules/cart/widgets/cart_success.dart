import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/cart/cubit/cart_cubit.dart';
import 'package:naneshshop/modules/orders/cubit/order_cubit.dart';

class CartSuccess extends StatelessWidget {
  const CartSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CartCubit>();
    final cubit2 = context.watch<OrderCubit>();
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'total',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Spacer(),
                Chip(
                    backgroundColor: Colors.pink,
                    label: Text("\$${cubit.carttotal()}")),
                TextButton(
                    onPressed: () async {
                      await cubit2.addorder(cubit.cl, cubit.carttotal());
                      await cubit.clearcart();
                    },
                    child: const Text('order now'))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: cubit.cl.length,
                itemBuilder: (ctx, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Dismissible(
                        confirmDismiss: (direction) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text('no')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text('yes')),
                                  ],
                                  title: const Text('are you sure?'),
                                  content: const Text(
                                      'do you want to remove item from cart'),
                                );
                              });
                        },
                        onDismissed: (direction) {
                          cubit.deletecartitem(cubit.cl[index].id, index);
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          color: Theme.of(context).errorColor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        key: ValueKey(cubit.cl[index].id),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            trailing: Text('${cubit.cl[index].quantity} x'),
                            subtitle: Text(
                                'total   \$${cubit.cl[index].price * cubit.cl[index].quantity}'),
                            title: Text(cubit.cl[index].title),
                            leading: CircleAvatar(
                              child: FittedBox(
                                  child: Text('\$${cubit.cl[index].price}')),
                            ),
                          ),
                        ),
                      ),
                    )))
      ],
    );
  }
}
