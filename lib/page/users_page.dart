import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grip_banking/page/user_details_page.dart';
import 'package:grip_banking/db/banking_database.dart';
import 'package:grip_banking/db/user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toast/toast.dart';

class userPage extends StatefulWidget {
  const userPage({Key key}) : super(key: key);

  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  BankDatabase bankdatabase = BankDatabase();
  List<userData> userList;
  TextEditingController searchAccount = TextEditingController();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (userList == null) {
      userList = [];
      updateUserView();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 165.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 8.0, 8.0),
                    child: BackButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 8.0),
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 50.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchAccount,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: "Enter Account No.",
                    labelText: "Search",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        int check = 0;
                        int usercount = 0;

                        for (int i = 0; i < count; i++) {
                          if (searchAccount.text ==
                              this.userList[i].AccountNumber) {
                            check = 1;
                            usercount = i;
                          }
                        }
                        if (check == 0) {
                          Toast.show(
                              "Entered Account does not exists!!", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.TOP,
                              backgroundColor: Colors.red);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "User Exists!!",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("User Name: " +
                                        this.userList[usercount].Name),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => userDetails(
                                                  this.userList[usercount]),
                                            ),
                                          );
                                        },
                                        child: Text("More Details!"))
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      tooltip: 'Search User',
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child: getCardList(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
            ),
            backgroundColor: Colors.teal,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Text("Feature not Available for this version of App"),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  ListView getCardList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          Color val = Colors.grey;
          if (int.parse(this.userList[position].AccountNumber) % 2 == 0) {
            val = Colors.lightBlueAccent;
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Card(
              color: val,
              child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.account_circle_rounded,
                        size: 60.0, color: Colors.white),
                  ),
                  title: Text("Name: " + this.userList[position].Name),
                  subtitle: Text("Account Number: " +
                      this.userList[position].AccountNumber),
                  trailing: Text("Balance: ₹" +
                      (this.userList[position].AccountBalance).toString()),
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            userDetails(this.userList[position]),
                      ),
                    );
                    List<Map<String, dynamic>> users =
                        await bankdatabase.getUserMapList();
                  }),
            ),
          );
        });
  }

  void updateUserView() {
    final Future<Database> dbFuture = bankdatabase.initializeDatabase();
    dbFuture.then((database) {
      Future<List<userData>> userListFuture = bankdatabase.getUserList();
      userListFuture.then((userList) {
        setState(() {
          this.userList = userList;
          this.count = userList.length;
        });
      });
    });
  }
}
