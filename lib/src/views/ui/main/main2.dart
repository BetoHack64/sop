import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:SOP/src/views/ui/main/logout.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/main/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home: (BlocProvider.of<MainBloc>(context).estaLogado == true)
            ? Home()
            : LoginScreem(),
      );
    }),
  );
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MainBloc>(context).carregaDados();
  }

/*
  partilha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreem()),
        (Route<dynamic> route) => false);
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal de Operações'),
        backgroundColor: Colors.red[900],
        centerTitle: true,
        actions: [
          LogoutButton(),
        ],
        
      ),
      backgroundColor: Colors.white, //
      body: BlocBuilder<MainBloc, MainState>(
        bloc: BlocProvider.of<MainBloc>(context),
        builder: (context, state) {
          if (state is MainNetworkErrorOpeningState) {
            return Center(child: Text(state.message));
          } else if (state is MainOpeningState) {
            return Dashboard1(
              listaSistemas: state.lista,
            );
          }
          return Container();
        },
      ),
    );
  }
}
