# flutter_ multi_bloc_builder

A Flutter package that helps implement the [BLoC pattern](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc).
It is best used as an extension with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package which already provides MultiBlocProvider and MultiBlocListener, but no MultiBlocBuilder. 

This package is built to work with [bloc](https://pub.dev/packages/bloc).

## MultiBlocBuilder

__MultiBlocBuilder__ is a Flutter widget which requires minimum one `Bloc` and a `builder` function. 
`MultiBlocBuilder` handles building the widget in response to new states.
It should be used in combination with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package.

The `MultiBlocBuilder` requires two parameters. Use `blocs` to specify which bloc states it should observe 
and build the widget if any of them change.
Use the [builder] parameter to define a widget tree that is rebuild each time a state change occurs.

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


MultiBlocBuilder handles building the widget in response to new states. BlocBuilder is very similar to StreamBuilder but has a more simple API to reduce the amount of boilerplate code needed. The builder function will potentially be called many times and should be a pure function that returns a widget in response to the state.

See BlocListener if you want to "do" anything in response to state changes such as navigation, showing a dialog, etc...

If the bloc parameter is omitted, BlocBuilder will automatically perform a lookup using BlocProvider and the current BuildContext.

BlocBuilder<BlocA, BlocAState>(
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
Only specify the bloc if you wish to provide a bloc that will be scoped to a single widget and isn't accessible via a parent BlocProvider and the current BuildContext.

BlocBuilder<BlocA, BlocAState>(
  bloc: blocA, // provide the local bloc instance
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
If you want fine-grained control over when the builder function is called you can provide an optional condition to BlocBuilder. The condition takes the previous bloc state and current bloc state and returns a boolean. If condition returns true, builder will be called with state and the widget will rebuild. If condition returns false, builder will not be called with state and no rebuild will occur.

BlocBuilder<BlocA, BlocAState>(
  condition: (previousState, state) {
    // return true/false to determine whether or not
    // to rebuild the widget with state
  },
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)