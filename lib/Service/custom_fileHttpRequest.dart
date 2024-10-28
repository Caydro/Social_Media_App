import 'dart:convert'; // Importing the dart:convert library for JSON encoding and decoding.
import 'dart:io'; // Importing dart:io library to work with files and streams.

import 'package:http/http.dart'
    as http; // Importing the http package for making HTTP requests.
import 'package:path/path.dart'; // Importing the path package to manipulate file paths.

// Defining a class named CaydroCustomPostFile
class CaydroCustomPostFile {
  // Defining an asynchronous method to handle HTTP POST requests that include file uploads
  Future<Map<String, dynamic>> postHttpRequestFileMethod({
    required String url, // The URL to which the POST request will be sent
    required File file, // The file that needs to be uploaded
    required Map data, // Additional data to be sent along with the file
  }) async {
    // Creating a new MultipartRequest, specifying the request type as "POST" and providing the URL
    var request = http.MultipartRequest("POST", Uri.parse(url));

    // Getting the length of the file (in bytes)
    var length = await file.length();

    // Creating a ByteStream from the file's read stream
    var stream = http.ByteStream(file.openRead());

    // Creating a MultipartFile from the ByteStream, file length, and file name
    var multiPartFile = http.MultipartFile(
        "c_image", // The name of the field in the form data
        stream, // The byte stream of the file
        length, // The length of the file in bytes
        filename: basename(file.path) // The name of the file
        );

    // Adding the file to the MultipartRequest
    request.files.add(multiPartFile);

    // Adding the additional data fields to the request
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    // Sending the request and waiting for the response
    var myRequest = await request.send();

    // Converting the response stream into a complete HTTP Response object
    var dataResponse = await http.Response.fromStream(myRequest);

    // Checking if the response status code is 200 (OK)
    if (myRequest.statusCode == 200) {
      // If successful, decode the JSON response body and return it
      return jsonDecode(dataResponse.body);
    } else {
      // If an error occurred, print the error status code
      print("error, ${myRequest.statusCode}");
      return jsonDecode(dataResponse.body);
    }
  }
}
