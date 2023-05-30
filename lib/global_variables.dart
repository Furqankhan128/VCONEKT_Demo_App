
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/resources/repository.dart';


final GlobalKey<NavigatorState> gNavigatorKey = GlobalKey<NavigatorState>();

GlobalKey<ScaffoldState>? gScaffoldStateKey;

final RouteObserver<PageRoute> gRouteObserver = RouteObserver<PageRoute>();

final Repository gRepository = Repository();

final FirebaseAuth gFirebaseAuth = FirebaseAuth.instance;

final gDatabase = FirebaseFirestore.instance;




