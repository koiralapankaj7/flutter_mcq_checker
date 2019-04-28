import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/add_module_bottom_sheet.dart';
import 'package:flutter_mcq_checker/src/widgets/data_unavailable.dart';
import 'package:flutter_mcq_checker/src/widgets/module_list_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final ModuleBloc bloc;

  HomeScreen({this.bloc});

  @override
  _HomeScreenState createState() => _HomeScreenState(bloc: bloc);
}

class _HomeScreenState extends State<HomeScreen> {
  //
  //
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  VoidCallback _bottomSheetCallback;
  PersistentBottomSheetController _controller;

  final ModuleBloc bloc;
  _HomeScreenState({this.bloc});

  @override
  void initState() {
    super.initState();
    _bottomSheetCallback = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xE6344955),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Modules'),
      ),
      body: buildBody(),
      floatingActionButton: floatingActionButton(),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: widget.bloc.modules,
      builder: (BuildContext context, AsyncSnapshot<List<Module>> snapshot) {
        if (!snapshot.hasData) {
          return DataUnavailable();
        }
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ModuleListTile(module: snapshot.data[index]);
          },
        );
      },
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: _bottomSheetCallback,
      child: Icon(
        CupertinoIcons.add,
        color: Colors.white,
        size: 35.0,
      ),
      tooltip: 'Add module',
      backgroundColor: Colors.green,
    );
  }

  void _showBottomSheet() {
    setState(() {
      _bottomSheetCallback = null;
    });

    _controller =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return AddModule(
        scaffold: _scaffoldKey,
        context: context,
        bloc: bloc,
      );
    });

    _controller.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }
}
