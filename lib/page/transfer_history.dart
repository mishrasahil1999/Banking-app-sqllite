import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';


class transferHistory extends StatelessWidget {
  const transferHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sentUser="Shyam";
    var amountSent=1000;
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
                  Text("Transfer History", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold ),),
                ],
              ),
              SizedBox( height: 30.0),
              Text("This is not an interactive page not available on this version"),
              SizedBox( height: 30.0),
              TimelineTile(
                alignment: TimelineAlign.start,
                endChild: Card(child: ListTile(
                  title: Text('Sent To: ',style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('$sentUser',style: TextStyle(fontWeight: FontWeight.bold),),
                  trailing: Text('₹$amountSent',style: TextStyle(fontWeight: FontWeight.bold),),
                ),),
                indicatorStyle: IndicatorStyle(
                  width: 35,
                  color: Colors.green,
                  padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.check,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
