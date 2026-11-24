import 'package:get/get.dart';
import 'package:my_app/models/explore_tutor_model.dart';

class ExploreController extends GetxController {
  final categories = ['All', 'Flutter', 'Math', 'Physics', 'English'];

  // Observable values: the UI rebuilds when these change
  final selectedCategory = 'All'.obs;
  final searchText = ''.obs;
  final favorites = <String>[].obs;

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

  List<ExploreTutorModel> get filteredTutors {
    final query = searchText.value.trim().toLowerCase();
    return tutors.where((t) {
      final matchesCategory =
          selectedCategory.value == 'All' || t.category == selectedCategory.value;
      final matchesSearch = query.isEmpty ||
          t.name.toLowerCase().contains(query) ||
          t.subject.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}