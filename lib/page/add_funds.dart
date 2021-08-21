import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grip_banking/db/banking_database.dart';
import 'package:grip_banking/db/user_data.dart';
import 'package:grip_banking/page/users_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toast/toast.dart';

class addFunds extends StatefulWidget {
  final userData user;
  addFunds(this.user);

  @override
  State<StatefulWidget> createState() {
    return _addFundsState(this.user);
  }
}

class _addFundsState extends State<addFunds> {
  final userData user;
  BankDatabase bankDatabase = BankDatabase();
  _addFundsState(this.user);
  double currentBalance;
  int count = 0;
  TextEditingController addBalanceController = TextEditingController();
  String userName;
  String userAccountNumber;
  List<userData> userList;
  @override
  Widget build(BuildContext context) {
    updateUser();
    userAccountNumber = this.user.AccountNumber;
    currentBalance = this.user.AccountBalance;
    userName = this.user.Name;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Add Funds",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Adding Funds to A/C No.:$userAccountNumber",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              "User Name:$userName",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: addBalanceController,
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: " ₹ ",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                int userCount = 0;
                for (int i = 0; i < count; i++) {
                  if (userAccountNumber == this.userList[i].AccountNumber) {
                    userCount = i;
                  }
                }
                double bal = this.userList[userCount].AccountBalance;
                double transferAmount = double.parse(addBalanceController.text);
                double newBalance = bal + transferAmount;
                if (transferAmount == 0) {
                  Toast.show(
                    "Invalid Amount!",
                    context,
                    backgroundColor: Colors.red,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.TOP,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  "https://www.freeiconspng.com/uploads/emergency-alert-icon-alert-icon-8.png",
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                Text(
                                  "Alert! You are about to initiate a Fund Transfer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.redAccent),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("To Account Number: $userAccountNumber"),
                                Text("Transfer Amount: ₹ $transferAmount"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await bankDatabase.update(userData(
                                        this.userList[userCount].Name,
                                        this.userList[userCount].AccountNumber,
                                        newBalance,
                                        this.userList[userCount].Phone));
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => userPage()));
                                  },
                                  child: Text("Confirm Transfer!"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
              child: Text("Add Fund"),
              style: ElevatedButton.styleFrom(primary: Colors.teal),
            )
          ],
        ),
      ),
    );
  }

//
  void updateUser() {
    final Future<Database> dbFuture = bankDatabase.initializeDatabase();
    dbFuture.then((database) {
      Future<List<userData>> userListFuture = bankDatabase.getUserList();
      userListFuture.then((userList) {
        setState(() {
          this.userList = userList;
          this.count = userList.length;
        });
      });
    });
  }
}
