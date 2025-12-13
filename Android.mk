
LOCAL_PATH := $(call my-dir)

# ---------------------
# HAL模块 - libhal.so
# ---------------------
include $(CLEAR_VARS)
LOCAL_MODULE := OHAL
LOCAL_SRC_FILES := $(wildcard HAL/*.c) $(wildcard HAL/*.cpp)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/HAL
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_CXXFLAGS += -std=c++11
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_SHARED_LIBRARY)

# ---------------------
# OTSM模块 - libotsm.so  
# ---------------------
include $(CLEAR_VARS)
LOCAL_MODULE := OTSM
LOCAL_SRC_FILES := $(wildcard OTSM/*.c) $(wildcard OTSM/*.cpp)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/OTSM
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_CXXFLAGS += -std=c++11
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_SHARED_LIBRARY)

# ---------------------
# IPC目录 - libOIPC.so + 两个可执行文件
# ---------------------
# 共享库 OIPC
include $(CLEAR_VARS)
LOCAL_MODULE := OIPC
LOCAL_SRC_FILES := $(wildcard IPC/*.c) $(wildcard IPC/*.cpp)
LOCAL_SRC_FILES := $(filter-out IPC/octopus_ipc_server.cpp IPC/octopus_ipc_client.cpp, $(LOCAL_SRC_FILES))
LOCAL_C_INCLUDES := $(LOCAL_PATH)/IPC
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_CXXFLAGS += -std=c++11
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_SHARED_LIBRARY)

# 可执行文件 server
include $(CLEAR_VARS)
LOCAL_MODULE := octopus_ipc_server
LOCAL_SRC_FILES := IPC/octopus_ipc_server.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/IPC
LOCAL_SHARED_LIBRARIES := OIPC
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_EXECUTABLES)
include $(BUILD_EXECUTABLE)

# 可执行文件 client
include $(CLEAR_VARS)
LOCAL_MODULE := octopus_ipc_client
LOCAL_SRC_FILES := IPC/octopus_ipc_client.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/IPC
LOCAL_SHARED_LIBRARIES := OIPC
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_EXECUTABLES)
include $(BUILD_EXECUTABLE)

# ---------------------
# APP模块 - libapp.so
# ---------------------

include $(CLEAR_VARS)
LOCAL_MODULE := OAPP
LOCAL_SRC_FILES := $(wildcard APP/*.c) $(wildcard APP/*.cpp)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/APP
LOCAL_SHARED_LIBRARIES := OHAL OTSM OIPC
LOCAL_LDLIBS += -ldl -llog -lm -latomic
LOCAL_CXXFLAGS += -std=c++11
LOCAL_MODULE_RELATIVE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_SHARED_LIBRARY)

