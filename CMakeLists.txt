cmake_minimum_required(VERSION 3.7)

project(build_against_netcdf LANGUAGES Fortran)

add_library(io_routines src/io_routines.f90)

# Find the native NetCDF includes and library

set(NETCDF_INCLUDES /opt/local/include) #  NETCDF_INCLUDES    - where to find netcdf.h, etc
set(NETCDF_LIBRARIES /opt/local/lib)    #  NETCDF_LIBRARIES   - Link these libraries when using NetCDF


include(cmake-modules/FindNetCDF.cmake)


set (NETCDF_F90 "YES") # Require Fortran interfaces to be FOUND
find_package (NetCDF REQUIRED)
target_link_libraries (io_routines ${NETCDF_LIBRARIES})
