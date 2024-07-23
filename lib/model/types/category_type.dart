import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

enum CategoryType {
  information,
  general;

  @override
  String toString() {
    switch (this) {
      case CategoryType.information:
        return "information";
      case CategoryType.general:
        return "general";
    }
  }

  static stringToCategory(String string) {
    switch (string) {
      case "information":
        return CategoryType.information;
      case "general":
        return CategoryType.general;
    }
  }
}
