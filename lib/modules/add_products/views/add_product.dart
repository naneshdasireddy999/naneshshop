import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:naneshshop/data/services/remote_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naneshshop/modules/add_products/cubit/add_products_cubit.dart';
import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final imageurlcontroller = TextEditingController();

  final titlecontroller = TextEditingController();

  final pricecontroller = TextEditingController();

  final descriptioncontroller = TextEditingController();

  final imagefocusnode = FocusNode();

  final formkey = GlobalKey<FormState>();

  bool isrun = true;
  late int index;

  void saveform() {
    bool? isvalid = formkey.currentState?.validate();
    if (isvalid == true) {
      formkey.currentState?.save();
    } else {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    if (isrun) {
      index = ModalRoute.of(context)!.settings.arguments as int;
      final cubit2 = context.watch<ProductoverviewCubit>();
      titlecontroller.text = index == -1 ? '' : cubit2.pl[index].title;
      imageurlcontroller.text = index == -1 ? '' : cubit2.pl[index].imageurl;
      pricecontroller.text =
          index == -1 ? '' : cubit2.pl[index].price.toString();
      descriptioncontroller.text =
          index == -1 ? '' : cubit2.pl[index].description;
      isrun = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddProductsCubit>();
    final cubit2 = context.watch<ProductoverviewCubit>();

    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (cubit.state is AddProductssuccessstate) {
          Navigator.pop(context);
        } else {
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  saveform();
                  final id = index == -1 ? null : cubit2.pl[index].id;
                  if (cubit2.pl.any((element) => element.id == id)) {
                    await RemoteServices.editproductinfirebase(
                      id,
                      titlecontroller.text,
                      descriptioncontroller.text,
                      double.parse(pricecontroller.text),
                      imageurlcontroller.text,
                    );
                    cubit.addnewtodo();
                  } else {
                    await RemoteServices.addnewproduct(
                            titlecontroller.text,
                            descriptioncontroller.text,
                            double.parse(pricecontroller.text),
                            imageurlcontroller.text)
                        .catchError((e) {
                      return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('ok'))
                                ],
                                title: const Text('an error occured'),
                                content: const Text('something went wrong'),
                              ));
                    });
                    cubit.addnewtodo();
                  }
                },
                icon: const Icon(Icons.save))
          ],
          title: const Text('add products'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formkey,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      titlecontroller.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a valid title';
                      } else {
                        return null;
                      }
                    },
                    controller: titlecontroller,
                    decoration: const InputDecoration(labelText: 'title'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      pricecontroller.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a valid price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'please enter valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'please enter valid number greater than 0';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: pricecontroller,
                    decoration: const InputDecoration(labelText: 'price'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      descriptioncontroller.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a valid description';
                      }
                      if (value.length < 10) {
                        return 'please enter a description which has more information';
                      } else {
                        return null;
                      }
                    },
                    controller: descriptioncontroller,
                    decoration: const InputDecoration(labelText: 'description'),
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: imageurlcontroller.text.isEmpty
                            ? const Text('enter a url')
                            : FittedBox(
                                child: Image.network(
                                  imageurlcontroller.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                          child: TextFormField(
                        onSaved: (value) {
                          imageurlcontroller.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter a valid imageurl';
                          } else {
                            return null;
                          }
                        },
                        focusNode: imagefocusnode,
                        controller: imageurlcontroller,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        decoration:
                            const InputDecoration(labelText: 'imageurl'),
                        onFieldSubmitted: (_) {
                          saveform();
                        },
                      ))
                    ],
                  )
                ],
              ))),
        ),
      ),
    );
  }
}
