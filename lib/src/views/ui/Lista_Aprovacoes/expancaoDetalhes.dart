/*import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String fornec = '';
String id = '';

class ExpancaoDetalhes extends StatefulWidget {
  ExpancaoDetalhes(String fornecedor, String idOp) {
    fornec = fornecedor;
    id = idOp;
  }

  @override
  State<ExpancaoDetalhes> createState() => _ExpancaoDetalhesState();
}

class _ExpancaoDetalhesState extends State<ExpancaoDetalhes> {
  @override
  initState() {
    super.initState();
    print(id);
  }

  String seta = 'assets/setabaixo.PNG';
  bool estaExpandido = false;
  @override
  Widget build(BuildContext context) {
  BlocProvider.of<ListaOperacoesBloc>(context).buscaDetalhes(id);
    return ExpansionTile(
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
      onExpansionChanged: (value) {
        //print(value);

        if (value == true) {
          setState(() {
            seta = "assets/setacima.PNG";
            estaExpandido = true;
          });
          if (estaExpandido == true) {
            
            BlocProvider.of<ListaOperacoesBloc>(context).columns = [
              BlocProvider.of<ListaOperacoesBloc>(context)
                  .detalhes
                  .grelha
                  .header
                  .coluna1,
              BlocProvider.of<ListaOperacoesBloc>(context)
                  .detalhes
                  .grelha
                  .header
                  .coluna2,
              BlocProvider.of<ListaOperacoesBloc>(context)
                  .detalhes
                  .grelha
                  .header
                  .coluna3,
            ];
          }
        } else {
          setState(() {
            seta = "assets/setabaixo.PNG";
            estaExpandido = false;
          });
        }
      },
      title: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              seta,
              height: 30,
              width: 30,
            ),
          ),
          Text(fornec),
        ],
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      //leading: ,

      // trailing: Icon(Icons.no),
      children: [
        estaExpandido == true
            ? ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0.0,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //aqui irei colocar todos os widgets q farão parte dos detalhes
                    Container(
                      margin: EdgeInsets.only(right: 0, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 0,
                              bottom: 2,
                              //left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Intrução for
                                for (int i = 2;
                                    i <
                                        BlocProvider.of<ListaOperacoesBloc>(
                                                context)
                                            .detalhes
                                            .dados
                                            .length;
                                    i++)
                                  (BlocProvider.of<ListaOperacoesBloc>(context)
                                              .detalhes
                                              .dados[i]
                                              .valor ==
                                          'ok')
                                      ? BlocProvider.of<ListaOperacoesBloc>(
                                              context)
                                          .camposPovoar(++i)
                                      : BlocProvider.of<ListaOperacoesBloc>(
                                              context)
                                          .camposPovoar(i),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      color: Colors.black,
                    ),
                    Container(
                      child: BlocProvider.of<ListaOperacoesBloc>(context)
                          .tabelaDados(),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
*/