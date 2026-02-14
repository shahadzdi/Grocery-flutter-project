import 'package:flutter/material.dart';
import 'package:grocery/screens/products_list_screen.dart';
import 'package:grocery/screens/shopping_cart.dart';
import 'package:grocery/screens/welcome_screeen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://hzdvsnrhjpcmtjiqrdam.supabase.co",
    anonKey: "sb_publishable_vUUhYRa2A1UJVQ1AO0bBIg_tHY-UOjP",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Welcomescreeen());
  }
}
