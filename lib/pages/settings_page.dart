import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<ListTile> options = getOptions();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => options[index],
          separatorBuilder: (context, index) => const Divider(),
          itemCount: options.length,
        ));
  }

  List<ListTile> getOptions() {
    final List<ListTile> options = List.empty(growable: true);

    ListTile changePassword = const ListTile(
      title: Text('Change Password'),
    );

    ListTile logout = const ListTile(
      title: Text('Logout'),
      textColor: Colors.white,
      tileColor: Colors.red,
    );

    options.add(changePassword);
    options.add(logout);
    return options;
  }
}
