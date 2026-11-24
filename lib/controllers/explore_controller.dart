import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/explore_tutor_model.dart';

class ExploreController extends GetxController {
  final categories = ['All', 'Flutter', 'Math', 'Physics', 'English'];

  final selectedCategory = 'All'.obs;
  final searchText = ''.obs;
  final favorites = <String>[].obs;

  final priceRange = const RangeValues(15, 100).obs;
  final mode = 'All'.obs; 
  final minRating = 3.5.obs;
  final availability = 'This week'.obs; 

  final draftPrice = const RangeValues(15, 100).obs;
  final draftMode = 'All'.obs;
  final draftRating = 3.5.obs;
  final draftAvailability = 'This week'.obs;

  final featuredTutor = const ExploreTutorModel(
    id: 't0',
    name: 'Alex Johnson',
    subject: 'Mathematics',
    category: 'Math',
    image: 'assets/png/alex.png',
    rating: 4.9,
    reviews: 2000,
    price: 35,
  );

  final tutors = const [
    ExploreTutorModel(
      id: 't1',
      name: 'Maya Chen',
      subject: 'Flutter Development',
      category: 'Flutter',
      image: 'assets/png/maya.png',
      rating: 4.9,
      reviews: 128,
      price: 32,
      availableIn: 0,
    ),
    ExploreTutorModel(
      id: 't2',
      name: 'Sarah Williams',
      subject: 'Physics & Science',
      category: 'Physics',
      image: 'assets/png/sarah.png',
      rating: 4.9,
      reviews: 128,
      price: 28,
      availableIn: 1,
    ),
    ExploreTutorModel(
      id: 't3',
      name: 'Daniel Brown',
      subject: 'English Literature',
      category: 'English',
      image: 'assets/png/daniel.png',
      rating: 4.7,
      reviews: 86,
      price: 25,
      isHome: false,
      availableIn: 3,
    ),
  ];

  void selectCategory(String name) => selectedCategory.value = name;

  void setSearch(String text) => searchText.value = text;

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
  }

  void loadDraft() {
    draftPrice.value = priceRange.value;
    draftMode.value = mode.value;
    draftRating.value = minRating.value;
    draftAvailability.value = availability.value;
  }

  void resetDraft() {
    draftPrice.value = const RangeValues(15, 100);
    draftMode.value = 'All';
    draftRating.value = 3.5;
    draftAvailability.value = 'This week';
  }

  void applyFilters() {
    priceRange.value = draftPrice.value;
    mode.value = draftMode.value;
    minRating.value = draftRating.value;
    availability.value = draftAvailability.value;
  }

  
  List<ExploreTutorModel> get filteredTutors {
    return _filter(
      priceRange.value,
      mode.value,
      minRating.value,
      availability.value,
    );
  }

  int get draftCount {
    return _filter(
      draftPrice.value,
      draftMode.value,
      draftRating.value,
      draftAvailability.value,
    ).length;
  }

  List<ExploreTutorModel> _filter(
    RangeValues price,
    String mode,
    double rating,
    String availability,
  ) {
    final query = searchText.value.trim().toLowerCase();

    return tutors.where((t) {
      final okCategory =
          selectedCategory.value == 'All' || t.category == selectedCategory.value;

      final okSearch = query.isEmpty ||
          t.name.toLowerCase().contains(query) ||
          t.subject.toLowerCase().contains(query);

  
      final okPrice =
          t.price >= price.start && (price.end >= 100 || t.price <= price.end);

      final okMode = mode == 'All' ||
          (mode == 'Online' && t.isOnline) ||
          (mode == 'Home' && t.isHome);

      final okRating = t.rating >= rating;

      bool okAvailability = true;
      if (availability == 'Today') okAvailability = t.availableIn == 0;
      if (availability == 'Tomorrow') okAvailability = t.availableIn <= 1;
      if (availability == 'This week') okAvailability = t.availableIn <= 6;

      return okCategory &&
          okSearch &&
          okPrice &&
          okMode &&
          okRating &&
          okAvailability;
    }).toList();
  }
}