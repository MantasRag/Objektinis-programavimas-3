cmake_minimum_required(VERSION 3.25)
project(Studentai_v3 LANGUAGES CXX)

# C++ standartas
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Versija programai
set(PROJECT_VERSION_MAJOR 3)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

# Įjungti optimizaciją Release režime
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    if(MSVC)
        add_compile_options(/O2)
    else()
        add_compile_options(-O3)
    endif()
endif()

# Surinkti visus .cpp failus
set(SOURCES
    main.cpp
    generavimas.cpp
    ivestis.cpp
    isvedimas.cpp
    pagalbines_funkcijos.cpp
    rezultatai.cpp
    rusiavimas_ir_rikiavimas.cpp
    vector_list_testavimas.cpp
    studentas.cpp
    zmogus.cpp
    demonstracijos.cpp
)

# Surinkti visus .h failus
set(HEADERS
    generavimas.h
    isvedimas.h
    ivestis.h
    pagalbines_funkcijos.h
    rezultatai.h
    rusiavimas_ir_rikiavimas.h
    studentas.h
    vector_list_testavimas.h
    zmogus.h
    demonstracijos.h
)

# Sukurti vykdomąjį failą
add_executable(Studentai_v3 ${SOURCES} ${HEADERS})

# Windows resource failas (ikonėlė ir versijos info)
if(WIN32)
    if(EXISTS "${CMAKE_SOURCE_DIR}/app.rc")
        target_sources(Studentai_v3 PRIVATE app.rc)
    endif()
endif()

# Pridėti manifestą administratoriaus teisėms (Windows)
if(MSVC)
    set_target_properties(Studentai_v3 PROPERTIES
        LINK_FLAGS "/MANIFESTUAC:\"level='requireAdministrator' uiAccess='false'\""
    )
elseif(MINGW)
    message(STATUS "MinGW: manifestai ignoruojami")
endif()

# Jei reikia kopijuoti .txt failus į build katalogą
file(GLOB TXT_FILES "${CMAKE_SOURCE_DIR}/*.txt")
if(TXT_FILES)
    foreach(txt_file ${TXT_FILES})
        get_filename_component(filename ${txt_file} NAME)
        configure_file(${txt_file} ${CMAKE_BINARY_DIR}/${filename} COPYONLY)
    endforeach()
endif()

# Kopijuoti license failą
if(EXISTS "${CMAKE_SOURCE_DIR}/license.txt")
    configure_file(${CMAKE_SOURCE_DIR}/license.txt ${CMAKE_BINARY_DIR}/license.txt COPYONLY)
endif()

# Informacija kompiliavimo metu
message(STATUS "Projektas: ${PROJECT_NAME}")
message(STATUS "Versija: ${PROJECT_VERSION}")
message(STATUS "CMake versija: ${CMAKE_VERSION}")
message(STATUS "C++ standartas: C++${CMAKE_CXX_STANDARD}")
message(STATUS "Kompiliatorius: ${CMAKE_CXX_COMPILER_ID}")

# CPack konfigūracija diegimo paketui
set(CPACK_PACKAGE_NAME "Studentai_v3")
set(CPACK_PACKAGE_VENDOR "VU")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Studentų rezultatų valdymo programa")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "VU\\Mantas-Ragaišis")

include(CPack)