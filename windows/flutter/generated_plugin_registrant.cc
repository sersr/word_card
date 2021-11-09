//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <libwinmedia/libwinmedia_plugin.h>
#include <sqlite3_windows_dll/sqlite3_windows_dll_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  LibwinmediaPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LibwinmediaPlugin"));
  Sqlite3WindowsDllPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("Sqlite3WindowsDllPlugin"));
}
