import 'package:flutter/material.dart';
import 'package:grip_banking/db/banking_database.dart';
import 'package:grip_banking/db/user_data.dart';
import 'package:grip_banking/page/users_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toast/toast.dart';

class transferPage extends StatefulWidget {
  final userData user;
  transferPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return _transferPageState(this.user);
  }
}

class _transferPageState extends State<transferPage> {
  final userData user;
  _transferPageState(this.user);

  double currentBalance;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController addBalanceController = TextEditingController();
  String userName;
  String userAccountNumber;
  BankDatabase bankdatabase = BankDatabase();
  List<userData> userList;
  int count =0;
  @override
  Widget build(BuildContext context) {
    updateUser();
    currentBalance = this.user.AccountBalance;
    userName = this.user.Name;
    userAccountNumber = this.user.AccountNumber;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    "Transfer Funds",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Transfering from $userName\nAccount Number is $userAccountNumber",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Available funds for transfer: $currentBalance",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Transfer To",
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Account Number",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: accountNumberController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
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
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  String accountNumber = accountNumberController.text;
                  double transferAmount = double.parse(addBalanceController.text);

                  int check =0;
                  int usercount=0;
                  for(int i=0;i<count;i++){
                      if (accountNumber == this.userList[i].AccountNumber){
                        check =1;
                        usercount = i;
                      }
                  }

                  if(userAccountNumber == accountNumber){
                    Toast.show("Invalid Account Number!!", context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.TOP,
                        backgroundColor: Colors.red);
                  }

                  else if(check!=1){
                    Toast.show("Entered Account does not exists!!", context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.TOP,
                        backgroundColor: Colors.red);
                  }

                  else if (transferAmount > currentBalance || transferAmount ==0) {
                    Toast.show("Invalid Fund Transfer!!", context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.TOP,
                        backgroundColor: Colors.red);

                  }
                  else {
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
                                Text("To Account Number: $accountNumber"),
                                Text("Transfer Amount: ₹ $transferAmount"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    double bal =this.userList[usercount].AccountBalance;
                                    double newBalance = bal + transferAmount;
                                    double deductedBalance = currentBalance - transferAmount;
                                    await bankdatabase.update( userData(this.userList[usercount].Name, this.userList[usercount].AccountNumber, newBalance,this.userList[usercount].Phone));
                                    await bankdatabase.update( userData(userName, userAccountNumber, deductedBalance));
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => userPage(),
                                      ),

                                    );



                                  },
                                  child: Text("Confirm Transfer!!"),
                                ),
                              ],
                            ),
                          ),
                        );
                      });}
                },
                child: Text("Transfer Now!"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void updateUser() {
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
