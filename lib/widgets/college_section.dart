import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';

class CollegeSection extends StatefulWidget {
  const CollegeSection({
    super.key,
    required this.college,
    required this.sectionIndex,
  });
  final College college;
  final int sectionIndex;
  @override
  State<CollegeSection> createState() => _CollegeSectionState();
}

class _CollegeSectionState extends State<CollegeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ValueListenableBuilder(
        valueListenable: selectedSchoolHover,
        builder: (context, selected, child) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xFF1c1e27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  side: BorderSide(
                    color: selected[widget.sectionIndex]
                        ? Color(0xFFc6fd4c)
                        : Colors.transparent,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  Initialization.refreshCollegeSelection();
                  selectedSchoolHover.value[widget.sectionIndex] = true;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "📍${widget.college.address}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              color: Color(0xFF818289),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF213536),
                                ),
                                child: Text(
                                  widget.college.tags[0],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    color: Color(0xFF4cf9b4),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF312746),
                              ),
                              child: Text(
                                widget.college.tags[1],
                                style: GoogleFonts.dmSans(
                                  fontSize: 10,
                                  color: Color(0xFFa253ee),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
