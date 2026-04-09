import 'package:flutter/material.dart';
import '../models/country_model.dart';
import '../data/countries_data.dart';
import '../dialogs/country_picker_dialog.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final Country? initialCountry;

  const PhoneInputField({
    super.key,
    this.controller,
    this.hintText = "Phone number",
    this.prefixIcon,
    this.onChanged,
    this.onCountryChanged,
    this.decoration,
    this.keyboardType = TextInputType.phone,
    this.initialCountry,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late TextEditingController _controller;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedCountry = widget.initialCountry ?? countriesData.first;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (context) => CountryPickerDialog(
        selectedCountry: _selectedCountry,
        onCountrySelected: (country) {
          setState(() {
            _selectedCountry = country;
          });
          widget.onCountryChanged?.call(country);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _clearPhoneNumber() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Country selector
        GestureDetector(
          onTap: _showCountryPicker,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedCountry.flag,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  _selectedCountry.dialCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Phone number input field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _controller,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                prefixIcon:
                    widget.prefixIcon ??
                    Icon(Icons.phone, color: Colors.grey.shade600),
                suffixIcon: _controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: _clearPhoneNumber,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
