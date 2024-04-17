import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/models/product_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Success([],0,0,'',0,0,'')) {
    on<_AddPaymentMethod>((event, emit) {
      // var currentStates = state as _Success;
      emit(const _Loading());
      emit(_Success(
        event.orders,
        event.orders.fold(
          0, (previousValue, element) => previousValue + element.quantity,),
        event.orders.fold(
          0, (previousValue, element) => previousValue + element.product.price),
        event.paymentMethod,
        0,0,''
      ));
    });

    on<_AddNominalbayar>((event, emit) {
      var currentStates =state as _Success;
      emit(const _Loading());
      emit(_Success(
        currentStates.products, 
        currentStates.totalQuantity, 
        event.nominal,
        currentStates.paymentMethod, 
        event.nominal,
        currentStates.idKasir,
        currentStates.namaKasir));
    },);
  }
}
