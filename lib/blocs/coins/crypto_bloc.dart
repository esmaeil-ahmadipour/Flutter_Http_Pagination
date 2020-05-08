import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterapipagination/models/coin_model.dart';
import 'package:flutterapipagination/repositories/repository.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({@required CryptoRepository cryptoRepository})
      : assert(cryptoRepository != null),
        _cryptoRepository = cryptoRepository;

  @override
  CryptoState get initialState => InitialCryptoState();

  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins(coins: []);
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoinsState(event);
    }
  }

  Stream<CryptoState> _getCoins({List<Coin> coins, int page = 0}) async* {
    //Request Coins

    try {
      List<Coin> newCoinList=coins+ await _cryptoRepository.getTopCoins(page: page);
      yield CryptoLoaded(coins: newCoinList);

    } catch (error) {
      yield CryptoError();
    }
  }

  Stream<CryptoState> _mapAppStartedToState() async*{
    yield CryptoLoading();
    yield* _getCoins(coins: []);
  }

  Stream<CryptoState>  _mapLoadMoreCoinsState(LoadMoreCoins event)async* {
    final int nextPage= event.coins.length ~/ CryptoRepository.perPage;
    yield* _getCoins(coins: event.coins,page: nextPage);
  }
}
