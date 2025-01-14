```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      //Handle specific HTTP error codes
      if(response.statusCode == 404){
        throw Exception('Resource not found (404)');
      } else if(response.statusCode == 500){
        throw Exception('Server error (500)');
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } on FormatException catch (e) {
    print('Error: Invalid JSON format: $e');
    return null; // Or handle the error appropriately
  } on SocketException catch (e) {
    print('Error: No internet connection: $e');
    return null; // Or handle the error appropriately
  } catch (e) {
    print('An unexpected error occurred: $e');
    rethrow; // Re-throw for higher-level handling if necessary
  }
}
```