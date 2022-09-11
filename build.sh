for VERSION in 2.31 2.32 2.33 2.34 2.35
do
    docker build --build-arg GLIBC_VERSION=${VERSION} -t y011d4/glibc_builder64:${VERSION} ./glibc_builder64
    docker build --build-arg GLIBC_VERSION=${VERSION} -t y011d4/glibc_builder32:${VERSION} ./glibc_builder32
done
docker build -t y011d4/pwndocker .
