import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/data/services/remote_services.dart';
import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';

class UserProductsSuccess extends StatelessWidget {
  const UserProductsSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit2 = context.watch<ProductoverviewCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: cubit2.pl.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(cubit2.pl[index].imageurl),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/addproduct', arguments: index);
                          },
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).primaryColor,
                        ),
                        IconButton(
                          onPressed: () {
                            RemoteServices.deleteproductsinfirebase(
                                cubit2.pl[index].id);
                            print('hi');
                          },
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                      ],
                    ),
                  ),
                  title: Text(cubit2.pl[index].title),
                ),
                const Divider()
              ],
            );
          }),
    );
  }
}
