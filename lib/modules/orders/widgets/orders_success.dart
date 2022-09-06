import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/orders/cubit/order_cubit.dart';
import 'dart:math';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrderCubit>();

    return ListView.builder(
        itemCount: cubit.ol.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                    subtitle: Text(cubit.ol[index].datetime.toString()),
                    title: Text('\$${cubit.ol[index].amount}'),
                    trailing: IconButton(
                      onPressed: () {
                        cubit.toggleexpanded();
                      },
                      icon: Icon(cubit.isexpanded
                          ? Icons.expand_less
                          : Icons.expand_more),
                    )),
                if (cubit.isexpanded)
                  SizedBox(
                    height: min(cubit.ol[index].products.length * 20 + 10, 180),
                    child: ListView.builder(
                      itemBuilder: (context, myindex) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.ol[index].products[myindex].title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${cubit.ol[index].products[myindex].quantity} x \$${cubit.ol[index].products[myindex].price}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            )
                          ],
                        );
                      },
                      itemCount: cubit.ol[index].products.length,
                    ),
                  )
              ],
            ),
          );
        });
  }
}
