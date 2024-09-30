import 'package:expencetracker/constants/app_images.dart';

class CategoryIcon {
  // Map to link categories with their icons
  static const Map<String, String> categoryIcons = {
    'Business': AppImages.business,
    'Clothing': AppImages.clothing,
    'Education': AppImages.education,
    'Healthcare': AppImages.healthcare,
    'Entertainment': AppImages.Entertainment,
    'Groceries': AppImages.grocery,
    'Home': AppImages.home,
    'Housing': AppImages.housing,
    'Investments': AppImages.invesment,
    'Rent': AppImages.rent,
    'Utilities': AppImages.Utilities,
    'Working': AppImages.working,
    'Transportation': AppImages.vehicle,

    'Vehicle': AppImages.vehicle,
    'Side Hustles':AppImages.side
  };

  // Method to retrieve icon for the selected category
  static String getIconForCategory(String category) {
    return categoryIcons[category] ?? AppImages.background; // Fallback to background if category not found
  }
}
