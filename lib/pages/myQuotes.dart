import 'package:flutter/material.dart';
import 'package:quotes_app/pages/addQuotes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotes_app/services/database_service.dart';
import 'package:quotes_app/models/quote.dart';

class MyQuotes extends StatefulWidget {
  const MyQuotes({
    super.key,
  });

  @override
  State<MyQuotes> createState() => _MyQuotesState();
}

class _MyQuotesState extends State<MyQuotes> {
  final DatabaseService dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddQuotes();
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(DatabaseService.boxName).listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text("Tidak ada Quote"),
            );
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  Quote tempQuote = box.getAt(index);
                  return Dismissible(
                    key: Key(tempQuote.key.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.black87,
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 30,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                    ),
                    onDismissed: (direction) {
                      dbService.deleteQuote(tempQuote).then((_) {
                        if (direction == DismissDirection.endToStart) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Quote Telah dihapus"),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      });
                    },
                    confirmDismiss: (direction) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                  "Apakah anda yakin akan menghapus quote?"),
                              title: Text('Confirm'),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // Background color
                                  ),
                                  // style: ButtonStyle(backgroundColor:),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text(
                                    "Ya",
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black87, // Background color
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text(
                                    "Tidak",
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: QuoteCard(
                      quote: tempQuote,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: box.length);
          }
        },
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.quote,
  });

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddQuotes(
                    quote: quote,
                  )));
        },
        title: Text(
          '"${quote.quote}"',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          '~${quote.author}',
          textAlign: TextAlign.end,
        ),
        // trailing: Text(quote.author),
      ),
    );
  }
}
