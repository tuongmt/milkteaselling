import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/routes.dart';
import 'package:flutter_coffee_app/config/theme.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/product_model.dart';
import 'package:flutter_coffee_app/screen/cart/cart_detail.dart';
import 'package:flutter_coffee_app/screen/home.dart';
import 'package:flutter_coffee_app/screen/login/login.dart';
import 'package:flutter_coffee_app/screen/menu/menu_screen.dart';
import 'package:flutter_coffee_app/screen/order.dart';
import 'package:flutter_coffee_app/screen/setting.dart';
import 'package:flutter_coffee_app/screen/test/log_in_test.dart';
import 'package:flutter_coffee_app/screen/test/sign_up_test.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
    child: const MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const Login());
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, this.selectedIndex = 0});
  final int selectedIndex;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final ApiService apiService = ApiService();
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          onPressed: () {
            Routes.push(
                widget: CartDetail(selectedVoucher: 1), context: context);
          },
          child: Icon(
            Icons.shopping_bag,
            color: Colors.orange,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: [
            Home(),
            MenuScreen(),
            Order(),
            Setting(),
          ][selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.house),
              icon: Icon(Icons.house_outlined),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.coffee),
                icon: Icon(Icons.coffee_outlined),
                label: 'Sản phẩm'),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.description),
                icon: Icon(Icons.description_outlined),
                label: 'Ưu đãi'),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: 'Cài đặt'),
          ],
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.orange[600],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
