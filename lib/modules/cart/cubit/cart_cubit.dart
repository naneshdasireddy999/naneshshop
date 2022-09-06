import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naneshshop/data/models/cart_model.dart';
import 'package:naneshshop/data/services/remote_services.dart';
import 'package:naneshshop/modules/cart/views/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialstate());
  List<Cartitem> cl = [];
  double carttotal() {
    emit(Cartsuccessstate());
    var total = 0.0;
    for (var element in cl) {
      total += element.price * element.quantity;
    }
    return total;
  }

  Future<void> clearcart() async {
    try {
      for (var i in cl) {
        await RemoteServices.deletecartinfirebase(i.id);
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<void> zaddnewcartitem(
    String productid,
    double price,
    String title,
  ) async {
    try {
      if (cl.any((element) => element.id == productid)) {
        final quantity =
            cl.firstWhere((element) => element.id == productid).quantity;

        await RemoteServices.editcartitemsinfirebase(productid, quantity);
      } else {
        await RemoteServices.addcartiteminfirebase(productid, price, title);
      }
    } on Exception catch (e) {}
  }

  Future<void> deletecartitem(String id, int index) async {
    try {
      cl.removeAt(index);
      RemoteServices.deletecartitem(id);
    } on Exception catch (e) {}
  }

  Future<void> removesinglecartitem(String id) async {
    try {
      if (cl.any((element) => element.id == id)) {
        final quantity = cl.firstWhere((element) => element.id == id).quantity;

        if (quantity > 1) {
          await RemoteServices.editmycartitemsinfirebase(id, quantity);
        } else {
          await RemoteServices.deletecartiteminfirebase(id);
        }
      }
    } on Exception catch (e) {}
  }

  Future<void> fetchcartitems() async {
    var myitems = await RemoteServices.fetchcartitemsfromfirebase();
    if (myitems != null) {
      cl = myitems;
    } else {
      emit(CartInitialstate());
    }
  }
}
