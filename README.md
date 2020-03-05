![pub](https://img.shields.io/badge/pub-0.0.2-blue) ![license](https://img.shields.io/badge/license-MIT-blueviolet)

# flutter_ multi_bloc_builder

A Flutter package that helps implement the [BLoC pattern](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc).
It is best used as an extension with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package which already provides `MultiBlocProvider` and `MultiBlocListener`.

This package is built to work with [bloc](https://pub.dev/packages/bloc).

## MultiBlocBuilder

__MultiBlocBuilder__ is a Flutter widget which requires minimum one `Bloc` and a `builder` function. 
`MultiBlocBuilder` handles building the widget in response to new states.
It is best used in combination with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package.

The `MultiBlocBuilder` requires two parameters. 
* `blocs`: Specify which bloc states the `MultiBlocBuilder` should observe for building the widget
* `builder`: Anonymous function which returnes your custom widget tree that rebuilds on each state change.

### How to use:
```dart
final bloc1 = BlocProvider.of<MyBloc1>(context);
final bloc2 = BlocProvider.of<MyBloc2>(context);
final bloc3 = BlocProvider.of<MyBloc2>(context);

MultiBlocBuilder(
    blocs: [bloc1, bloc2, bloc3],
    builder: (context, states) {
        final state1 = states.get<MyBloc1State>();
        final state2 = states.get<MyBloc2State>();
        final state3 = states.get<MyBloc3State>();
        
        if (state1 is Loading || state2 is Loading || state3 is Loading) {
            return Text("Loading");
        } else {
            return Text("SHow some content");
        }
    }
);
```