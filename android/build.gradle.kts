//
// © 2024-present https://github.com/cengiz-pz
//
// Top-level build file where you can add configuration options common to all sub-projects/modules.

plugins {
	alias(libs.plugins.android.library) apply false
	alias(libs.plugins.kotlin.android) apply false
	alias(libs.plugins.undercouch.download) apply false
}

allprojects {
	tasks.withType<JavaCompile> {
		options.compilerArgs.add("-Xlint:unchecked")
		options.compilerArgs.add("-Xlint:deprecation")
	}
}
