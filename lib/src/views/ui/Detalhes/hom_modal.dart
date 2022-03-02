import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/views/ui/Detalhes/AprovarRejeitar.dart';
import 'package:SOP/src/views/ui/Detalhes/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String nome = '';

class HomeModal extends StatefulWidget {
  @override
  _HomeModalState createState() => _HomeModalState();
}

class _HomeModalState extends State<HomeModal> {
  @override
  void initState() {
    super.initState();
  }

  String f = '';

  _listaFicheiro(int i, int aux) {
    return GestureDetector(
      onTap: () async {
        String fo = detalhes.anexo[i].data[aux].valor.toString() == 'PDF'
            ? 'pdf'
            : 'bug';
        BlocProvider.of<AprovarReprovarBloc>(context).ficheiroString =
            await BlocProvider.of<AprovarReprovarBloc>(context).buscaPDF(
                detalhes.anexo[i].operationId, detalhes.anexo[i].idConteudo);
         BlocProvider.of<AprovarReprovarBloc>(context).nomeAnexo = detalhes.anexo[i].data[aux].valor;
BlocProvider.of<AprovarReprovarBloc>(context).opID =detalhes.anexo[aux].operationId;
BlocProvider.of<AprovarReprovarBloc>(context).idCont = detalhes.anexo[aux].idConteudo;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider.value(
                value: BlocProvider.of<AprovarReprovarBloc>(context),
                  child: PdfVer(sis: '',),
                
              );
            },
          ),
        );
      },
      child: Card(
        // Inicia Aqui o 1º card com a  informação referente ao numero da conta
        elevation: 3.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.picture_as_pdf, color: Colors.red[900]),
            ),
            title: Text(
              detalhes.anexo[i].data[aux].valor,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            
            //trailing: Icon(Icons.favorite_outline),
          ), //makeListTile,
        ), // termina Aqui o 1º card com a  informação referente ao numero da conta
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Form(
          child: Column(
            children: [
              //Lista de Arquivos
              Card(
                // Inicia Aqui o 1º card com a  informação referente ao numero da conta
                elevation: 3.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24)),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.red[900],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return AprovarRejeitar(detalhes);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    title: Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Text(
                        detalhes.dados[0].valor,
                        style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              //Final Lista
              if (detalhes.anexo.isNotEmpty)
                if ((detalhes.anexo.length) < 2) //Se tiver apenas 1 anexo
                  for (int aux = 0;
                      aux < (detalhes.anexo[0].data.length) - 1;
                      aux++)
                    if (detalhes.anexo[0].data[aux].campo != 'Formato')
                      _listaFicheiro(0, aux),
              if (detalhes.anexo.isNotEmpty)
                if ((detalhes.anexo.length) >= 2)
                  for (int i = 0; i < (detalhes.anexo.length); i++)
                    for (int aux = 0;
                        aux < (detalhes.anexo[i].data.length) - 1;
                        aux++)
                      _listaFicheiro(i, aux),
            ],
          ),
        ),
      ),
    );
  }
}
