import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'document_list_screen.dart';

const colors = [
  Color.fromRGBO(60, 80, 255, 1),
  Color.fromRGBO(247, 168, 74, 1),
  Color.fromRGBO(80, 74, 199, 1),
  Color.fromRGBO(53, 201, 167, 1)
];

const icons = ['assets/images/folders.png', 'assets/images/folder-exc.png', 'assets/images/file.png', 'assets/images/folder-share.png'];

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  late List<String> labels;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    labels = [
      context.tr('chancellery'),
      context.tr('incoming'),
      context.tr('control'),
      context.tr('outgoing'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('document'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: 4,
              semanticChildCount: 4,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
                decelerationRate: ScrollDecelerationRate.fast,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 110,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentListScreen(
                          typeDocument: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              icons[index],
                              height: 29,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          labels[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
