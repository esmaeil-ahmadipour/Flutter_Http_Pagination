import 'package:flutterapipagination/models/coin_model.dart';

abstract class BaseRepository {
  Future<List<Coin>> getTopCoins({int page});

  void dispose();
}
