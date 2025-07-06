import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[100],
                child: Icon(Icons.warning, color: Colors.red[500]),
              ),
              title: Text('Road Issues on Kandy Road'),
              subtitle: Text('Heavy traffic due to road maintenance'),
              trailing: Text('10 mins ago'),
            ),
          ),
        ],
      ),
    );
  }
}
