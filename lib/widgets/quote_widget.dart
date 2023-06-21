import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuoteWidget extends StatelessWidget {
  var quote;
  var author;

  var onShareClick;
  // var onCopyClick;

  QuoteWidget({
    this.quote,
    this.author,
    this.onShareClick,
    // this.onCopyClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/900/1000"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(
            top: 100,
            bottom: 100,
          ),
          child: Column(
            children: [
              Spacer(),
              Text(
                '"${quote}"',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "~${author}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: onShareClick,
                    //   child: Container(
                    //     margin: EdgeInsets.only(right: 10),
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(
                    //         width: 1,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.all(10),
                    //     child: Icon(
                    //       Icons.share,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: quote));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.copy,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
