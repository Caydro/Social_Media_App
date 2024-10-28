import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/stories/stories_state.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TextStoryPage extends StatefulWidget {
  const TextStoryPage({super.key});

  @override
  State<TextStoryPage> createState() => _TextStoryPageState();
}

Color pickerColor = const Color(0xff443a49);

TextEditingController storyTextController = TextEditingController();
bool typing = false;
String pickedColorString = "0xff86A3F5";
int? user_id;

@override
class _TextStoryPageState extends State<TextStoryPage> {
  getUserID() async {
    int userID = await SharedPrefrencesOptions().showUserID();
    print(userID);
    user_id = userID;
  }

  void initState() {
    getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: pickerColor,
      body: SafeArea(
        child: BlocListener<StoriesCubit, StoriesState>(
          listener: (context, state) {
            if (state is AddTextStoriesStateSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    userID: user_id,
                  ),
                ),
              );
            } else if (state is AddTextStoriesStateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage!),
                ),
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xff86A3F5),
                      pickColorFunction: () {
                        setState(() {
                          pickerColor = const Color(0xff86A3F5);
                          pickedColorString = "0xff86A3F5";
                        });
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xff745086),
                      pickColorFunction: () {
                        pickerColor = const Color(0xff745086);
                        pickedColorString = "0xff745086";
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xff8BC349),
                      pickColorFunction: () {
                        pickerColor = const Color(0xff8BC349);
                        pickedColorString = "0xff8BC349";

                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xff9E9E9E),
                      pickColorFunction: () {
                        pickerColor = const Color(0xff9E9E9E);
                        pickedColorString = "0xff9E9E9E";
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xffDBB545),
                      pickColorFunction: () {
                        pickerColor = const Color(0xffDBB545);
                        pickedColorString = "0xffDBB545";
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xffE57373),
                      pickColorFunction: () {
                        pickerColor = const Color(0xffE57373);
                        pickedColorString = "0xffE57373";
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    pickColorSquare(
                      width: width,
                      height: height,
                      squareColor: const Color(0xff3F51B6),
                      pickColorFunction: () {
                        pickerColor = const Color(0xff3F51B6);
                        pickedColorString = "0xff3F51B6";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        typing = false;
                        setState(() {});
                      } else {
                        print(pickedColorString);
                        typing = true;
                        setState(() {});
                      }
                    },
                    keyboardType: TextInputType.name,
                    controller: storyTextController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    maxLines: null, // Allows the text field to grow as needed
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Start typing...",
                      fillColor: pickerColor,
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
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
      floatingActionButton: typing == true
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                BlocProvider.of<StoriesCubit>(context).addTextStoriesFunction(
                  userID: user_id!,
                  storyTextContent: storyTextController.text,
                  backgroundColor: pickedColorString,
                );
                storyTextController.clear();
              },
              child: const Text(
                "Share",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: CaydroColors.mainColor,
                ),
              ),
            )
          : null,
    );
  }
}

Widget pickColorSquare({
  required double width,
  required double height,
  required Function pickColorFunction,
  required Color squareColor,
}) {
  return InkWell(
    onTap: () {
      pickColorFunction.call();
    },
    child: Container(
      width: width * 0.1, // Width of the square
      height: height * 0.06, // Height of the square
      decoration: BoxDecoration(
        color: squareColor, // Background color of the square
        borderRadius: BorderRadius.circular(8), // Optional: rounded corners
      ),
    ),
  );
}
