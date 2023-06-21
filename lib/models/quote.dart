import 'package:hive/hive.dart';

part 'quote.g.dart';

@HiveType(typeId: 0)
class Quote extends HiveObject {
  @HiveField(0)
  late String author;
  @HiveField(1)
  late String quote;
  @HiveField(2)
  late String category;

  Quote(
    this.author,
    this.quote,
    this.category,
  );
}
