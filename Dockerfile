FROM haskell:7.8

RUN cabal update

ADD ./hfpd.cabal /usr/src/hfpd/hfpd.cabal

RUN cd /usr/src/hfpd && cabal install --only-dependencies -j4

ADD . /usr/src/hfpd

RUN cd /usr/src/hfpd && cabal install && cp dist/build/hfpd/hfpd /usr/local/bin/hfpd

EXPOSE 8430

CMD hfpd
