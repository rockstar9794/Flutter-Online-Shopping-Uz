import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';
import '../providers/auth.dart';
import '../helpers/custom_route.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black54,
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://png.pngitem.com/pimgs/s/24-248235_user-profile-avatar-login-account-fa-user-circle.png'),
                    radius: 50.0,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight + Alignment(0, .4),
                  child: Text(
                    'rockstar9794@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          // AppBar(
          //   title: Text('Hello'),
          //   automaticallyImplyLeading: false,
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrdersScreen(),
              //   ),
              // );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserPruductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context)
              //     .pushReplacementNamed(UserPruductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              final provider =
                  Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(value);
            },
            activeThumbImage: themeProvider.isDarkMode
                ? NetworkImage(
                    'https://toppng.com/uploads/preview/check-mark-png-115531994956fibkyfxwb.png')
                : null,
          ),
        ],
      ),
    );
  }
}
