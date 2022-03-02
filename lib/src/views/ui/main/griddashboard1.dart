import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/views/ui/main/iconSistema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Silvio mecheste tod
List<Sistema> applicationDetailItems = [];

class GridDashboard extends StatefulWidget {
  GridDashboard({required List<Sistema> items}) {
    applicationDetailItems = items;
  }

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Sistema> myList = applicationDetailItems;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, top: 9, bottom: 2),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Olá, Tobe ",
              style: TextStyle(
                fontFamily: "SEGOEUI",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                //fontFamily: "Open Sans",
              ),
            ),
          ),
        ),
        Flexible(
          child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            crossAxisCount: 2,
            crossAxisSpacing: 35,
            mainAxisSpacing: 28,
            children: myList.map(
              (data) {
                return InkWell(
                  onTap: () => BlocProvider.of<MainBloc>(context)
                      .selecionaSistema(
                          context, data.applicationCod, data.applicationID),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFfb2436),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 0.2,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Text(
                              int.parse(data.numOperations) > 100
                                  ? '+99'
                                  : data.numOperations,
                              style: TextStyle(
                                color: data.numOperations == "0"
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                fontFamily: "SEGOEUI",
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(left: 105, bottom: 2),
                        ),
                        Container(
                          child: IconSistema(
                              imageAnalysed: data.iconBase64,
                              nome: data.applicationCod),
                          margin: EdgeInsets.only(bottom: 0.1),
                        ),
                        Container(
                          child: Text(
                            data.applicationCod,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SEGOEUI",
                              letterSpacing: 1,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 2),
                        ),
                        Text(
                          data.applicationNameShort,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SEGOEUI",
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
