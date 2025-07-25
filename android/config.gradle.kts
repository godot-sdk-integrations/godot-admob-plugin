//
// © 2024-present https://github.com/cengiz-pz
//

extra.apply {
	// Plugin details
	set("pluginNodeName", "Admob")
	set("pluginName", get("pluginNodeName") as String + "Plugin")
	set("pluginPackageName", "org.godotengine.plugin.android.admob")
	set("pluginVersion", "5.0")

	// Godot
	set("godotVersion", "4.5")
	set("releaseType", "beta3")
	set("godotAarUrl", "https://github.com/godotengine/godot-builds/releases/download/${get("godotVersion")}-${get("releaseType")}/godot-lib.${get("godotVersion")}.${get("releaseType")}.template_release.aar")
	set("godotAarFile", "godot-lib-${get("godotVersion")}.${get("releaseType")}.aar")

	// Demo
	set("demoAddOnsDirectory", "../../demo/addons")
	set("templateDirectory", "../../addon")
}
