import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapipagination/models/coin_model.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

// Event For Load FirstPage-Data (Default-Data)
class AppStarted extends CryptoEvent {}

// Event For Pull Down To Refresh
class RefreshCoins extends CryptoEvent {}

// Event For Display NextPage-Data (Hit The Bottom Of ScrollView)
class LoadMoreCoins extends CryptoEvent {
  final List<Coin> coins;

  const LoadMoreCoins({@required this.coins});

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'LoadMoreCoins : { Coins: $coins }';
}
