import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  @override
  CryptoState get initialState => InitialCryptoState();

  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
