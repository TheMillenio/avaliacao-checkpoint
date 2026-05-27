import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/screens/login_screen.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    this.showBackButton = false,
  });

  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 28),
              onPressed: () => Navigator.pop(context),
            )
          : const Icon(Icons.menu, size: 40),
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, size: 40),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 4),
        ListenableBuilder(
          listenable: CartService.instance,
          builder: (context, _) {
            final count = CartService.instance.itemCount;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 40),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                ),
                if (count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF7B0BF7),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$count',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
