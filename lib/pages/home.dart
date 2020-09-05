import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands=[
    Band(id: '1',name: 'Mago de Oz',votes: 5),
    Band(id: '2',name: 'Queen',votes: 3),
    Band(id: '3',name: 'Metalica',votes: 4),
    Band(id: '4',name: 'AC/DC',votes: 10),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames',style: TextStyle(color: Colors.black87) ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context,  i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      )
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: ( direction){
            print('direction: $direction');
            print('id   :  ${band.id}');
            //Todo: llamar el borrado en el server
          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Deleted Band', style: TextStyle(color: Colors.white) ),
            )
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2) ),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text('${ band.votes }',style: TextStyle(fontSize: 20)),
            onTap: (){
              print(band.name);
            },
          ),
    );
  }

  addNewBand(){

    final TextEditingController textEditingController= new TextEditingController();
    if(Platform.isAndroid){
      //Android
      showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('New Band name:'),
                content: TextField(
                  controller: textEditingController,
                ),
                actions: <Widget>[
                  MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    color: Colors.blue,
                    onPressed: () => addBandToList(textEditingController.text)
                    )
                ],
              );
            }
          );
    }

  showCupertinoDialog(
    context: null,
     builder: ( _ ){
       return CupertinoAlertDialog(
         title: Text('New Band Name'),
         content: CupertinoTextField(
           controller: textEditingController,
         ),
         actions: <Widget>[
           CupertinoDialogAction(
             child: Text('Add'),
              onPressed: () => addBandToList(textEditingController.text)
             ),
             CupertinoDialogAction(
             isDestructiveAction: true,
             child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
              ),
         ],
       );
     }
     );     
  }

void addBandToList(String name){
  print(name);
  
  if (name.length > 1) {
    //podemos agregar
    this.bands.add(new Band(id: DateTime.now().toString(),name: name,votes:0))  ; 
  setState(() { });
  } 
  
  
  Navigator.pop(context);


}

}