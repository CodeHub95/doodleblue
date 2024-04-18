import 'package:doodleblue/viewmodels/business_view_model.dart';
import 'package:doodleblue/views/business_details.dart';
import 'package:doodleblue/views/common_widget/business_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({super.key});

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  late final BusinessViewModel businessViewModel;

  @override
  void initState() {
    super.initState();
    businessViewModel = Provider.of<BusinessViewModel>(context, listen: false);
    fetchBusinesses();
  }

  Future<void> fetchBusinesses() async {
    try {
      await businessViewModel.fetchBusinesses();
      if (kDebugMode) {
        print('Businesses loaded successfully.');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error loading businesses: $error');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.25;
    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<void>(
            future: businessViewModel.fetchBusinesses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                if (kDebugMode) {
                  print("MainScreen: Waiting for data...");
                }
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                if (kDebugMode) {
                  print("MainScreen: Error - ${snapshot.error}");
                }
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (kDebugMode) {
                  print("MainScreen: Data loaded successfully.");
                }
                return ListView.builder(
                  itemCount: businessViewModel.businesses.length,
                  itemBuilder: (context, index) {
                    return BusinessCard(
                      cardHeight: cardHeight,
                      cardWidth: cardWidth,
                      imageUrl: businessViewModel.businesses[index].imageUrl!,
                      name: businessViewModel.businesses[index].name ?? '',
                      rating: businessViewModel.businesses[index].rating ?? 0.0,
                      reviewCount:
                      businessViewModel.businesses[index].reviewCount ?? 0,
                      displayAddress: businessViewModel
                          .businesses[index].location?.displayAddress
                          ?.join(', ') ??
                          '',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                BusinessDetails(
                                  business: businessViewModel.businesses[index],
                                ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}