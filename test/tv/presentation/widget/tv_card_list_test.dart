import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/folder_tv/domain/entities/tv.dart';
import 'package:ditonton/folder_tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTv = Tv(
    backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
    firstAirDate: '2022-08-21',
    genreIds: const [10765, 18, 10759],
    id: 94997,
    name: 'House of the Dragon',
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'House of the Dragon',
    overview:
        'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
    popularity: 7222.052,
    posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
    voteAverage: 8.6,
    voteCount: 1564,
  );

  group('Tv card Widget Test', () {
    Widget _makeTestableWidget() {
      return MaterialApp(home: Scaffold(body: TvCard(tTv)));
    }

    testWidgets('Testing if title Tv shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
