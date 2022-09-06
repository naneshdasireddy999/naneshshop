import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naneshshop/data/services/remote_services.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  AddProductsCubit() : super(AddProductsInitialstate());
  void addnewtodo() {
    try {
      emit(AddProductssuccessstate());
    } on Exception catch (e) {}
  }
}
