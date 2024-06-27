import 'package:flutter/material.dart';

// 검색어
String searchText = '';

// 리스트뷰에 표시할 내용
List<String> items = ['게시물 1', '안녕하세요', '꿀강의', '동아리 구해요'];
List<String> itemContents = [
  'Item 1 Contents',
  'Item 2 Contents',
  'Item 3 Contents',
  'Item 4 Contents'
];
// --> from database, await

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
class SearchPostsPractice extends StatefulWidget {
  const SearchPostsPractice({Key? key}) : super(key: key);

  @override
  SearchPostsPracticeState createState() => SearchPostsPracticeState();
}

class SearchPostsPracticeState extends State<SearchPostsPractice> {
  // 리스트뷰 카드 클릭 이벤트 핸들러
  void cardClickEvent(BuildContext context, int index) {
    String content = itemContents[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentPage(content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Example'),
      ),
      body: Column(
        children: <Widget>[
          // 상단 검색바
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: '검색어를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              // items 변수에 저장되어 있는 모든 값 출력
              itemCount: items.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                // 검색 기능, 검색어가 있을 경우
                if (searchText.isNotEmpty &&
                    !items[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return const SizedBox.shrink();
                }
                // 검색어가 없을 경우, 모든 항목 표시
                else {
                  return SizedBox(
                    height: 10,
                    child: ListTile(
                      title: Text(items[index]),
                      onTap: () => cardClickEvent(context, index),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 선택한 항목의 내용을 보여주는 추가 페이지
class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}
