import 'package:flutter/material.dart';
import 'hive_helper.dart';


class NoteApp extends StatefulWidget {
  NoteApp({super.key});
  @override
  State<NoteApp> createState() => _NoteAppState();
}
class _NoteAppState extends State<NoteApp> {
  final _noteController = TextEditingController();
  void initState() {
    // TODO: implement initState
    HiveHelper.getNote();
    super.initState();
    }

  // List<String> notes = [] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Notes",style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30
        ),),
        actions: [
          Icon(Icons.search,color: Colors.black,),
          SizedBox(width: 10,),
          InkWell(onTap:() {
            // HiveHelper.notes.clear();
            HiveHelper.removeAllNote();
            setState(() {
            });
          },
            child: Icon(Icons.delete_forever,color: Colors.black,),
          ),
          SizedBox(width: 10,),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed:  (){
          _noteController.clear();
          showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("add note"),

                  content:TextFormField(
                    controller: _noteController,
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      if(_noteController.text.isNotEmpty){
                        // notes.add(_noteController.text);
                        HiveHelper.addNote(_noteController.text);
                        Navigator.pop(context);
                        setState(() {
                        });
                      }
                    },
                        child: Text("Add")
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      setState(() {

                      });
                    }, child: Text('cancel'))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body:
      ListView.builder(
          itemCount: HiveHelper.notes.length,
          itemBuilder: (context , index )=>Dismissible(key: UniqueKey(),
          onDismissed:(val)=>
            {
              // HiveHelper.notes.removeAt(index),
              HiveHelper.removeNote(index),
            },
               child:   InkWell(
                 onTap: () => {
                   _noteController.text=HiveHelper.notes.elementAt(index),
                 showDialog(context: context,
                 builder: (BuildContext context){
                    return AlertDialog(
                         title: Text("add note"),
                         content:TextFormField(
                            controller: _noteController,
                         ),
                 actions: [
                           TextButton(onPressed: (){
                             if(_noteController.text.isNotEmpty){
                               // HiveHelper.notes[index]=_noteController.text;
                               HiveHelper.updateNote(index, _noteController.text);
                             Navigator.pop(context);
                             setState(() {
                             });
                             }
                             },
                                child: Text("Edit")
                 ),
                           TextButton(onPressed: (){
                                 Navigator.pop(context);
                                 setState(() {

                                 });
                              },child: Text('cancel'))
                 ],
                 );
                 })
                 },
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: Container(
                     width: double.infinity,
                     height: 100,
                     color: Colors.grey,
                     child: Padding(
                       padding: const EdgeInsets.all(8),
                       child: Text(HiveHelper.notes[index],style: TextStyle(fontSize: 20,),),
                     ),
                   ),),
               ))
        ),
    );

  }
}