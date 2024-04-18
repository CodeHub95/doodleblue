import 'package:doodleblue/model/business.dart';
import 'package:doodleblue/views/common_widget/business_card.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BusinessDetails extends StatelessWidget {
  Businesses business;

  BusinessDetails({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.4;
    double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.businessDetailsTitle),
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BusinessCard(
              cardHeight: cardHeight,
              cardWidth: cardWidth,
              imageUrl: business.imageUrl!,
              name: business.name ?? '',
              rating: business.rating ?? 0.0,
              reviewCount: business.reviewCount ?? 0,
              displayAddress: business.location?.displayAddress?.join(', ') ?? '',
              businessCategory: business.categories,
              phone: business.phone,
              transaction: business.transactions,
              isClosed: business.isClosed,
              onTap: () {

              },
            ),

          ],
        ),

      ),
    );
  }
}