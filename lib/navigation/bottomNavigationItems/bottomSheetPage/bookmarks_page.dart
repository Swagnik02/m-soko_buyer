import 'package:flutter/material.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  Map<String, String> entries = {};

  void addEntry() {
    int entryNumber = entries.length + 1;
    entries['Entry $entryNumber'] = 'Description $entryNumber';
    setState(() {});
  }

  void removeEntry(String key) {
    entries.remove(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Example'),
      ),
      body: ListView(
        children: entries.keys.map((String key) {
          return ListTile(
            title: Text(key),
            subtitle: Text(entries[key]!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeEntry(key),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addEntry,
        tooltip: 'Add Entry',
        child: Icon(Icons.add),
      ),
    );
  }
}
