//
// © 2024-present https://github.com/cengiz-pz
//

pluginManagement {
	repositories {
		gradlePluginPortal()
		google()
		mavenCentral()
	}
}

dependencyResolutionManagement {
	repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
	repositories {
		google()
		mavenCentral()
		flatDir {
			dirs("${rootDir}/libs")
		}
	}
}

rootProject.name = "godot-admob-plugin"
include(":admob")
