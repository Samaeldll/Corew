#
<<<<<<< HEAD
# This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
=======
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
>>>>>>> master
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
<<<<<<< HEAD
#
# User has manually chosen to ignore the git-tests, so throw them a warning.
# This is done EACH compile so they can be alerted about the consequences.
=======
>>>>>>> master
#

function(ADD_CXX_PCH TARGET_NAME_LIST PCH_HEADER)
  foreach(TARGET_NAME ${TARGET_NAME_LIST})
    target_precompile_headers(${TARGET_NAME} PRIVATE ${PCH_HEADER})
  endforeach()
endfunction(ADD_CXX_PCH)
