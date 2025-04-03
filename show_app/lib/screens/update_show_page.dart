import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:show_app/config/api_config.dart';

class UpdateShowPage extends StatefulWidget {
  final Map<String, dynamic> showData;

  const UpdateShowPage({super.key, required this.showData});

  @override
  _UpdateShowPageState createState() => _UpdateShowPageState();
}

class _UpdateShowPageState extends State<UpdateShowPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.showData['title']);
    descriptionController = TextEditingController(text: widget.showData['description']);
  }

  Future<void> updateShow() async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/shows/${widget.showData['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': titleController.text,
        'description': descriptionController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true); // Signale la mise à jour réussie
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update show")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Show")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateShow, child: const Text("Update Show")),
          ],
        ),
      ),
    );
  }
}
