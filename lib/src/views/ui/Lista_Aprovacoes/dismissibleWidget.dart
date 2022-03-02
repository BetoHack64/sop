import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;
  
  const DismissibleWidget(
      {required this.item, required this.child, required this.onDismissed});

  @override
  Widget build(BuildContext context) => Slidable(
    
  
      // Specify a key if the Slidable is dismissible.
      key: ValueKey<T>(item),
      
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
                  onPressed: () {},
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
                  onPressed: () {},
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
      child: child);

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
