if(NOT TARGET hermes-engine::hermesvm)
add_library(hermes-engine::hermesvm SHARED IMPORTED)
set_target_properties(hermes-engine::hermesvm PROPERTIES
    IMPORTED_LOCATION "C:/Users/Khanh/.gradle/caches/9.3.1/transforms/67daa95c2663ca072cb96062d5bba35d/workspace/transformed/hermes-android-250829098.0.14-debug/prefab/modules/hermesvm/libs/android.armeabi-v7a/libhermesvm.so"
    INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Khanh/.gradle/caches/9.3.1/transforms/67daa95c2663ca072cb96062d5bba35d/workspace/transformed/hermes-android-250829098.0.14-debug/prefab/modules/hermesvm/include"
    INTERFACE_LINK_LIBRARIES ""
)
endif()

