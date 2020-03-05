import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_bloc_builder/flutter_multi_bloc_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_blocs.dart';

void main() {

  testWidgets('Provide multiple states and update widget on state changes', (WidgetTester tester) async {
    const BOTH_SLEEPING = "Both are slepping.";
    const BOTH_RUNNING = "Both are runing.";
    const DO_DIFFERENT_THINGS = "Person and dog do different things.";

    final dogBloc = DogBloc();
    final personBloc = PersonBloc();

    final multiBlocBuilder = MultiBlocBuilder(
      blocs: [dogBloc, personBloc], 
      builder: (context, states) {
        final dogState = states.get<DogState>();
        final personState = states.get<PersonState>();

        if (dogState is DogStateSleeping && personState is PersonStateSleeping) {
          return Text(BOTH_SLEEPING);
        }

        if (dogState is DogStateRunning && personState is PersonStateRunning) {
          return Text(BOTH_RUNNING);
        }

        return Text(DO_DIFFERENT_THINGS);
      }
    );

    final material = MaterialApp(
      home: multiBlocBuilder,
    );

    await tester.pumpWidget(material);
    
    expect(find.text(BOTH_SLEEPING), findsOneWidget);
    expect(find.text(DO_DIFFERENT_THINGS), findsNothing);
    expect(find.text(BOTH_RUNNING), findsNothing);

    dogBloc.add(DogEventRun());

    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text(DO_DIFFERENT_THINGS), findsOneWidget);
    expect(find.text(BOTH_RUNNING), findsNothing);
    expect(find.text(BOTH_SLEEPING), findsNothing);

    personBloc.add(PersonEventWakeUp());

    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text(DO_DIFFERENT_THINGS), findsOneWidget);
    expect(find.text(BOTH_RUNNING), findsNothing);
    expect(find.text(BOTH_SLEEPING), findsNothing);

    personBloc.add(PersonEventRun());

    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text(BOTH_RUNNING), findsOneWidget);
    expect(find.text(DO_DIFFERENT_THINGS), findsNothing);
    expect(find.text(BOTH_SLEEPING), findsNothing);

    personBloc.add(PersonEventGoToBed());
    dogBloc.add(DogEventGoToBed());

    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text(BOTH_SLEEPING), findsOneWidget);
    expect(find.text(BOTH_RUNNING), findsNothing);
    expect(find.text(DO_DIFFERENT_THINGS), findsNothing);

    dogBloc.close();
    personBloc.close();
  });
}
