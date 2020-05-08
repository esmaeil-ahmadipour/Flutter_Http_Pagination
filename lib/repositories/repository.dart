import 'dart:async';
import 'dart:convert';
import 'package:flutterapipagination/models/coin_model.dart';
import 'package:flutterapipagination/repositories/base_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com';
  static const int perPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];
    String requestUrl =
        '$_baseUrl/data/top/totalvolfull?limit=$perPage&tsym=USD&page=$page';
    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
          (json) => coins.add(Coin.fromJson(json)),
        );
      }
      return coins;
    } catch (error) {
      throw error;
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
