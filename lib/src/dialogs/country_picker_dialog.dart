import 'package:flutter/material.dart';
import '../models/country_model.dart';
import '../data/countries_data.dart';

class CountryPickerDialog extends StatefulWidget {
  final Country selectedCountry;
  final ValueChanged<Country> onCountrySelected;

  const CountryPickerDialog({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredCountries = countriesData;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = countriesData;
      } else {
        _filteredCountries = countriesData
            .where(
              (country) =>
                  country.name.toLowerCase().contains(query.toLowerCase()) ||
                  country.dialCode.contains(query) ||
                  country.countryCode.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: double.maxFinite,
        height: 500,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Country',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: _filterCountries,
                decoration: InputDecoration(
                  hintText: 'Search country or code',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            // Countries list
            Expanded(
              child: _filteredCountries.isEmpty
                  ? Center(
                      child: Text(
                        'No countries found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        final isSelected =
                            country.countryCode ==
                            widget.selectedCountry.countryCode;

                        return ListTile(
                          leading: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(country.name),
                          subtitle: Text(country.dialCode),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            widget.onCountrySelected(country);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
