cmake_minimum_required(VERSION 2.8.4)

SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
IF(UNIX)
 link_libraries(m)
ENDIF(UNIX)

project (GULL) 
SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
SET(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})
SET(RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
SET(CMAKE_BUILD_TYPE Release)

add_executable (GULL-map GULL-map.c mem.c time.c msg.c parser.c common.c buffer.c levels.c cmodel.c defs.h param.h) 
add_executable (GULL-visual GULL-visual.c mem.c msg.c parser.c common.c buffer.c paint.c defs.h) 
TARGET_LINK_LIBRARIES(GULL-map pthread)
TARGET_LINK_LIBRARIES(GULL-visual)
