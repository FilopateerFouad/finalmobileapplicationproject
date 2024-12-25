import 'package:finalproject/tomatches_model.dart';
import 'package:finalproject/utils/logonameleague.dart';
import 'package:finalproject/utils/logonameteams.dart';
import 'package:finalproject/widgets/customtext';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finalproject/matches_repo.dart';

class TodayMatches extends StatelessWidget {
  final TodayMatchesRepo todayMatchesRepo;

  const TodayMatches({super.key, required this.todayMatchesRepo});

  Future<List<NextFixturesModel>> fetchMatches() async {
    var leagues = ['123', '39', '2'];
    List<NextFixturesModel> matchesList = [];
    for (int i = 0; i < leagues.length; i++) {
      matchesList +=
          await todayMatchesRepo.getTodayMatches("last=5&league=${leagues[i]}");
      matchesList +=
          await todayMatchesRepo.getTodayMatches("next=5&league=${leagues[i]}");
    }
    return matchesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A2647),
      appBar: AppBar(
        backgroundColor: const Color(0XFF144272),
        title: Center(
          child: CustomText(
            text: "Matches",
            isBold: true,
            fontSize: 30,
            colours: 0xFFFFFFFF,
          ),
        ),
      ),
      body: FutureBuilder<List<NextFixturesModel>>(
        future: fetchMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load matches"));
          } else if (snapshot.hasData) {
            final matchesList = snapshot.data!;
            return ListView(
              children: [
                ...List.generate(matchesList.length, (index) {
                  String date = matchesList[index].fixture!.date.toString();
                  DateTime dateTime = DateTime.parse(date);
                  String formattedDateTime =
                      DateFormat('h:mm a').format(dateTime);
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(dateTime);
                  return Center(
                    child: Card(
                      color: const Color(0xFF205295),
                      margin: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              logoNameTeams(
                                  logo: matchesList[index]
                                      .teams!
                                      .home!
                                      .logo
                                      .toString(),
                                  name: matchesList[index]
                                      .teams!
                                      .home!
                                      .name
                                      .toString()),
                            ]),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      CustomText(
                                          text:
                                              '${matchesList[index].league!.country.toString()} - ',
                                          isBold: false,
                                          colours: 0xFFFFFFFF,
                                          fontSize: 15),
                                      logoNameLeague(
                                          logo: matchesList[index]
                                              .league!
                                              .logo
                                              .toString(),
                                          name: matchesList[index]
                                              .league!
                                              .name
                                              .toString()),
                                    ],
                                  ),
                                  matchesList[index].fixture!.status?.long ==
                                          "Live"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: 'Live  ',
                                              colours: 0xFFE4003A,
                                              fontSize: 15,
                                              isBold: true,
                                            ),
                                            CustomText(
                                              text:
                                                  "${matchesList[index].fixture!.status!.elapsed.toString()}'",
                                              isBold: false,
                                              colours: 0xFF73EC8B,
                                              fontSize: 15,
                                            ),
                                          ],
                                        )
                                      : matchesList[index]
                                                  .fixture!
                                                  .status
                                                  ?.long ==
                                              'Match Finished'
                                          ? CustomText(
                                              text: 'FT',
                                              colours: 0xFFE4003A,
                                              fontSize: 15,
                                              isBold: true,
                                            )
                                          : CustomText(
                                              text: formattedDate,
                                              isBold: true,
                                              colours: 0xFFE4003A,
                                              fontSize: 16,
                                            ),
                                  matchesList[index].goals!.home == null
                                      ? CustomText(
                                          text: formattedDateTime,
                                          isBold: true,
                                          colours: 0xFFFFFFFF,
                                          fontSize: 20,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text:
                                                  '${matchesList[index].goals!.home.toString()} : ${matchesList[index].goals!.away.toString()}',
                                              isBold: true,
                                              colours: 0xFFFFFFFFF,
                                              fontSize: 20,
                                            ),
                                          ],
                                        )
                                ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              logoNameTeams(
                                  logo: matchesList[index]
                                      .teams!
                                      .away!
                                      .logo
                                      .toString(),
                                  name: matchesList[index]
                                      .teams!
                                      .away!
                                      .name
                                      .toString())
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            );
          } else {
            return const Center(child: Text("No matches available"));
          }
        },
      ),
    );
  }
}
