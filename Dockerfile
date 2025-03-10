ARG RUBY_VERSION=3.3.4
ARG RUBY_MAJOR_MINOR=3.3
FROM ruby:${RUBY_VERSION}-slim AS builder

FROM gcr.io/distroless/base-debian12

ARG RUBY_MAJOR_MINOR
ARG LIB_Z_PATH
ARG LIB_GMP_PATH
ARG LIB_CRYPT_PATH
ARG LIB_GCC_PATH
ARG LD_LIB_PATH

COPY --from=builder /usr/local/bin/ruby /usr/local/bin/ruby
COPY --from=builder /usr/local/lib/libruby.so.${RUBY_MAJOR_MINOR} /usr/local/lib/libruby.so.${RUBY_MAJOR_MINOR}
COPY --from=builder /usr/local/lib/ruby /usr/local/lib/ruby

COPY --from=builder ${LIB_Z_PATH} ${LIB_Z_PATH}
COPY --from=builder ${LIB_GMP_PATH} ${LIB_GMP_PATH}
COPY --from=builder ${LIB_CRYPT_PATH} ${LIB_CRYPT_PATH}
COPY --from=builder ${LIB_GCC_PATH} ${LIB_GCC_PATH}

ENV LD_LIBRARY_PATH=${LD_LIB_PATH}

CMD ["/usr/local/bin/ruby", "-v"]
