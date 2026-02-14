import 'package:supabase_flutter/supabase_flutter.dart';

class DataBase {
  final supabase = Supabase.instance.client;

  Future signUp({required String email, required String password}) async {
    // Email and password sign up
    await supabase.auth.signUp(email: email, password: password);
  }

  Future login({required String email, required String password}) async {
    // Email and password login
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future addToCart({required int productId, required double price}) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return;
    }
    // Select data with filters
    final response = await supabase
        .from('cart')
        .select()
        .eq('user_id', userId) // equals filter
        .eq('product_id', productId);

    if (response.isEmpty) {
      await supabase.from('cart').insert({
        'user_id': userId,
        'product_id': productId,
        'price': price,
      });
    } else {
      int quantity = response[0]['quantity'];
      await supabase
          .from('cart')
          .update({'quantity': quantity + 1})
          .eq('id', response[0]['id']);
    }
  }

  Future removeFromCart({required int productId}) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return;
    }

    final response = await supabase
        .from('cart')
        .select()
        .eq('user_id', userId)
        .eq('product_id', productId);
    if (response.isEmpty) {
      return;
    }

    if (response[0]['quantity'] > 1) {
      int quantity = response[0]['quantity'];
      await supabase
          .from('cart')
          .update({'quantity': quantity - 1})
          .eq('id', response[0]['id']);
    } else {
      await supabase.from('cart').delete().eq('id', response[0]['id']);
    }
  }
}
