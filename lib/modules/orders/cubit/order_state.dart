part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitialstate extends OrderState {}

class Ordererrorstate extends OrderState {}

class Ordersuccessstate extends OrderState {}
