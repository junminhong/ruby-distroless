#!/bin/bash
set -e

ruby_versions=("2.5.9" "2.6.10" "2.7.8" "3.0.7" "3.1.6" "3.2.7" "3.3.7" "3.4.2")

platform=${PLATFORM:-linux/amd64}

if [ "$platform" = "linux/arm64" ]; then
  LIB_Z_PATH="/lib/aarch64-linux-gnu/libz.so.1"
  LIB_GMP_PATH="/usr/lib/aarch64-linux-gnu/libgmp.so.10"
  LIB_CRYPT_PATH="/lib/aarch64-linux-gnu/libcrypt.so.1"
  LIB_GCC_PATH="/lib/aarch64-linux-gnu/libgcc_s.so.1"
  LD_LIB_PATH="/usr/local/lib:/lib/aarch64-linux-gnu:/usr/lib/aarch64-linux-gnu"
else
  LIB_Z_PATH="/lib/x86_64-linux-gnu/libz.so.1"
  LIB_GMP_PATH="/usr/lib/x86_64-linux-gnu/libgmp.so.10"
  LIB_CRYPT_PATH="/lib/x86_64-linux-gnu/libcrypt.so.1"
  LIB_GCC_PATH="/lib/x86_64-linux-gnu/libgcc_s.so.1"
  LD_LIB_PATH="/usr/local/lib:/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu"
fi

push_image=${PUSH_IMAGE:-false}

image_name="junminhong/ruby-distroless"

for ver in "${ruby_versions[@]}"; do
  RUBY_VERSION="$ver"
  IFS='.' read -r major minor patch <<< "$ver"
  RUBY_MAJOR_MINOR="${major}.${minor}"

  echo "Building Ruby distroless image for Ruby version ${RUBY_VERSION} on platform ${platform}..."

  if [ "$push_image" = "true" ]; then
    extra_args="--push"
  else
    extra_args="--load"
  fi
  TAG_PLATFORM=$(echo "${platform}" | tr '/' '-')
  docker buildx build \
    --platform "${platform}" \
    --build-arg RUBY_VERSION="${RUBY_VERSION}" \
    --build-arg RUBY_MAJOR_MINOR="${RUBY_MAJOR_MINOR}" \
    --build-arg LIB_Z_PATH="${LIB_Z_PATH}" \
    --build-arg LIB_GMP_PATH="${LIB_GMP_PATH}" \
    --build-arg LIB_CRYPT_PATH="${LIB_CRYPT_PATH}" \
    --build-arg LIB_GCC_PATH="${LIB_GCC_PATH}" \
    --build-arg LD_LIB_PATH="${LD_LIB_PATH}" \
    -t "${image_name}:${RUBY_VERSION}-${TAG_PLATFORM}" \
    ${extra_args} \
    .

  echo "Ruby distroless image for Ruby ${RUBY_VERSION} built successfully."
done

echo "All images built."
