if(NOT TARGET hermes-engine::hermesvm)
add_library(hermes-engine::hermesvm SHARED IMPORTED)
set_target_properties(hermes-engine::hermesvm PROPERTIES
    IMPORTED_LOCATION "C:/Users/Khanh/.gradle/caches/9.3.1/transforms/a7dc76fd9237146701e95b8bfaca51ba/workspace/transformed/hermes-android-250829098.0.14-debug/prefab/modules/hermesvm/libs/android.arm64-v8a/libhermesvm.so"
    INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Khanh/.gradle/caches/9.3.1/transforms/a7dc76fd9237146701e95b8bfaca51ba/workspace/transformed/hermes-android-250829098.0.14-debug/prefab/modules/hermesvm/include"
    INTERFACE_LINK_LIBRARIES ""
)
endif()

