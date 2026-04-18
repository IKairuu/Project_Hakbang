import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/functions/school_save.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class CollegeDescription extends StatefulWidget {
  const CollegeDescription({super.key, required this.college});
  final College college;

  @override
  State<CollegeDescription> createState() => _CollegeDescriptionState();
}

class _CollegeDescriptionState extends State<CollegeDescription> {
  final ScrollController tagScroll = ScrollController();
  final ScrollController programScroll = ScrollController();
  final ScrollController fullScroll = ScrollController();
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          gradientFractionOnEnd: 0.2,
          gradientFractionOnStart: 0.2,
          child: SingleChildScrollView(
            controller: fullScroll,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
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
                                  border: BoxBorder.all(
                                    color: Color(0xFF577eda),
                                  ),
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
                    child: ValueListenableBuilder(
                      valueListenable: savedSchools,
                      builder: (context, saved, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonDesign.mainButton,
                            onPressed: () {
                              setState(() {
                                if (saved.contains(widget.college)) {
                                  SchoolSave.removeSchool(widget.college);
                                } else {
                                  SchoolSave.saveSchool(widget.college);
                                }
                                ActivityFunctions.addUserActivity(
                                  DateFormat(
                                    "MMM dd, yyyy",
                                  ).format(DateTime.now()),
                                  "School Saved: ${widget.college.collegeName}",
                                  "assets/university.svg",
                                );
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  saved.contains(widget.college)
                                      ? "Saved"
                                      : "Save",
                                  style: GoogleFonts.dmSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  saved.contains(widget.college)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                  SizedBox(
                    height: 50,
                    child: FadingEdgeScrollView.fromScrollView(
                      gradientFractionOnEnd: 0.2,
                      gradientFractionOnStart: 0.2,
                      child: ListView.builder(
                        controller: tagScroll,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFC8FF4D),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "#${widget.college.tags[index]}",
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.college.tags.length,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xFF7d7e86), thickness: 0.5),
                  Text(
                    "PROGRAMS OFFERED",
                    style: GoogleFonts.dmSans(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: Color(0xFF505157),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: FadingEdgeScrollView.fromScrollView(
                      gradientFractionOnEnd: 0.2,
                      gradientFractionOnStart: 0.2,
                      child: ListView.builder(
                        controller: programScroll,
                        itemCount: widget.college.programs.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF1d1d2a),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              widget.college.programs[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Color(0xFF7d7e86), thickness: 0.5),
                  Text(
                    "CONTACT",
                    style: GoogleFonts.dmSans(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: Color(0xFF505157),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF1d1d2a),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF243335),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.phone_enabled_rounded,
                                color: Color(0xFF85f5c7),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TELEPHONE",
                                style: GoogleFonts.dmSans(
                                  letterSpacing: 1,
                                  fontSize: 15,
                                  color: Color(0xFF505157),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                widget.college.telephone,
                                style: GoogleFonts.dmSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF1d1d2a),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF243335),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                "https://images.icon-icons.com/1826/PNG/512/4202011emailgmaillogomailsocialsocialmedia-115677_115624.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "EMAIL",
                                style: GoogleFonts.dmSans(
                                  letterSpacing: 1,
                                  fontSize: 15,
                                  color: Color(0xFF505157),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                widget.college.email,
                                style: GoogleFonts.dmSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF1d1d2a),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF243335),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: Image.network(
                                  "https://img.freepik.com/premium-vector/blue-social-media-logo_197792-1759.jpg?semt=ais_hybrid&w=740&q=80",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FACEBOOK",
                                  style: GoogleFonts.dmSans(
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    color: Color(0xFF505157),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  widget.college.fbPage,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Color(0xFF7d7e86), thickness: 0.5),
                  Text(
                    "LOCATION",
                    style: GoogleFonts.dmSans(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: Color(0xFF505157),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              widget.college.latitude,
                              widget.college.longitude,
                            ), // Center the map over London, UK
                            initialZoom: 7,
                            maxZoom: 7,
                            minZoom: 6,
                          ),
                          children: [
                            TileLayer(
                              // Bring your own tiles
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: "com.example.hakbang",
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  rotate: true,
                                  point: LatLng(
                                    widget.college.latitude,
                                    widget.college.longitude,
                                  ),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
