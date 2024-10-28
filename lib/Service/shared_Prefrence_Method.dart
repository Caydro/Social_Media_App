import "package:shared_preferences/shared_preferences.dart";

class SharedPrefrencesOptions {
  showUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt("userID");
    print("userID ==============================               ${userid}");
    return userid;
  }

  addUserDataToSharedPrefMethod(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data.forEach((key, value) {
      // Store based on the value's type
      if (value is String) {
        prefs.setString(key, value);
        print(key);
        print(value);
      } else if (value is int) {
        prefs.setInt(key, value);
        print(key);
        print(value);
      } else if (value is double) {
        prefs.setDouble(key, value);
        print(key);
        print(value);
      } else if (value is bool) {
        prefs.setBool(key, value);
        print(key);
        print(value);
      } else if (value is List<String>) {
        prefs.setStringList(key, value);
        print(key);
        print(value);
      } else {
        // If the value is of an unsupported type, you might need to serialize it to a string
        prefs.setString(key, value.toString());
        print(key);
        print(value);
      }
    });
  }
}
