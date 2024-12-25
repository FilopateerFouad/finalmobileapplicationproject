import 'package:finalproject/newsmodel.dart';
import 'package:finalproject/todaynews.dart';
import 'package:finalproject/widgets/customtext';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  final Todaynews todayNewsRepo;
  const NewsScreen({super.key, required this.todayNewsRepo});
  Future<List<News>> fetchMatches() async {
    return await todayNewsRepo.getTodayNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF0A2647),
        appBar: AppBar(
            backgroundColor: const Color(0XFF144272),
            title: Center(
                child: CustomText(
              text: "Today's News",
              isBold: true,
              fontSize: 30,
              colours: 0xFFFFFFFF,
            ))),
        body: FutureBuilder<List<News>>(
            future: fetchMatches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load news"));
              } else if (snapshot.hasData) {
                final newsList = snapshot.data!;
                return ListView(children: [
                  ...List.generate(newsList.length, (index) {
                    String date = newsList[index].publishDate.toString();
                    DateTime dateTime = DateTime.parse(date);
                    String formattedDateTime =
                        DateFormat('h:mm a').format(dateTime);
                    return Center(
                        child: Card(
                            color: const Color(0xFF205295),
                            margin: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  newsList[index].image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(10)),
                                          child: Image.network(
                                            newsList[index].image!,
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const SizedBox(height: 200),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text:
                                            newsList[index].title ?? 'No Title',
                                        isBold: true,
                                        fontSize: 16,
                                        colours: 0xFFFFFFFF),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: CustomText(
                                      text:
                                          'Published at: $formattedDateTime ',
                                      fontSize: 14,
                                      colours: 0xFFFFFFFF,
                                      isBold: false,
                                    ),
                                  ),
                                ])));
                  })
                ]);
              } else {
                return const Center(child: Text("No news available"));
              }
            }));
  }
}
