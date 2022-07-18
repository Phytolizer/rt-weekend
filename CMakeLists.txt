cmake_minimum_required(VERSION 3.23)

project(rt-weekend LANGUAGES CXX)

add_executable(rt-weekend src/main.cpp src/sphere.cpp src/hittable_list.cpp)
target_compile_features(rt-weekend PRIVATE cxx_std_20)
target_include_directories(rt-weekend PRIVATE include)
