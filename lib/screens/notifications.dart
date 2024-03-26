import 'package:edmax/screens/side_menu.dart';
import 'package:edmax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final List<String> notifications = [
    'You have been marked absent for SPCC Lecture',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 5,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "EDU VENTURE",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () => Get.to(const Notifications()),
                    )
                  ],
                ),
              ),
              centerTitle: true,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 0,0),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const Divider(indent: 15,endIndent: 15,),
          ],
        ),
      ),
      drawer: SideMenu(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            hoverColor: Colors.white,
            minVerticalPadding: 15,
            textColor: Colors.white,
            iconColor: Colors.green,
            leading: const Icon(Icons.notifications),
            title: Text(notifications[index],),
            onTap: () {
              // Handle notification tap
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: backgroundColor,
                    title: const Text('Notification Details'),
                    content: Text(notifications[index]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
