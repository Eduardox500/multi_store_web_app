import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_store_web_app/views/side_screens/categories_screen.dart';
import 'package:multi_store_web_app/views/side_screens/dashboard_screen.dart';
import 'package:multi_store_web_app/views/side_screens/orders_screen.dart';
import 'package:multi_store_web_app/views/side_screens/products_screen.dart';
import 'package:multi_store_web_app/views/side_screens/upload_banner_screen.dart';
import 'package:multi_store_web_app/views/side_screens/vendor_screen.dart';
import 'package:multi_store_web_app/views/side_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.screenRoute:
        setState(() {
          _selectedScreen = DashboardScreen();
        });
        break;

      case UploadBannerScreen.screenRoute:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;

      case CategoriesScreen.screenRoute:
        setState(() {
          _selectedScreen = CategoriesScreen();
        });
        break;

      case OrdersScreen.screenRoute:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;

      case ProductsScreen.screenRoute:
        setState(() {
          _selectedScreen = ProductsScreen();
        });
        break;

      case VendorScreen.screenRoute:
        setState(() {
          _selectedScreen = VendorScreen();
        });
        break;

      case WithdrawalScreen.screenRoute:
        setState(() {
          _selectedScreen = WithdrawalScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('MultiStore Admin '),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendor',
            route: VendorScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: WithdrawalScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrdersScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoriesScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: UploadBannerScreen.screenRoute,
            icon: Icons.dashboard,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Made by Eduardo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedScreen,
    );
  }
}
