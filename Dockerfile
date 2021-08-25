FROM fedora:32
LABEL maintainer="Sheldon Rupp <me@fieu.cc>"

ENV SSH_PASSWORD ChangeMeToActivateSSH

RUN dnf -y update

RUN dnf -y install htop \
    nasm \
    vim \
    nano \
    wget \
    curl \
    gcc \
    gcc-c++ \
    cmake \
    autoconf \
    make \
    git \
    kernel-devel \
    valgrind \
    gdb \
    file \
    ncurses-devel \
    SFML-devel \
    SDL2 \
    SDL2-devel \
    SDL \
    SDL2_mixer-devel \
    SDL2_image \
    SDL2_image-devel \
    SDL2_ttf \
    SDL2_ttf-devel \
    strace \
    procps \
    nc \
    netcat \
    tmux \
    screen \
    libuuid \
    libuuid-devel

# Pulled from upstream (Epitech/epitest-docker) and modified to remove bloat
RUN dnf -y upgrade                          \
        && dnf -y install dnf-plugins-core  \
        && dnf -y --refresh install         \
        CUnit-devel.x86_64                  \
        SDL2                                \
        SDL2-devel.x86_64                   \
        SDL2-static.x86_64                  \
        SDL2_image.x86_64                   \
        SDL2_image-devel.x86_64             \
        SDL2_ttf                            \
        SDL2_ttf-devel.x86_64               \
        SDL2_mixer                          \
        SDL2_mixer-devel.x86_64             \
        SDL2_gfx                            \
        SDL2_gfx-devel.x86_64               \
        libcaca.x86_64                      \
        libcaca-devel.x86_64                \
        SFML.x86_64                         \
        SFML-devel.x86_64                   \
        autoconf                            \
        automake                            \
        boost                               \
        boost-devel.x86_64                  \
        boost-graph                         \
        boost-math                          \
        boost-static.x86_64                 \
        ca-certificates.noarch              \
        clang.x86_64                        \
        clang-analyzer                      \
        cmake.x86_64                        \
        curl.x86_64                         \
        elfutils-libelf-devel.x86_64        \
        flac-devel.x86_64                   \
        freetype-devel.x86_64               \
        gcc-c++.x86_64                      \
        gcc.x86_64                          \
        gdb.x86_64                          \
        git                                 \
        glibc-devel.x86_64                  \
        glibc-locale-source.x86_64          \
        glibc.x86_64                        \
        gmp-devel.x86_64                    \
        ksh.x86_64                          \
        langpacks-en                        \
        libX11-devel.x86_64                 \
        libXext-devel.x86_64                \
        libXrandr-devel.x86_64              \
        libXinerama-devel.x86_64            \
        libXcursor-devel.x86_64             \
        libXi-devel.x86_64                  \
        libgudev-devel                      \
        libjpeg-turbo-devel.x86_64          \
        libtsan                             \
        libvorbis-devel.x86_64              \
        llvm.x86_64                         \
        llvm-devel.x86_64                   \
        ltrace.x86_64                       \
        make.x86_64                         \
        nasm.x86_64                         \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        net-tools.x86_64                    \
        nc                                  \
        openal-soft-devel.x86_64            \
        openssl-devel                       \
        patch                               \
        procps-ng.x86_64                    \
        qt5                                 \
        qt5-devel                           \
        rlwrap.x86_64                       \
        strace.x86_64                       \
        sudo.x86_64                         \
        systemd-devel                       \
        tar.x86_64                          \
        tcsh.x86_64                         \
        tmux.x86_64                         \
        tree.x86_64                         \
        unzip.x86_64                        \
        diffutils                           \
        valgrind.x86_64                     \
        wget.x86_64                         \
        which.x86_64                        \
        xcb-util-image-devel.x86_64         \
        xcb-util-image.x86_64               \
        xz.x86_64                           \
        zip.x86_64                          \
        zsh.x86_64                          \
        gtest.x86_64                        \
        gtest-devel.x86_64                  \
        irrlicht.x86_64                     \
        irrlicht-devel.x86_64               \
        aalib                               \
        vim                                 \
        libuuid libuuid-devel               \
    && dnf clean all -y

RUN mkdir /work

# Install musl (for easy static binary generation)
RUN mkdir /musl
RUN wget $(curl -s musl.cc | grep x86_64-linux-musl-cross | head -n1) \
    && tar zxvf x86_64-linux-musl*.tgz -C /musl \
    && rm -rf /x86_64-linux-musl*.tgz
RUN echo 'export PATH="/musl/x86_64-linux-musl-cross/bin:$PATH"' >> /root/.bashrc \
    && echo 'alias musl-gcc="x86_64-linux-musl-cc"' >> /root/.bashrc \
    && echo 'alias musl-g++="x86_64-linux-musl-c++"' >> /root/.bashrc \
    && echo 'alias musl-gfortran="x86_64-linux-musl-gfortran"' >> /root/.bashrc \
    && echo 'alias musl-ld="x86_64-linux-musl-ld"' >> /root/.bashrc \
    && echo 'alias musl-nm="x86_64-linux-musl-nm"' >> /root/.bashrc \
    && echo 'alias musl-objdump="x86_64-linux-musl-objdump"' >> /root/.bashrc \
    && echo 'alias musl-strip="x86_64-linux-musl-strip"' >> /root/.bashrc \
    && echo 'alias musl-addr2line="x86_64-linux-musl-addr2line"' >> /root/.bashrc \
    && echo 'alias musl-readelf="x86_64-linux-musl-readelf"' >> /root/.bashrc \
    && echo 'alias musl-objcopy="x86_64-linux-musl-objcopy"' >> /root/.bashrc \
    && echo 'alias musl-gdb="x86_64-linux-musl-gdb"' >> /root/.bashrc

RUN bash -c 'bash <(curl -Ss https://raw.githubusercontent.com/Epitech/epitest-docker/master/fs/tmp/build_csfml.sh)'


# SSH Server
RUN dnf install -y openssh-server && dnf clean all -y

EXPOSE 22

WORKDIR /work

COPY entrypoint.sh /

CMD ["sh", "/entrypoint.sh"]