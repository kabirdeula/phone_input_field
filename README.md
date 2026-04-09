# International Phone Input Package

A Flutter package for international phone number input with country selection.

## Package Structure

```
phone_input_demo/
├── packages/
│   └── international_phone_input/          # Local package
│       ├── lib/
│       │   ├── src/
│       │   │   ├── models/
│       │   │   │   └── country_model.dart
│       │   │   ├── widgets/
│       │   │   │   └── international_phone_input_field.dart
│       │   │   ├── dialogs/
│       │   │   │   └── country_picker_dialog.dart
│       │   │   └── data/
│       │   │       └── countries_data.dart
│       │   └── international_phone_input.dart
│       └── pubspec.yaml
├── lib/
│   └── main.dart                           # Demo app
└── pubspec.yaml
```

## Usage

In your `pubspec.yaml`:

```yaml
dependencies:
  international_phone_input:
    path: packages/international_phone_input
```

Then import and use:

```dart
import 'package:international_phone_input/international_phone_input.dart';

InternationalPhoneInputField(
  controller: phoneController,
  hintText: 'Phone number',
  onChanged: (value) {
    // Handle phone number change
  },
  onCountryChanged: (country) {
    // Handle country change
  },
)
```

## Features

- ✅ Country selection dialog with search
- ✅ Phone number input field
- ✅ Clear button (suffix icon)
- ✅ Custom prefix icon support
- ✅ Country change callback
- ✅ Phone number change callback

## Parameters

- `controller` - Optional TextEditingController
- `hintText` - Placeholder text
- `prefixIcon` - Custom prefix icon widget (defaults to phone icon)
- `onChanged` - Callback when phone number changes
- `onCountryChanged` - Callback when country changes
- `decoration` - Custom input decoration
- `keyboardType` - Keyboard type (defaults to phone)
- `initialCountry` - Initial selected country

## Running the Demo

```bash
cd phone_input_demo
flutter pub get
flutter run
```

## Next Steps

- Add phone number validation
- Add more countries to the list
- Add formatting utilities
- Add phone number masking
- Cache selected country preference