import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapipagination/blocs/coins/bloc.dart';
import 'package:flutterapipagination/repositories/repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Pagination" ,style: TextStyle(color: Colors.purple),),
      ),
      body: BlocBuilder<CryptoBloc,CryptoState>(
          builder: (context, state) {
            return Container(
              color: Colors.black,
              width: double.infinity,
              child: _buildBody(state),
            );
          }),
    );
  }

  _buildBody(CryptoState state) {
    if (state is CryptoLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      );
    } else if (state is CryptoLoaded) {
      return RefreshIndicator(
        color: Theme.of(context).accentColor,
        onRefresh: () async {
          context.bloc<CryptoBloc>().add(RefreshCoins());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification)=>_onScrollNotification(notification , state),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.coins.length,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) return new Divider(color: Colors.purple); // notice color is added to style divider

              final coin = state.coins[index];
              return ListTile(
                leading: Column(
                  children: <Widget>[
                    Text(
                      '${++index}',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                title: Text(
                  coin.fullName,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  coin.name,
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  '\$ ${coin.price.toStringAsFixed(4)}',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ),
      );
    } else if (state is CryptoError) {
      return Center(
        child: Text(
          'Error loading coins!\nPlease check your connections.',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  bool _onScrollNotification(ScrollNotification notif , CryptoLoaded state){
    if(notif is ScrollEndNotification && _scrollController.position.extentAfter == 0){
      context.bloc<CryptoBloc>().add(LoadMoreCoins(coins: state.coins));
    }
    return false;
  }
}
