
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

String appName = "Degilib";

FirebaseAuth fAuth = FirebaseAuth.instance;
User? user = fAuth.currentUser;

FirebaseFirestore fStore = FirebaseFirestore.instance;

FirebaseAnalytics fAnalytics = FirebaseAnalytics.instance;

final isDesktopBrowser =
    kIsWeb && (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows
    || defaultTargetPlatform == TargetPlatform.linux);

IModularNavigator modular = Modular.to;
