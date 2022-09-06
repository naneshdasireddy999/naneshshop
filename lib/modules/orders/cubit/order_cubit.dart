import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naneshshop/data/models/order_model.dart';
import 'package:naneshshop/data/services/remote_services.dart';

import '../../../data/models/cart_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialstate());
  List<Order> ol = [];
  bool isexpanded = false;
  void toggleexpanded() {
    isexpanded = !isexpanded;
  }

  Future<void> addorder(List<Cartitem> cartproducts, double total) async {
    try {
      await RemoteServices.addorderiteminfirebase(cartproducts, total);
    } on Exception catch (e) {}
  }

  Future<void> fetchorders() async {
    var mytodo = await RemoteServices.fetchorders();
    if (mytodo != null) {
      ol = mytodo;

      emit(Ordersuccessstate());
    } else {
      emit(Ordererrorstate());
    }
  }
}
