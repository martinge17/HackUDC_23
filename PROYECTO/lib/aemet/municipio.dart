//import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


Future<String?> getCityCode(String name) async {

  // Open the database
  Database db = await openDatabase('proyecto/resources/municipios.db');

  // Run the query
  final List<Map<String, dynamic>> result = await db.rawQuery(
    'SELECT code FROM my_table WHERE LOWER(name) LIKE LOWER(?) LIMIT 1',
    ['%$name%'],
  );

  // Close the database
  await db.close();

  // Return the result
  if (result.isEmpty) {
    return null;
  } else {
    return result.first['code'] as String?;
  }
  
}