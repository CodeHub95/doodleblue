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
    double cardHeight = MediaQuery
        .of(context)
        .size
        .height * 0.25;
    double cardWidth = MediaQuery
        .of(context)
        .size
        .width * 0.9;
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          backgroundColor: AppColors.appBarColor,
          elevation: 0,
          actions: [

            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, size: 30),
                  onPressed: () {
                    // Implement cart functionality
                  },
                ),
                Positioned(
                  right: 5,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text(
                      '0', // Replace '3' with the actual number of items
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade200, Colors.green.shade400],
          ),
        ),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade200,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade200,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade200,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade200,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade200,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
            // Navigate to Home screen
              break;
            case 1:
            // Navigate to Categories screen
              break;
            case 2:
            // Navigate to Cart screen
              break;
            case 3:
            // Navigate to Profile screen
              break;
          }
        },
      ),
    );
  }
}