import 'package:Leader/models/label.dart';
import 'package:Leader/screens/leads_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LeadTile extends StatelessWidget {
  final String id;
  final String name;
  final List<Label> labels;
  LeadTile({this.labels, this.id, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(id),
      decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
            offset: const Offset(4.0, 8.0),
            blurRadius: 14.0,
            spreadRadius: -15.0,
            color: Colors.grey[800]),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
            bottomLeft: const Radius.circular(30),
            topLeft: const Radius.circular(30),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: () => pushNewScreen(
              context,
              screen: LeadProfileScreen(id),
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
              withNavBar: false,
            ),
            leading: Container(
              width: 60,
              height: 55.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange[300],
              ),
              child: const Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 40,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (labels != null)
                  Container(
                    width: 200,
                    height: 25,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: labels.length,
                        itemBuilder: (ctx, i) => labels
                            .map(
                              (e) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Center(
                                        child: Text(
                                      e.labelName,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  color: e.color),
                            )
                            .toList()[i]),
                  ),
              ],
            ),
            tileColor: Colors.white,
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).accentColor,
              ),
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}
