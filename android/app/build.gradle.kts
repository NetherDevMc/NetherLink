import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = file("../key.properties")
val keystoreProperties = Properties()
val hasKeystore = keystorePropertiesFile.exists()

if (hasKeystore) {
    FileInputStream(keystorePropertiesFile).use {
        keystoreProperties.load(it)
    }
}

android {
    namespace = "net.netherdev.netherLink"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "net.netherdev.netherLink"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasKeystore) {
            create("release") {
                storeFile = keystoreProperties["storeFile"]?.let { file("../${it as String}") }
                storePassword = keystoreProperties["storePassword"] as String?
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
            }
        }
    }

    buildTypes {
        getByName("release") {
            if (hasKeystore) {
                signingConfig = signingConfigs.getByName("release")
            }
            // minifyEnabled = false // Indien gewenst
            // shrinkResources = false // Indien gewenst
        }
        getByName("debug") {
        }
    }
}

flutter {
    source = "../.."
}