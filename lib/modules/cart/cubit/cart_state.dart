part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitialstate extends CartState {}

class Cartsuccessstate extends CartState {}

class Carterrorstate extends CartState {}
