import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocStates {
  final List _stats = [];

  BlocStates(List states) {
    _stats.addAll(states);
  }
  T get<T>() => _stats.firstWhere((entry) => (entry is T), orElse: () => null);

  T getState<T>(int index) {
    return _stats[index];
  }
}

class MultiBlocBuilder extends StatefulWidget {
  final Widget Function(BuildContext, BlocStates) _builder;
  final List<BlocBase> _blocs;
  final bool Function(BuildContext, BlocStates)? _buildWhen;

  const MultiBlocBuilder({
    super.key,
    required List<BlocBase> blocs,
    required Widget Function(BuildContext, BlocStates) builder,
    bool Function(BuildContext, BlocStates)? buildWhen,
  }) : _blocs = blocs,
       _builder = builder,
       _buildWhen = buildWhen;

  @override
  State<StatefulWidget> createState() => _MultiBlocState();
}

class _MultiBlocState extends State<MultiBlocBuilder> {
  final List<StreamSubscription> _stateSubscriptions = [];
  get states => widget._blocs.map((bloc) => bloc.state).toList();

  @override
  void initState() {
    super.initState();

    for (var bloc in widget._blocs) {
      final subscription = bloc.stream.listen((state) {
        buildBlocs();
      });
      _stateSubscriptions.add(subscription);
    }
  }

  buildBlocs() {
    if (widget._buildWhen != null) {
      bool build = widget._buildWhen!(context, BlocStates(states));

      if (build) setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final states = widget._blocs.map((bloc) => bloc.state).toList();
    return widget._builder(context, BlocStates(states));
  }

  @override
  void dispose() {
    super.dispose();
    for (var subscription in _stateSubscriptions) {
      subscription.cancel();
    }
  }
}

class MultiBlocConsumer extends StatefulWidget {
  final Function(BuildContext, BlocStates) _listener;
  final Widget Function(BuildContext, BlocStates) _builder;
  final List<BlocBase> _blocs;
  final bool Function(BuildContext, BlocStates)? _buildWhen;
  final bool Function(BuildContext, BlocStates)? _listenWhen;
  final void Function(BuildContext, BlocStates)? _onInit;

  const MultiBlocConsumer({
    super.key,
    required List<BlocBase> blocs,
    required Function(BuildContext, BlocStates) listener,
    required Widget Function(BuildContext, BlocStates) builder,
    bool Function(BuildContext, BlocStates)? buildWhen,
    bool Function(BuildContext, BlocStates)? listenWhen,
    void Function(BuildContext, BlocStates)? onInit,
  }) : _blocs = blocs,
       _listener = listener,
       _builder = builder,
       _buildWhen = buildWhen,
       _onInit = onInit,
       _listenWhen = listenWhen;

  @override
  State<StatefulWidget> createState() => _MultiBlocConsumerState();
}

class _MultiBlocConsumerState extends State<MultiBlocConsumer> {
  final List<StreamSubscription> _stateSubscriptions = [];

  get states => widget._blocs.map((bloc) => bloc.state).toList();

  @override
  void initState() {
    super.initState();
    for (var bloc in widget._blocs) {
      final subscription = bloc.stream.listen((state) {
        listenToBlocs();
        buildBlocs();
      });
      _stateSubscriptions.add(subscription);
    }
    if (widget._onInit != null) {
      widget._onInit!(context, BlocStates(states));
    }
  }

  listenToBlocs() {
    if (widget._listenWhen != null) {
      bool listen = widget._listenWhen!(context, BlocStates(states));

      if (listen) widget._listener(context, BlocStates(states));
    } else {
      widget._listener(context, BlocStates(states));
    }
  }

  buildBlocs() {
    if (widget._buildWhen != null) {
      bool build = widget._buildWhen!(context, BlocStates(states));

      if (build) setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context, BlocStates(states));
  }

  @override
  void dispose() {
    super.dispose();
    for (var subscription in _stateSubscriptions) {
      subscription.cancel();
    }
  }
}
