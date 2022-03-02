import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Detalhes/espereUmSegundo.dart';
import 'package:SOP/src/views/ui/Detalhes/hom_modal.dart';
import 'package:SOP/src/views/ui/Login/mensagem.dart';
import 'package:SOP/src/views/ui/main/drawer.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

OperationData detalhes = OperationData(
  applicationId: '',
  operationCodId: '',
  operationId: '',
  header: Header(campo: '', valor: ''),
  dados: [],
  grelha: Grelha(
      header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''), data: []),
  anexo: [],
);
void main() {
  runApp(AprovarRejeitar(detalhes));
}

class AprovarRejeitar extends StatelessWidget {
  AprovarRejeitar(OperationData detalhesDados) {
    detalhes = detalhesDados;
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AprovarReprovarBloc>(context).detalhes = detalhes;
    BlocProvider.of<AprovarReprovarBloc>(context).columns = [
      detalhes.grelha.header.coluna1,
      detalhes.grelha.header.coluna1,
      detalhes.grelha.header.coluna1,
    ];
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: RetrocederButton(telaRetroceder: 'aprovarReprovar'),
        elevation: 4.0,
        backgroundColor: Colors.red[900],
        title: Container(
        margin: EdgeInsets.only(right:15),
          child: Text(
            detalhes.dados[0].valor.toUpperCase() +
                '                ' +
                detalhes.operationId, // ${id}
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        centerTitle: true,
      ),

      //Botões inferiores

      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSpacing: MainAxisSpacing.right,
        children: [
          Container(
            //color: Colors.amber,
            margin: const EdgeInsets.only(
                // top: 1,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Aprovar'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Aprovar'.toUpperCase());
                      },
                    ),
                  ),
                ),
                //Fim botão aprovar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Rejeitar'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Colors.red[900],
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        print('Rejeitar'.toUpperCase());
                      },
                    ),
                  ),
                ),
                //Fim btn rejeitar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50, //altura do button
                    width: 100, //Largura button
                    child: ElevatedButton(
                      child: Text('Anexos'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        primary: Color(0xFF263238),
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        if (detalhes.anexo.isEmpty == true) {
                          Future.delayed(Duration(seconds: 0),
                              () => MensagemLogin.naoTemAnexo(context));
                        }
                        if (detalhes.anexo.isEmpty == false) {
                          print(detalhes.dados[0].valor);
                          print(detalhes.operationId);
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<AprovarReprovarBloc>(context),
                              child: HomeModal(),
                              
                            ),
                          );
                          
                        }
                       
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //

      //Design do Conteúdo toda descrição da operaçã à aprovar ou rejeitar
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            //Informação de cabeçalho
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 18,
                  // bottom: 12,
                  //left: 10,
                ),
                child: Text(
                  detalhes.header.valor.isEmpty
                      ? 'vazio'
                      : detalhes.header.valor,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans"),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            //Fim divisão Operação
            Card(
              // Inicia Aqui o 1º card com a  informação referente ao numero da conta
              elevation: 5.0,
              margin: new EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 0, 0, 0),
                ),

                child: ListTile(
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
                                      i < detalhes.dados.length;
                                      i++)
                                    (detalhes.dados[i].valor == 'ok')
                                        ? BlocProvider.of<AprovarReprovarBloc>(
                                                context)
                                            .camposPovoar(++i)
                                        : BlocProvider.of<AprovarReprovarBloc>(
                                                context)
                                            .camposPovoar(i),

                                  // _camposPovoar(i),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: Colors.black,
                      ),
                      BlocProvider.of<AprovarReprovarBloc>(context)
                          .tabelaDados(),
                    ],
                  ),
                ), //makeListTile,
              ), // termina Aqui o 1º card com a  informação referente ao numero da conta
            ),

            //Card com informações dos produtos
            //botões estavam aqui  *btns*

            //Fim dos botões
          ],
        ),
      ),
      //Fim do Conteúdo

      drawer: DrawerMenu(),
    );
  }
}
