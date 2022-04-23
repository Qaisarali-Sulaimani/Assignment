import 'package:assignment/constants.dart';
import 'package:assignment/screens/user_page.dart';
import 'package:assignment/screens/user_view.dart';
import 'package:flutter/material.dart';
import '../user/user_model.dart';
import 'homepage.dart' as home;

class ListUser extends StatelessWidget {
  final List<User> list;
  const ListUser({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListCard(user: list[index], index: index);
      },
    );
  }
}

class ListCard extends StatelessWidget {
  final User user;
  final int index;
  const ListCard({required this.user, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => UserView(user: user),
            ),
          );
        },
        child: Card(
          elevation: 4,
          color: Colors.lightBlue[900],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  "${(index + 1).toString()})",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user.email,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              user: user,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.create,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool success =
                            await onlineWork.deleteUser(user.id.toString());

                        if (success) {
                          await showGenericDialog(
                            context: context,
                            title: "Success",
                            content: "User Deleted Successfully",
                            optionBuilder: () {
                              return {
                                "OK": true,
                              };
                            },
                            buttonColor: kmycolor,
                          );

                          Navigator.pushReplacementNamed(
                            context,
                            home.HomePage.id,
                          );
                        } else {
                          await showErrorDialog(
                            context: context,
                            text: "Oops! Something went wrong!",
                            buttonColor: kmycolor,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
