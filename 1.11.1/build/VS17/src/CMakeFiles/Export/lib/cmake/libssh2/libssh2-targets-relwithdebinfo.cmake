#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libssh2::libssh2_static" for configuration "RelWithDebInfo"
set_property(TARGET libssh2::libssh2_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(libssh2::libssh2_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libssh2_static.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS libssh2::libssh2_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_libssh2::libssh2_static "${_IMPORT_PREFIX}/lib/libssh2_static.lib" )

# Import target "libssh2::libssh2_shared" for configuration "RelWithDebInfo"
set_property(TARGET libssh2::libssh2_shared APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(libssh2::libssh2_shared PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libssh2.lib"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/libssh2.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS libssh2::libssh2_shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_libssh2::libssh2_shared "${_IMPORT_PREFIX}/lib/libssh2.lib" "${_IMPORT_PREFIX}/bin/libssh2.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
