import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DismissibleWidget<T> extends StatefulWidget {
  final CardDetail item;
  final Widget child;
  final DismissDirectionCallback onDismissed;
  final int index;

  const DismissibleWidget(
      {required this.index,
      required this.item,
      required this.child,
      required this.onDismissed});

  @override
  State<DismissibleWidget<T>> createState() => _DismissibleWidgetState<T>();
}

class _DismissibleWidgetState<T> extends State<DismissibleWidget<T>> {
  bool temTexto = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context1) {
    return Slidable(

        // Specify a key if the Slidable is dismissible.
        key: ValueKey<CardDetail>(widget.item),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SizedBox(width: 50),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsetsDirectional.only(end: 10, top: 40),
              //color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final obsController = TextEditingController();
                      showDialog(
                        context: context1,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              'Observações',
                              style: TextStyle(
                                fontFamily: 'SEGOEUI',
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: TextField(
                              controller: obsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 5),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => obsController.clear(),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                            actions: [
                              Container(
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'SEGOEUI',
                                        ),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();

                                        String idAccount = sharedPreferences
                                                .getString('IdAccount') ??
                                            'bug idAcount';
                                        BlocProvider.of<ListaOperacoesBloc>(
                                                context1)
                                            .acaoBotoes(
                                                "REJECT",
                                                obsController.text,
                                                int.parse(widget.item.detalhes
                                                    .applicationId),
                                                int.parse(widget
                                                    .item.detalhes.operationId),
                                                int.parse(widget.item.detalhes
                                                    .operationCodId),
                                                int.parse(widget
                                                    .item.detalhes.stepID),
                                                20,
                                                int.parse(idAccount));
                                        List<String> lista =
                                            sharedPreferences.getStringList(
                                                    'ListaIdOperacoesAprovadas')
                                                as List<String>;
                                        List<int> intLista = lista
                                            .map((i) => int.parse(i))
                                            .toList();
                                        intLista.add(widget.index);
                                        lista = intLista
                                            .map((i) => i.toString())
                                            .toList();
                                        sharedPreferences.remove(
                                            'ListaIdOperacoesAprovadas');
                                        sharedPreferences.setStringList(
                                            'ListaIdOperacoesAprovadas', lista);
                                        BlocProvider.of<ListaOperacoesBloc>(
                                                context1)
                                            .foundUsers
                                            .removeAt(widget.index);
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context1,
                                          MaterialPageRoute(
                                            builder: (context1) =>
                                                ListaAprovacoes(
                                              nomeSistema: sistema,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xffe8912e)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                      ),
                                      child: const Text(
                                        'Confirmar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SEGOEUI',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'REJEITAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'SEGOEUI'
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xfffc312c)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      String idAccount =
                          sharedPreferences.getString('IdAccount') ??
                              'bug idAcount';
                      BlocProvider.of<ListaOperacoesBloc>(context1).acaoBotoes(
                          "NEXT",
                          '',
                          int.parse(widget.item.detalhes.applicationId),
                          int.parse(widget.item.detalhes.operationId),
                          int.parse(widget.item.detalhes.operationCodId),
                          int.parse(widget.item.detalhes.stepID),
                          20,
                          int.parse(idAccount));
                      List<String> lista = sharedPreferences.getStringList(
                          'ListaIdOperacoesAprovadas') as List<String>;
                      List<int> intLista =
                          lista.map((i) => int.parse(i)).toList();
                      intLista.add(widget.index);
                      lista = intLista.map((i) => i.toString()).toList();
                      sharedPreferences.remove('ListaIdOperacoesAprovadas');
                      sharedPreferences.setStringList(
                          'ListaIdOperacoesAprovadas', lista);

                      BlocProvider.of<ListaOperacoesBloc>(context1)
                          .foundUsers
                          .removeAt(widget.index);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaAprovacoes(
                            nomeSistema: sistema,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'APROVAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'SEGOEUI'
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff59c36a)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: widget.child);
  }

  mensagem(BuildContext context) {}

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(
          Icons.archive_sharp,
          color: Colors.white,
          size: 32,
        ),
      );

  Widget buildSwipeActionRight(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsetsDirectional.only(
            end: MediaQuery.of(context).size.width - 400, top: 40),
        color: Colors.grey[50],
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Aprovar'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Reprovar'),
            ),
          ],
        ),
      );
}
