import 'package:doodleblue/model/business.dart';
import 'package:doodleblue/utils/constants.dart';
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final String imageUrl;
  final String name;
  final double rating;
  final int reviewCount;
  final String displayAddress;
  final Function() onTap;
  List<Categories>? businessCategory;
  String? phone;
  List<String>? transaction;
  bool? isClosed;

  BusinessCard({
    super.key,
    required this.cardHeight,
    required this.cardWidth,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.displayAddress,
    required this.onTap,
    this.businessCategory,
    this.phone,
    transaction,
    this.isClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: AppColors.cardGradientEnd, // Darker green shade
              width: 2.0, // Adjust border width as needed
            ),
          ),

          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: cardHeight,
                width: cardWidth,
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.cardGradientStart,
                      AppColors.cardGradientEnd
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    tileMode: TileMode.clamp,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // const Icon(Icons.star, color: Colors.yellow),
                            Stack(
                              children: [
                                Icon(Icons.star, color: AppColors.cardGradientEnd), // Outline
                                Icon(Icons.star, color: AppColors.ratingColor, size: 20,), // Inner star
                              ],
                            ),
                            Text('${rating ?? 0.0}'),
                          ],
                        ),
                        Text('$reviewCount reviews', style: TextStyle(color: AppColors.cardGradientEnd),),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Address: $displayAddress'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Category: ${businessCategory?.first.title}'),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Phone Number: ${phone ?? ''}')),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Transaction: ${transaction ?? ''}')),
                    (isClosed ?? false)
                        ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Is Closed: ${'Yes'}"),
                    )
                        : const Text("Is Closed: ${'No'}")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}