FROM skysider/pwndocker:latest

ENV TZ Asia/Tokyo

RUN apt -y update && apt -y upgrade
RUN pip install -U pip && \
    pip install -U z3-solver angr pwntools

# RUN dpkg --add-architecture i386 && \
#     apt-get -y update && \
#     apt install -y ruby-bundler && \
#     rm -rf /var/lib/apt/list/*

# install newer gdb
# https://github.com/Gallopsled/pwntools/issues/1783#issuecomment-850425171
RUN apt remove -y gdb gdbserver
RUN cd /tmp && \
    wget https://sourceware.org/pub/gdb/snapshots/current/gdb-13.0.50.20220910.tar.xz && \
    tar xf gdb-13.0.50.20220910.tar.xz && \
    cd gdb-13.0.50.20220910 && \
    ./configure --with-python=/usr/bin/python3 && make -j8 && make install && rm /tmp/* -r

COPY --from=glibc_builder64:2.31 /glibc/2.31/64 /glibc/2.31/64
# COPY --from=glibc_builder32:2.31 /glibc/2.31/32 /glibc/2.31/32

COPY --from=glibc_builder64:2.33 /glibc/2.33/64 /glibc/2.33/64
# COPY --from=glibc_builder32:2.33 /glibc/2.33/32 /glibc/2.33/32

COPY --from=glibc_builder64:2.34 /glibc/2.34/64 /glibc/2.34/64
# COPY --from=glibc_builder32:2.34 /glibc/2.34/32 /glibc/2.34/32

COPY --from=glibc_builder64:2.35 /glibc/2.35/64 /glibc/2.35/64
# COPY --from=glibc_builder32:2.35 /glibc/2.35/32 /glibc/2.35/32

WORKDIR /ctf/work/
CMD ["/sbin/my_init"]
