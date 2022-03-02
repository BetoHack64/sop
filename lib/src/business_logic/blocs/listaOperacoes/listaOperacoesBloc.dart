// ignore_for_file: unused_field, unused_element

import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/business_logic/repositories/aprovarReprovar/aprovarReprovarRepository.dart';
import 'package:SOP/src/business_logic/repositories/listaOperacoes/cardDetailRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaOperacoesBloc
    extends Bloc<ListaOperacoesEvent, ListaOperacoesState> {
  bool botaoHomeAparece = true;
  bool caixaDePesquisaEstaVisivel = false;
  String ficheiroString = "";
  String nomeAnexo = "";
  String opID = "";
  bool foiClicado = false;
  String idCont = "";
  double margemW = 0.0;
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
  CardDetailRepository cardDetailRepository = CardDetailRepository();
  AprovarReprovarRepository aprovarReprovarRepository =
      AprovarReprovarRepository();
  List<CardDetail> cards = [];
  List<CardDetail> foundUsers = [];
  String idAccount = '';
  bool isDeviceConnected = false;
  bool estaExpandido = false;
  String nomeSistema = '';
  String sistemaID = '';
  String traco = ' - ';
  List<String> columns = [];
  ListaOperacoesBloc([ListaOperacoesState? initialState])
      : super(ListaOperacoesLoadingState()) {
    on<ListaOperacoesGetConnection>((event, emit) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      nomeSistema = sistemaID =
          sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
      idAccount = sharedPreferences.getString('IdAccount') ?? 'bug idAcount';
      //print('idAacount = $idAccount e sistemaId = $sistemaID');
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      try {
        foundUsers = await cardDetailRepository.getOperationsPerSystem(
            sistemaID, idAccount);
        cards = foundUsers;
        //emit(menuProcessado(listaSistemas));
      } catch (erro) {
        print('Erro lista sistemas $erro');
      }
      emit(verificaConexao(isDeviceConnected, foundUsers));
    });
    on<AbrirExpanded>((event, emit) {
      emit(abreExpanded());
    });
  }

  AbrindoExpandLoadingState abreExpanded() {
    return AbrindoExpandLoadingState();
  }

  ListaOperacoesState verificaConexao(bool v, List<CardDetail> lista) {
    if (v == true) {
      return ListaOperacoesLoadedSucessState(message: lista);
    } else {
      return ListaOperacoesLoadedErrorState(
          message: "Verifique a sua coneção a internet!");
    }
  }

//----------------------- Aprova e Reprovar

  Future<OperationData> buscaDetalhes(String opID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    nomeSistema = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
    //print(opID);
    try {
      detalhes = await aprovarReprovarRepository.getDetalhesOperacao(
          nomeSistema, opID);
      columns = [
        detalhes.grelha.header.coluna1,
        detalhes.grelha.header.coluna2,
        detalhes.grelha.header.coluna3
      ];
    } catch (erro) {
      print('Erro ao buscar detalhes ' + erro.toString());
    }
    return detalhes;
  }

  Future<String> buscaPDF(String opID, String idCont) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    nomeSistema = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
    String ficheiroBase64 = '';
    try {
      ficheiroBase64 =
          await aprovarReprovarRepository.getPDFOperacao(opID, idCont);
    } catch (erro) {
      print('Erro ao buscar detalhes ' + erro.toString());
    }
    return ficheiroBase64;
  }
}
