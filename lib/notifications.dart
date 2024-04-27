import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void _requestPermissions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Permissions'),
          content: Text('Do you allow this app to send you notifications?'),
          actions: <Widget>[
            TextButton(
              child: Text('Deny'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Allow'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _requestPermissions(context),
          child: Text('Go to Notifications'),
        ),
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Welcome!',
      'body': 'Thanks for joining our service!',
      'icon': Icons.thumb_up,
      'color': Colors.green
    },
    {
      'title': 'New Update',
      'body': 'Version 2.0 has been released. Check it out!',
      'icon': Icons.update,
      'color': Colors.blue
    },
    {
      'title': 'Reminder',
      'body': 'Don\'t forget to check your messages.',
      'icon': Icons.message,
      'color': Colors.orange
    },
    {
      'title': 'Sale!',
      'body': 'Our annual sale starts next week.',
      'icon': Icons.local_offer,
      'color': Colors.red
    },
    {
      'title': 'Maintenance',
      'body':
          'Scheduled maintenance this Sunday at 12 PM. Service will be offline.',
      'icon': Icons.build,
      'color': Colors.grey
    },
    {
      'title': 'Security Alert',
      'body': 'Your account was accessed from a new device.',
      'icon': Icons.security,
      'color': Colors.purple
    },
    {
      'title': 'Subscription',
      'body': 'Your subscription has been renewed for another year. Thank you!',
      'icon': Icons.autorenew,
      'color': Colors.teal
    },
    {
      'title': 'Feature Request',
      'body': 'Your feature request has been approved and is in development!',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber
    },
  ];

  void removeNotification(int index) {
    var removedItem = notifications[index];

    setState(() {
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Notification removed"),
      action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              notifications.insert(index, removedItem);
            });
          }),
      duration: Duration(seconds: 5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("All notifications cleared."),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          )
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text("No notifications", style: TextStyle(fontSize: 24)))
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey[300]),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: notifications[index]['color'],
                    child:
                        Icon(notifications[index]['icon'], color: Colors.white),
                  ),
                  title: Text(notifications[index]['title'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notifications[index]['body']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeNotification(index),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(notifications[index]['title']),
                        content: Text(notifications[index]['body']),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
