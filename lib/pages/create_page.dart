import 'dart:math';
import 'package:flutter/material.dart';
import 'package:walley/model/post_model.dart';
import 'package:walley/services/http_service.dart';

import 'home_page.dart';

class CreatePage extends StatefulWidget {
  static const String id = 'create_page';

  const CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isLoading = false;
  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostCreate()  async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(title: _titleTextEditingController.text, body: _bodyTextEditingController.text, userId: Random().nextInt(pow(2, 30) - 1));

    var response = await Network.GET(Network.API_CREATE, Network.paramsCreate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Create a new post'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Title
                  Container(
                    height: 75,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: TextField(
                        controller: _titleTextEditingController,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(labelText: 'Title',),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  // Body
                  TextField(
                    controller: _bodyTextEditingController,
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    maxLines: 1,
                    decoration: const InputDecoration(labelText: 'Body', floatingLabelBehavior: FloatingLabelBehavior.always,),
                  ),
                ],
              ),
            ),

            isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: () {
          _apiPostCreate();
        },
        child: const Icon(Icons.file_upload),
      ),
    );
  }
}
