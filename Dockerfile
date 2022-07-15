ARG BASE_IMAGE=debian:11.3-slim@sha256:f6957458017ec31c4e325a76f39d6323c4c21b0e31572efa006baa927a160891
FROM ${BASE_IMAGE} as builder

# -----------------------------------------------------------------------------
# Stage: Builder
# -----------------------------------------------------------------------------

# Create the runtime image.

ARG SENZING_ACCEPT_EULA="I_ACCEPT_THE_SENZING_EULA"
ARG SENZING_APT_INSTALL_PACKAGE="senzingapi-tools=0.1.1-22196"
ARG SENZING_APT_REPOSITORY_NAME="senzingrepo_1.0.0-1_amd64.deb"
ARG SENZING_APT_REPOSITORY_URL="https://senzing-production-apt.s3.amazonaws.com"

ENV IMAGE_NAME="senzing/senzingapi-tools"
ENV IMAGE_MAINTAINER="support@senzing.com"
ENV IMAGE_VERSION="3.1.0"

ENV REFRESHED_AT=2022-07-15

LABEL Name=${IMAGE_NAME} \
      Maintainer=${IMAGE_MAINTAINER} \
      Version=${IMAGE_VERSION}

# Run as "root" for system installation.

USER root

# Eliminate warning messages.

ENV TERM=xterm

# Install packages via apt.

RUN apt update \
 && apt -y install \
        curl \
        gnupg \
        wget

# Install Senzing repository index.

RUN curl \
        --output /${SENZING_APT_REPOSITORY_NAME} \
        ${SENZING_APT_REPOSITORY_URL}/${SENZING_APT_REPOSITORY_NAME} \
 && apt -y install \
        /${SENZING_APT_REPOSITORY_NAME} \
 && apt update

# Install Senzing package.

RUN apt -y install ${SENZING_APT_INSTALL_PACKAGE}

# -----------------------------------------------------------------------------
# Stage: Final
# -----------------------------------------------------------------------------

FROM ${BASE_IMAGE} AS runner

LABEL Name=${IMAGE_NAME} \
      Maintainer=${IMAGE_MAINTAINER} \
      Version=${IMAGE_VERSION}

# Runtime execution.

WORKDIR /
CMD ["/bin/bash"]

# Install packages via apt.

RUN apt update \
 && apt -y install \
      python3-pip \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

# Install packages via pip.

COPY requirements.txt .
RUN pip3 install --upgrade pip \
 && pip3 install -r requirements.txt \
 && rm /requirements.txt

# Copy files from builder.

COPY --from=builder /opt/senzing      /opt/senzing
COPY --from=builder /etc/opt/senzing  /etc/opt/senzing

# Set environment variables for root.

ENV LANGUAGE=C \
    LC_ALL=C \
    LD_LIBRARY_PATH=/opt/senzing/g2/lib \
    PATH=${PATH}:/opt/senzing/g2/python \
    PYTHONPATH=/opt/senzing/g2/python \
    PYTHONUNBUFFERED=1 \
    SENZING_DOCKER_LAUNCHED=true \
    SENZING_SKIP_DATABASE_PERFORMANCE_TEST=true \
    TERM=xterm

# Runtime execution.

WORKDIR /
CMD ["/bin/bash"]
