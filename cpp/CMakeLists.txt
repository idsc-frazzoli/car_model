cmake_minimum_required (VERSION 2.8.11)
project (car_dynamics)

set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

find_package(Eigen3 REQUIRED)
include_directories(${EIGEN3_INCLUDE_DIR})
include_directories(include)

#list all include directories
get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
foreach(dir ${dirs})
  message(STATUS "include dir='${dir}'")
endforeach()

add_library(threeStateModel src/three_state_model.cpp)

add_executable(basicTest test/test.cpp)
target_link_libraries(basicTest threeStateModel)

