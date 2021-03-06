/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

// This file was created automatically from your script configuration!
// Use CMake to reconfigure this file, never change it on your own!

#cmakedefine WARHEAD_IS_DYNAMIC_SCRIPTLOADER

#include "Define.h"
#include <vector>
#include <string>

// Add modules defines
@WARHEAD_SCRIPTS_FORWARD_DECL@
#ifdef WARHEAD_IS_DYNAMIC_SCRIPTLOADER
#  include "revision.h"
#  define WH_MODULES_API WH_API_EXPORT
extern "C" {

/// Exposed in script modules to return the script module revision hash.
WH_MODULES_API char const* GetScriptModuleRevisionHash()
{
    return _HASH;
}

/// Exposed in script module to return the name of the script module
/// contained in this shared library.
WH_MODULES_API char const* GetScriptModule()
{
    return "@WARHEAD_CURRENT_SCRIPT_PROJECT@";
}

#else
#  include "ModulesScriptLoader.h"
#  define WH_MODULES_API
#endif

/// Exposed in script modules to register all scripts to the ScriptMgr.
WH_MODULES_API void AddModulesScripts()
{
    // Modules define list
@WARHEAD_SCRIPTS_INVOKE@}

/// Exposed in script modules to get the build directive of the module.
WH_MODULES_API char const* GetModulesBuildDirective()
{
    return _BUILD_DIRECTIVE;
}

#ifdef WARHEAD_IS_DYNAMIC_SCRIPTLOADER
} // extern "C"
#endif