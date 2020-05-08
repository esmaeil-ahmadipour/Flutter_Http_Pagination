import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapipagination/blocs/coins/crypto_bloc.dart';
import 'package:flutterapipagination/blocs/coins/crypto_event.dart';
import 'package:flutterapipagination/repositories/repository.dart';
import 'package:flutterapipagination/ui/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CryptoBloc(
        cryptoRepository: CryptoRepository(),
      )..add(
          AppStarted(),
        ),
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark,
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}
