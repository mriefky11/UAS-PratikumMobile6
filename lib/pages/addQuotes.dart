import 'package:flutter/material.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/services/database_service.dart';

class AddQuotes extends StatefulWidget {
  const AddQuotes({
    super.key,
    this.quote,
  });

  final Quote? quote;

  @override
  State<AddQuotes> createState() => _AddQuotesState();
}

class _AddQuotesState extends State<AddQuotes> {
  final DatabaseService dbServer = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _authorController;
  late TextEditingController _quoteController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    _authorController = TextEditingController();
    _quoteController = TextEditingController();
    _categoryController = TextEditingController();

    if (widget.quote != null) {
      _authorController.text = widget.quote!.author;
      _quoteController.text = widget.quote!.quote;
      _categoryController.text = widget.quote!.category;
    }
    super.initState();
  }

  @override
  void dispose() {
    _authorController.dispose();
    _quoteController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          widget.quote != null ? "Edit Quote" : "Add Quote",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _authorController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Author wajib di isi";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Author',
                    hintText: 'Masukan Author',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _quoteController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Quote wajib di isi";
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quote',
                    hintText: 'Masukan Quote',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    icon: Icon(Icons.format_quote),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Quote tempQuote = Quote(
              _authorController.text,
              _quoteController.text,
              _categoryController.text,
            );
            if (widget.quote != null) {
              await dbServer.editQuote(widget.quote!.key, tempQuote);
            } else {
              await dbServer.addQuote(tempQuote);
            }
            if (!mounted) return;
            Navigator.of(context).pop();
          }
        },
        label: const Text('Simpan'),
        backgroundColor: Colors.black87,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
