include(vcpkg_common_functions)
vcpkg_fail_port_install(ON_ARCH "arm" ON_TARGET "uwp")
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yyzybb537/libgo
    REF b6f5e0115fd928421babc23c6561217ccd915de4 #v3.2.4
    SHA512 11f4539d3f8ce818ddb01b4cdd155906bb352ce4f2eacd2b9f743777728330f0ec63efbc5907120662fb7c11b8dcd9cfdddf63a7e96b4b00e5d3e2bf803679a7
    HEAD_REF master
    PATCHES cmake.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

# remove duplicated include files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/libgo/netio/disable_hook)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/libgo/netio/unix/static_hook)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libgo RENAME copyright)
file(INSTALL ${CURRENT_PORT_DIR}/libgo-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/libgo)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
