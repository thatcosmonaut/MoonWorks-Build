FROM centos

RUN dnf update

RUN dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN dnf install centos-release-scl

# All the base build tools!
RUN dnf install bzip2 bzip2-devel clang cmake cmake3 gcc-c++ git hg \
    libcxx-devel libstdc++-static libuuid-devel libxml2-devel llvm-devel \
    lzma-sdk-devel openal-soft-devel openssl-devel patch svn yum-utils \
    yum-plugin-copr

# SDL2 dependencies
RUN dnf builddep SDL2

# Coprs for MinGW as well as GCC 8, needed to build Clang/LLVM/osxcross
RUN dnf copr enable mlampe/devtoolset-8
RUN dnf copr enable alonid/mingw-epel7
RUN dnf install devtoolset-8 mingw32-* mingw64-*

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
