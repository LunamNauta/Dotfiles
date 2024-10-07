cmake_minimum_required(VERSION 3.5)
project(Project)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "--target=x86_64-w64-mingw32")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(main ../src/main.cpp)
target_link_libraries(main PRIVATE stdc++exp)
