import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naneshshop/data/models/product_model.dart';
import 'package:naneshshop/data/services/remote_services.dart';
import 'package:naneshshop/modules/product_overiew/widgets/product_overview_success.dart';

part 'productoverview_state.dart';

class ProductoverviewCubit extends Cubit<ProductoverviewState> {
  ProductoverviewCubit() : super(ProductoverviewInitialstate());
  List<Product> pl = [];
  bool showfavonly = false;
  Future<void> fetchproducts() async {
    var mytodo = await RemoteServices.fetchproductsfromfirebase();
    if (mytodo != null) {
      if (showfavonly == false) {
        pl = mytodo;
      } else {
        pl = mytodo.where((element) => element.isfavourite == true).toList();
      }

      emit(Productoverviewsuccessstate());
    } else {
      emit(Productoverviewerrorstate());
    }
  }

  void showfavoonly() {
    showfavonly = true;
  }

  void showall() {
    showfavonly = false;
  }

  Future<void> changefavourite(String id, Product p) async {
    try {
      var mytodo = await RemoteServices.changefavouriteinfirebase(id, p);
    } on Exception catch (e) {}
  }
}
