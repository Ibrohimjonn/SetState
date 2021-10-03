import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:walley/model/post_model.dart';
import 'package:walley/pages/update_page.dart';
import 'package:walley/services/http_service.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = List();
  bool isLoading = false;

  _apiPostList() async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());

    setState(() {
      if (response != null) {
        items = Network.parsePostList(response);
      }

      isLoading = false;
    });
  }

  _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    setState(() {
      if (response != null) {
        _apiPostList();
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('SetState'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPosts(items[index]);
            },
          ),

          isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, CreatePage.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPosts(Post post) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              post.title.toUpperCase(),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5,),

            // Body
            Text(post.body),
          ],
        ),
      ),
      actions: [
        IconSlideAction(
          caption: 'Update',
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title, body: post.body)));
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _apiPostDelete(post);
          },
        ),
      ],
    );
  }
}