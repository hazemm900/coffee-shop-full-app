plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter Gradle Plugin لازم يكون بعد Android و Kotlin
    id("dev.flutter.flutter-gradle-plugin")

    // Google services plugin
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.coffee_shop_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        // ✅ الحل هنا: فعل desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.coffee_shop_app"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}


flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.3.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    implementation("androidx.multidex:multidex:2.0.1")

    // ✅ أضف ده هنا
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

