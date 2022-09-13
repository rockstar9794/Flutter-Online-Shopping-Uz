import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/theme_provider.dart';
import './screens/splash_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/auth.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return Consumer<Auth>(
              builder: (ctx, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                themeMode: themeProvider.themeMode,
                darkTheme: MyTheme.darkTheme,
                theme: MyTheme.lightTheme,
                home: auth.isAuth
                    ? ProductOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen(),
                      ),
                routes: {
                  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                  CartScreen.routName: (ctx) => CartScreen(),
                  OrdersScreen.routeName: (ctx) => OrdersScreen(),
                  UserPruductsScreen.routeName: (ctx) => UserPruductsScreen(),
                  EditproductScreen.routename: (ctx) => EditproductScreen(),
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
