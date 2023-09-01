import 'package:hive/hive.dart';

class HiveHelper{
  static String nameBox= "noteApp";
  static String nameBoxKey="noteAppKey";
  static List<String> notes = [] ;

  static  var box=Hive.box(nameBox);

  static Future<void> addNote(String text) async {
    notes.add(text);
    await box.put(nameBoxKey , notes);
  }

  static Future<void> getNote()async {
    if (box.isNotEmpty) {
      notes = box.get(nameBoxKey);
    }
    }
    static Future<void> removeNote(int index)async{
        notes.removeAt(index);
        await box.put(nameBoxKey , notes);
    }
  static Future<void> removeAllNote()async{
    notes.clear();
    await box.put(nameBoxKey , notes);
  }
  static Future<void> updateNote(int index,String text) async {
    notes[index]=text;
    await box.put(nameBoxKey , notes);
  }
}
