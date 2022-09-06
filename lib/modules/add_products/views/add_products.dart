// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:naneshshop/data/services/remote_services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:naneshshop/modules/add_products/cubit/add_products_cubit.dart';
// import 'package:naneshshop/modules/product_overiew/cubit/productoverview_cubit.dart';

// class AddProducts extends StatefulWidget {
//   const AddProducts({Key? key}) : super(key: key);

//   @override
//   State<AddProducts> createState() => _AddProductsState();
// }

// class _AddProductsState extends State<AddProducts> {
//   final imageurlcontroller = TextEditingController();
//   final titlecontroller = TextEditingController();
//   final pricecontroller = TextEditingController();
//   final descriptioncontroller = TextEditingController();

//   final imagefocusnode = FocusNode();
//   final formkey = GlobalKey<FormState>();

//   void saveform() {
//     bool? isvalid = formkey.currentState?.validate();
//     if (isvalid == true) {
//       formkey.currentState?.save();

//       RemoteServices.addnewproduct(
//           titlecontroller.text,
//           descriptioncontroller.text,
//           double.parse(pricecontroller.text),
//           imageurlcontroller.text);
//     } else {
//       return;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.watch<AddProductsCubit>();
//     final cubit2 = context.watch<ProductoverviewCubit>();
//     final index = ModalRoute.of(context)!.settings.arguments as int;
//     titlecontroller.text = index == -1 ? '' : cubit2.pl[index].title;
//     imageurlcontroller.text = index == -1 ? '' : cubit2.pl[index].imageurl;
//     pricecontroller.text = index == -1 ? '' : cubit2.pl[index].price.toString();
//     descriptioncontroller.text =
//         index == -1 ? '' : cubit2.pl[index].description;
//     return BlocListener(
//       bloc: cubit,
//       listener: (context, state) {
//         if (state is AddProductssuccessstate) {
//           Navigator.pop(context);
//         } else {
//           return;
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   saveform();
//                   final id = cubit2.pl[index].id;
//                   if (cubit2.pl.every((element) => element.id == id)) {
//                     RemoteServices.editproduct(id, cubit2.pl[index]);
//                   } else {
//                     RemoteServices.addnewproduct(
//                         titlecontroller.text,
//                         descriptioncontroller.text,
//                         double.parse(pricecontroller.text),
//                         imageurlcontroller.text);
//                   }

//                   cubit.addnewtodo();
//                 },
//                 icon: const Icon(Icons.save))
//           ],
//           title: const Text('add products'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//               key: formkey,
//               child: SingleChildScrollView(
//                   child: Column(
//                 children: [
//                   TextFormField(
//                     onSaved: (value) {
//                       titlecontroller.text = value!;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'please enter a valid title';
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: titlecontroller,
//                     decoration: const InputDecoration(labelText: 'title'),
//                     textInputAction: TextInputAction.next,
//                   ),
//                   TextFormField(
//                     onSaved: (value) {
//                       pricecontroller.text = value!;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'please enter a valid price';
//                       }
//                       if (double.tryParse(value) == null) {
//                         return 'please enter valid number';
//                       }
//                       if (double.parse(value) <= 0) {
//                         return 'please enter valid number greater than 0';
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.number,
//                     controller: pricecontroller,
//                     decoration: const InputDecoration(labelText: 'price'),
//                     textInputAction: TextInputAction.next,
//                   ),
//                   TextFormField(
//                     onSaved: (value) {
//                       descriptioncontroller.text = value!;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'please enter a valid description';
//                       }
//                       if (value.length < 10) {
//                         return 'please enter a description which has more information';
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: descriptioncontroller,
//                     decoration: const InputDecoration(labelText: 'description'),
//                     textInputAction: TextInputAction.next,
//                     maxLines: 3,
//                     keyboardType: TextInputType.multiline,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: 100,
//                         height: 100,
//                         margin: const EdgeInsets.only(top: 8, right: 10),
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1, color: Colors.grey)),
//                         child: imageurlcontroller.text.isEmpty
//                             ? const Text('enter a url')
//                             : FittedBox(
//                                 child: Image.network(
//                                   imageurlcontroller.text,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                       ),
//                       Expanded(
//                           child: TextFormField(
//                         onSaved: (value) {
//                           imageurlcontroller.text = value!;
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'please enter a valid imageurl';
//                           } else {
//                             return null;
//                           }
//                         },
//                         focusNode: imagefocusnode,
//                         controller: imageurlcontroller,
//                         keyboardType: TextInputType.url,
//                         textInputAction: TextInputAction.done,
//                         decoration:
//                             const InputDecoration(labelText: 'imageurl'),
//                         onFieldSubmitted: (_) {
//                           saveform();
//                         },
//                       ))
//                     ],
//                   )
//                 ],
//               ))),
//         ),
//       ),
//     );
//   }
// }
