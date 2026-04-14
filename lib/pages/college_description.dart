import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.college.collegeName,
                    style: FontStyles.collegeLabel,
                  ),
                ),
                Text(
                  "📍 ${widget.college.address}",
                  style: FontStyles.addressLabel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
