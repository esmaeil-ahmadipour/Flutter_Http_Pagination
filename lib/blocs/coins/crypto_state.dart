import 'package:equatable/equatable.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
}

class InitialCryptoState extends CryptoState {
  @override
  List<Object> get props => [];
}

