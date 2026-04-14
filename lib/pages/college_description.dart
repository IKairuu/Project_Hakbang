import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/models/college.dart';

class CollegeDescription extends StatefulWidget {
  const CollegeDescription({super.key, required this.college});
  final College college;

  @override
  State<CollegeDescription> createState() => _CollegeDescriptionState();
}

class _CollegeDescriptionState extends State<CollegeDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC8FF4D),
        elevation: 10,
        shadowColor: Color(0xFFC8FF4D),
      ),
      backgroundColor: Color(0xFF121318),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.college.collegeImage),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF17325a),
                              borderRadius: BorderRadius.circular(30),
                              border: BoxBorder.all(color: Color(0xFF577eda)),
                            ),
                            child: Text(
                              widget.college.type == "private"
                                  ? "Private"
                                  : "Public",
                              style: GoogleFonts.dmSans(
                                color: Color(0xFF718fd7),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text("⭐"),
                                ),
                                Text(
                                  widget.college.rating,
                                  style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            widget.college.logoLink,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.college.collegeName,
                              style: FontStyles.collegeLabel,
                            ),
                            Text(
                              "📍 ${widget.college.address}",
                              style: FontStyles.addressLabel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF1d1d2a),
                      borderRadius: BorderRadius.circular(15),
                      border: BoxBorder.all(color: Color(0xFF7d7e86)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.college.programNumbers,
                                style: GoogleFonts.dmSans(
                                  color: Color(0xFFd9fe84),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "PROGRAMS",
                                style: GoogleFonts.dmSans(
                                  color: Color(0xFF7d7e86),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            width: 5,
                            color: Color(0xFF7d7e86),
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "TOP #${widget.college.ranking}",
                                style: GoogleFonts.dmSans(
                                  color: Color(0xFFa755f6),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "RANKING",
                                style: GoogleFonts.dmSans(
                                  color: Color(0xFF7d7e86),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonDesign.mainButton,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Save",
                            style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.bookmark_border_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(color: Color(0xFF7d7e86), thickness: 0.5),
                Text(
                  "ABOUT",
                  style: GoogleFonts.dmSans(
                    letterSpacing: 3,
                    fontSize: 20,
                    color: Color(0xFF505157),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.college.about,
                    style: FontStyles.appDetails,
                  ),
                ),
                Text(
                  "TAGS",
                  style: GoogleFonts.dmSans(
                    letterSpacing: 3,
                    fontSize: 20,
                    color: Color(0xFF505157),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
