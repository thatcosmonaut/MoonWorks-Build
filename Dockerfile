FROM fedora

RUN dnf update -y

# All the base build tools!
RUN dnf install -y bzip2 bzip2-devel clang cmake cmake3 gcc-c++ git hg \
    libcxx-devel libstdc++-static libuuid-devel libxml2-devel llvm-devel \
    lzma-sdk-devel mingw64-SDL2 openal-soft-devel openssl-devel patch \
    SDL2-devel svn yum-utils yum-plugin-copr

# SDL2 dependencies
RUN dnf builddep -y SDL2

# MinGW
RUN dnf install -y mingw64-vulkan-* mingw64-SDL2* mingw64-gcc* mingw64-cpp* mingw64-spirv*

# CMake3 by default
RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 10 \
    --slave /usr/local/bin/ctest ctest /usr/bin/ctest \
    --slave /usr/local/bin/cpack cpack /usr/bin/cpack \
    --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake \
    --family cmake
RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 \
    --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 \
    --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 \
    --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 \
    --family cmake

