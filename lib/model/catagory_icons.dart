import 'package:expencetracker/constants/app_images.dart';

class CategoryIcon {
  
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
    'salary': AppImages.salary,
    'Vehicle': AppImages.vehicle,
    'Side Hustles':AppImages.side
  };

 
  static String getIconForCategory(String category) {
    return categoryIcons[category] ?? AppImages.background; // Fallback to background if category not found
  }
}
