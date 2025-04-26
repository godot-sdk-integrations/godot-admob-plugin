//
// © 2024-present https://github.com/cengiz-pz
//

// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
	id("com.android.library") version "8.4.0" apply false
}

val cleanBuildDir by tasks.registering(Delete::class) {
	delete(rootProject.buildDir)
}

allprojects {
	tasks.withType<JavaCompile> {
		options.compilerArgs.add("-Xlint:unchecked")
		options.compilerArgs.add("-Xlint:deprecation")
	}
}