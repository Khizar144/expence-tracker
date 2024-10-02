import 'package:expencetracker/constants/app_colors.dart';
import 'package:expencetracker/controller/transection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddExpence extends StatefulWidget {
  const AddExpence({super.key});

  @override
  State<AddExpence> createState() => _AddExpenceState();
}

class _AddExpenceState extends State<AddExpence> {
  String? _selectedCategory;
  String? _selectedType; 
  DateTime? _selectedDate; 
  final TransectionController _controller = Get.put(TransectionController());
  final TextEditingController _amountController = TextEditingController();

  // Define Income and expense types
  final Map<String, List<String>> _categoryTypes = {
    'Income': ['Business', 'Salary', 'Rent', 'Investments',  'Side Hustles'],
    'Expense': ['Groceries', 'Transportation', 'Utilities', 'Housing', 'Healthcare', 'Entertainment', 'Clothing', 'Education'],
  };

  // Date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      
 
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Save transaction
 // Save transaction
void _saveTransaction() async {
  if (_selectedCategory != null && _selectedType != null && _selectedDate != null) {
    double amount = double.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      Get.snackbar(
        "Error",
        "Amount must be greater than zero",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Call the addTransaction method in the controller
    _controller.addTransaction(_selectedCategory!, _selectedType!, amount, _selectedDate!);
Get.back();
    // Clear inputs after saving
    _amountController.clear();
    setState(() {
      _selectedCategory = null;
      _selectedType = null;
      _selectedDate = null;
    });

    // Show success message
    Get.snackbar(
      "Message",
      "Data added successfully",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  } else {
    // Handle error for missing fields
    Get.snackbar(
      "Error",
      "Please fill in all fields",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

  @override
  void dispose() {
    _amountController.dispose(); // Dispose of the controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.08),
              const Center(
                child: Text(
                  "Add Expense",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Get.height * 0.08),

              // Amount TextField
              Card(
                color: Colors.white.withOpacity(.1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: Get.width * 0.8,
                  height: Get.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: _amountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      LengthLimitingTextInputFormatter(5), // Restrict to 5 digits
                    ],
                    style: const TextStyle(color: AppColors.textColor, fontSize: 45, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    showCursor: false,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: AppColors.textColor, fontSize: 45, fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.06),

              // Dropdown for Category
              Card(
                color: Colors.white.withOpacity(.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    hint: const Text(
                      "Select Category",
                      style: TextStyle(color: AppColors.textColor),
                    ),
                    dropdownColor: Colors.black.withOpacity(.7),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                        _selectedType = null; // Reset selected type when category changes
                      });
                    },
                    items: <String>['Income', 'Expense']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: AppColors.textColor),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(color: AppColors.textColor, fontSize: 20),
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textColor,
                      size: 30,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Get.height * 0.05),

              // Dropdown for Type (show based on selected category)
              Card(
                color: Colors.white.withOpacity(0.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedType,
                    hint: const Text(
                      "Select Type",
                      style: TextStyle(color: AppColors.textColor),
                    ),
                    dropdownColor: Colors.black.withOpacity(.7),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                    items: _selectedCategory != null
                        ? _categoryTypes[_selectedCategory]!.map<DropdownMenuItem<String>>((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type, style: const TextStyle(color: AppColors.textColor)),
                            );
                          }).toList()
                        : [],
                    style: const TextStyle(color: AppColors.textColor, fontSize: 20),
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textColor,
                      size: 30,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Get.height * 0.05),

              // Date Picker TextField
              Card(
                color: Colors.white.withOpacity(0.1),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: Get.width * 0.9,
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            style: const TextStyle(color: AppColors.textColor, fontSize: 20),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.textColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: Get.height * 0.11),

              // Save button
              InkWell(
                onTap: _saveTransaction,
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFC466B),
                        Color(0xFF3F5EFB),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
