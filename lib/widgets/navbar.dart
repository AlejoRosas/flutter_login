import 'package:flutter/material.dart';
import 'package:login/services/shared_service.dart';

class MyNavBar extends StatelessWidget {
  final String correo;
  final String username;
  const MyNavBar({
    super.key,
    required this.correo,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:  Text(username),
            accountEmail:  Text(correo),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.table_chart),
            title: const Text('Table'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/table', (route) => false),
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted_rounded),
            title: const Text('List'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/list', (route) => false),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () => {SharedService.logout(context)},
          ),
        ],
      ),
    );
  }
}
