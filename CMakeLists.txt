cmake_minimum_required(VERSION 3.16)

project(Flowibi VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation directory" FORCE)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)
set(CMAKE_DISABLE_FIND_PACKAGE_WrapVulkanHeaders TRUE)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(${CMAKE_PROJECT_NAME}
    src/main.cpp
    resources/icons/icons.qrc
    resources/images/images.qrc
)

set(QML_FILES
    qml/Main.qml
    qml/ImageCard.qml
    qml/GalleryPane.qml
    qml/BackgroundDots.qml
)

set(QML_SINGLETONS
    qml/Singletons/Common.qml
)

set_source_files_properties(${QML_SINGLETONS}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI Odizinne.${CMAKE_PROJECT_NAME}
    VERSION 1.0
    QML_FILES ${QML_FILES} ${QML_SINGLETONS}
    QML_FILES qml/HomePane.qml
    QML_FILES qml/ContactPane.qml
    QML_FILES qml/SocialPane.qml
    QML_FILES qml/HeaderBar.qml
    QML_FILES qml/CustomStackView.qml
    QML_FILES qml/SidebarNavigation.qml
)

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
