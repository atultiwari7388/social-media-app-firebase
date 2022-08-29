import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/follow_btn.widget.dart';
import 'package:instagram_clone/resources/auth_method.resource.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/login.screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {});
    });
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();

      //getting post length

      var postSnap = await FirebaseFirestore.instance
          .collection("posts")
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;

      userData = userSnap.data()!;
      //followers
      followers = userSnap.data()!["followers"].length;
      //following
      following = userSnap.data()!["following"].length;
      //check following stats

      isFollowing = userSnap
          .data()!["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(
                children: [
                  // name && more options
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 18.0, top: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => print("back"),
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          userData["name"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // profileImage
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white70,
                    child: CachedNetworkImage(
                      imageUrl: userData["profileImage"],
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 55,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Lottie.asset(
                          "assets/loading.json",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "@" + userData["userName"],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildStats(postLength, "Posts"),
                      buildStats(followers, "Followers"),
                      buildStats(following, "Following"),
                    ],
                  ),
                  SizedBox(height: 20),
                  // folllow unfollow button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FirebaseAuth.instance.currentUser!.uid == widget.uid
                          ? FollowButtonWidget(
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey,
                              text: "Sign out",
                              textColor: primaryColor,
                              function: () async {
                                await AuthMethods().signOut();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                            )
                          : isFollowing
                              ? FollowButtonWidget(
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.grey,
                                  text: "Unfollow",
                                  textColor: primaryColor,
                                  function: () async {
                                    await FireStoreMethod().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      userData["uid"],
                                    );
                                    setState(() {
                                      isFollowing = false;
                                      followers--;
                                    });
                                  },
                                )
                              : FollowButtonWidget(
                                  backgroundColor: primaryColor,
                                  borderColor: Colors.blue,
                                  text: "Follow",
                                  textColor: Colors.white,
                                  function: () async {
                                    await FireStoreMethod().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      userData["uid"],
                                    );
                                    setState(
                                      () {
                                        isFollowing = true;
                                        followers++;
                                      },
                                    );
                                  },
                                ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(IconlyLight.message, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // custom Tabbars

                  //default tabs

                  Container(
                    height: 50,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.white,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            "Photos",
                            style: GoogleFonts.lato(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Videos",
                            style: GoogleFonts.lato(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Tagged",
                            style: GoogleFonts.lato(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Container(
                    height: 700,
                    // color: Colors.red,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        //photos
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("posts")
                              .where("uid", isEqualTo: widget.uid)
                              .get(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 0.59,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  return CachedNetworkImage(
                                    imageUrl: data["postUrl"],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: Lottie.asset(
                                          "assets/circle_loading.json",
                                          fit: BoxFit.cover),
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        Text("Not Found"),
                        Text("Not Found"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Column buildStats(int num, String lable) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: GoogleFonts.lato(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            lable,
            style: GoogleFonts.lato(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
