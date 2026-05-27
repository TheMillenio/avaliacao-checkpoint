import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/screens/product_detail_screen.dart';
import 'package:usedev_uninassau/src/utils/price_formatter.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              product.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 48),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                PriceFormatter.formatBrl(product.price),
                style: TextStyle(
                  fontSize: 28,
                  color: const Color(0xFF7B0BF7),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
