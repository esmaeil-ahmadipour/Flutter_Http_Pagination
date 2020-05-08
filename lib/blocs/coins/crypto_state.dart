import 'package:equatable/equatable.dart';
import 'package:flutterapipagination/models/coin_model.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
}

//Initial
class InitialCryptoState extends CryptoState {
  @override
  List<Object> get props => [];
}

// Fetch From Api
class CryptoLoading extends CryptoState {
  @override
  List<Object> get props => [];
}

// Retrieved Data
class CryptoLoaded extends CryptoState {
  final List<Coin> coins;

  const CryptoLoaded({this.coins});

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'CryptoLoaded {coins: $coins}';
}

// API Request Error
class CryptoError extends CryptoState {
  @override
  List<Object> get props => [];
}
