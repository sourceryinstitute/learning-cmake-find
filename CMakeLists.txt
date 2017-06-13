cmake_minimum_required(VERSION 3.7)

project(build_against_netcdf LANGUAGES Fortran)

# Find the native NetCDF includes and library
include(cmake-modules/FindNetCDF.cmake)

set (NETCDF_F90 "YES") # Require Fortran interfaces to be FOUND
find_package (NetCDF REQUIRED)

include_directories(${NETCDF_INCLUDES})

# For fortran module files it's a good practice to use CMake's "object libraries"
# to avoid parallel build race conditions. See
# https://cmake.org/cmake/help/latest/command/add_library.html#object-libraries

add_library(model_const OBJECT src/model_constants.f90)

add_library(io_routines src/io_routines.f90 $<TARGET_OBJECTS:model_const>)

target_link_libraries (io_routines ${NETCDF_LIBRARIES})
