{
  description = "A very basic flutter flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        android_sdk.accept_license = true;
        allowUnfree = true;
      };
    };
    systemImageType = "google_apis_playstore";
    platformVersions = [ "35" "33" "31" ];
    buildToolsVersion = "34.0.0";
    androidComposition = pkgs.androidenv.composeAndroidPackages {
      buildToolsVersions = [ buildToolsVersion ];
      platformVersions = platformVersions;
      abiVersions = [ "x86" "x86_64" ];

      includeNDK = true;
      ndkVersions = [ "26.3.11579264" "27.0.12077973"];

      includeEmulator = true;
      includeSystemImages = true;
      systemImageTypes = [ systemImageType ];

      cmakeVersions = [ "3.22.1" ];
      extraLicenses = [
        "android-googletv-license"
        "android-sdk-arm-dbt-license"
        "android-sdk-license"
        "android-sdk-preview-license"
        "google-gdk-license"
        "intel-android-extra-license"
        "intel-android-sysimage-license"
        "mips-android-sysimage-license"
      ];
    };
    androidSdk = androidComposition.androidsdk;
  in
  {
    packages.android-emulator = pkgs.androidenv.emulateApp {
      name = "em";
      platformVersion = "35";
      abiVersion = "x86_64"; # armeabi-v7a, mips, x86_64, arm64-v8a
      systemImageType = systemImageType;
    };
    devShell =
      with pkgs; mkShell rec {
        ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
        GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/aapt2";
        buildInputs = [
          flutter
          androidSdk # The customized SDK that we've made above
          google-chrome
        ];
      };
      shellHook = "
      alias run-em=\"nix run .#android-emulator\"
      ";
    });
  }
