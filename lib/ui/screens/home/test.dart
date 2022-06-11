import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../logic/models/user_model.dart';

class TestPage extends StatelessWidget {
  final User user;

  TestPage({required this.user});

  Widget textfield({@required hintText}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Material(
        elevation: 4,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                letterSpacing: 2,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: MySliverDelegate(
            maxHeight: height * 0.32,
            minHeight: height * 0.1,
            user: user,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              textfield(
                hintText: 'Username',
              ),
              textfield(
                hintText: 'Email',
              ),
              textfield(
                hintText: 'Password',
              ),
              textfield(
                hintText: 'Confirm password',
              ),
              textfield(
                hintText: 'Bio',
              ),
              textfield(
                hintText: 'Bio',
              ),
              textfield(
                hintText: 'Bio',
              ),
              textfield(
                hintText: 'Bio',
              ),
              textfield(
                hintText: 'Bio',
              ),
              textfield(
                hintText: 'Bio',
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 55,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  final double one;
  final double two;
  final double three;

  HeaderCurvedContainer({
    required this.one,
    required this.two,
    required this.three,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, one)
      ..quadraticBezierTo(size.width / 2, three, size.width, two)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final User user;

  MySliverDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.user,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    print(progress);
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.lerp(
              Alignment.topCenter,
              Alignment.topCenter,
              progress,
            ),
            child: progress < 0.37
                ? ProfileHeader(
                    user: user,
                    progress: progress,
                  )
                : ProfileHeaderSmall(user: user),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class ProfileHeaderSmall extends StatelessWidget {
  final User user;

  const ProfileHeaderSmall({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Smaller Profile box implementation'),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final User user;
  final double progress;

  const ProfileHeader({
    Key? key,
    required this.user,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: lerpDouble(MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.height / 2, progress),
            ),
            painter: HeaderCurvedContainer(
              one: lerpDouble(110, 60, progress * 2)!,
              two: lerpDouble(150, 100, progress * 2)!,
              three: lerpDouble(225, 125, progress * 2)!,
            ),
          ),
        ),
        Align(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: lerpDouble(0, 50, progress)!),
                  width: lerpDouble(MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.width / 4, progress),
                  height: lerpDouble(MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.width / 4, progress),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(user.photoURL),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        progress < 0.25
            ? Align(
                alignment: Alignment.lerp(
                    Alignment(0.52, 0.75), Alignment(0, 0), progress)!,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
