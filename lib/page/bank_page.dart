import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grip_banking/page/transfer_history.dart';
import 'package:grip_banking/page/transfer_page.dart';
import 'package:grip_banking/page/users_page.dart';
import 'package:grip_banking/page/user_details_page.dart';
import 'package:grip_banking/db/banking_database.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const bankingapphome(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/userPage': (context) => const userPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/userDetails': (context) =>  userDetails(this.user),
        // '/transferPage': (context) => const transferPage(),
        // '/transferHistory': (context) => const transferHistory(),
      },
    ),
  );
}

class bankingapphome extends StatefulWidget {


  const bankingapphome({Key key}) : super(key: key);

  @override
  _bankingapphomeState createState() => _bankingapphomeState();
}

class _bankingapphomeState extends State<bankingapphome> {
  BankDatabase bankdatabase = BankDatabase();

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Banking App',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 150.0,
                    child: Icon(
                      Icons.account_balance_sharp,
                      size: 200.0,
                      color: Colors.black38,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Welcome,',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Admin!',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    style: TextStyle(fontSize: 50),
                  ),
                  Padding(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => userPage(),
                          ),

                        );

                      },
                      child: Text("View Users"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: EdgeInsets.all(20.0),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
