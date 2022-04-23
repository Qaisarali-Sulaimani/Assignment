import 'package:assignment/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'list_user.dart';
import '../api/online_work.dart';
import '../user/user_model.dart';

OnlineWork onlineWork = OnlineWork();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> list = [];

  Future<void> doWork() async {
    list = await onlineWork.getAllUsers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    doWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.purple[900],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return UserPage();
            }),
          );
        },
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: doWork,
        child: list.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListUser(
                list: list,
              ),
      ),
    );
  }
}
