import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_products_state.dart';

class UserProductsCubit extends Cubit<UserProductsState> {
  UserProductsCubit() : super(UserProductssuccessstate());
}
