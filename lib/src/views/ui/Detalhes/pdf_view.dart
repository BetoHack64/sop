import 'dart:convert';

import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:path_provider/path_provider.dart';

late String sistemaNom = '';

class PdfVer extends StatefulWidget {
  final sis;
  PdfVer({required this.sis}) {
    sistemaNom = sis;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfVer> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl(BlocProvider.of<ListaOperacoesBloc>(context).nomeAnexo,
            BlocProvider.of<ListaOperacoesBloc>(context).ficheiroString)
        .then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(pathPDF: pathPDF)),
      );
    });
  }

  Future<File> createFileOfPdfUrl(String nome, String ficb64) async {
    late File filePdf;
    //formato = formato.toLowerCase();
    final decodedBytes = base64Decode(ficb64);
    final directory = await getApplicationDocumentsDirectory();
    filePdf = File('${directory.path}/$nome');
    print(filePdf.path);
    filePdf.writeAsBytesSync(List.from(decodedBytes));
    return filePdf;
  }

  @override
  void dispose() {
    print("dis 1");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Exemplo ')),
      body: Center(
        child: Text('ola'),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String pathPDF;
  PDFScreen({required this.pathPDF});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  void dispose() {
    print("dis");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffff9f9),
          title: Center(
            //margin: EdgeInsets.only(left: 10),
            child: Text(
              BlocProvider.of<ListaOperacoesBloc>(context)
                  .nomeAnexo
                  .toUpperCase(),
              style: TextStyle(
                fontFamily: 'SEGOEUI',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: RetrocederButton(
            telaRetroceder: 'anexoVer',
            sistema: sistemaNom,
          ),
          actions: <Widget>[Text('       ')],
        ),
        path: widget.pathPDF);
  }
}
