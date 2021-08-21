import 'package:flutter/material.dart';
import 'package:grip_banking/page/add_funds.dart';
import 'package:grip_banking/page/transfer_history.dart';
import 'package:grip_banking/page/transfer_page.dart';
import 'package:grip_banking/db/banking_database.dart';
import 'package:grip_banking/db/user_data.dart';

class userDetails extends StatefulWidget {
  final userData user;
  userDetails(this.user);


  @override
  State<StatefulWidget> createState(){
    return _userDetailsState(this.user);
  }
}

class _userDetailsState extends State<userDetails> {
  BankDatabase helper = BankDatabase();
  userData user;
  String name  ;
  String phoneNumber;
  String accountNumber ;
  double accountBalance ;

  _userDetailsState(this.user);

  @override
  Widget build(BuildContext context) {
    name = user.Name;
    phoneNumber = user.Phone;
    accountNumber = user.AccountNumber;
    accountBalance = user.AccountBalance;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "User Details",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.account_circle_rounded,
                size: 200.0,
                color: Colors.black38,
              )),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 20.0, 0.0),
                  child: Icon(Icons.account_circle_outlined, color: Colors.indigoAccent, size: 40.0,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Text.rich(
                    TextSpan(
                      text: '$name',
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 20.0, 0.0),
                  child: Icon(Icons.phone, color: Colors.indigoAccent, size: 40.0,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Text.rich(
                    TextSpan(
                      text: '$phoneNumber',
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 20.0, 0.0),
                  child: Icon(Icons.account_balance_sharp, color: Colors.indigoAccent, size: 40.0,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Text.rich(
                    TextSpan(
                      text: '$accountNumber',
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 20.0, 0.0),
                  child: Icon(Icons.account_balance_wallet_outlined, color: Colors.indigoAccent, size: 40.0,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Text.rich(
                    TextSpan(
                      text: '₹$accountBalance',
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.teal,),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => transferHistory(),
                        ),);
                  },
                  child: Text("Transfer History")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red,),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => transferPage(this.user),
                    ),
                  );
                },
                child: Text("Transfer Funds"),
              ),
            ],
          ),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => addFunds(this.user),
              ),
            );
          }, child: Text("Add Funds"))
        ],
      ),
    ));
  }
}
