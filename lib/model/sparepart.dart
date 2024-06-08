import 'package:hive/hive.dart';

part 'sparepart.g.dart';

@HiveType(typeId: 1)
class Sparepart extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int stock;

  Sparepart({required this.name, required this.stock});
}
