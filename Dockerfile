ARG BASE_IMAGE=senzing/senzingapi-runtime:3.1.2
FROM ${BASE_IMAGE}

# Create the runtime image.

ARG SENZING_ACCEPT_EULA="I_ACCEPT_THE_SENZING_EULA"
ARG SENZING_APT_INSTALL_PACKAGE_TOOLS="senzingapi-tools=0.1.2-22199"

ENV REFRESHED_AT=2022-08-15

ENV SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
    SENZING_APT_INSTALL_PACKAGE_TOOLS=${SENZING_APT_INSTALL_PACKAGE_TOOLS}

LABEL Name="senzing/senzingapi-tools" \
      Maintainer="support@senzing.com" \
      Version="3.1.0"

# Run as "root" for system installation.

USER root

# Eliminate warning messages.

ENV TERM=xterm

# Install Senzing package.

RUN apt update \
 && apt -y install ${SENZING_APT_INSTALL_PACKAGE_TOOLS} \
 && apt clean

# Install packages via apt.

RUN apt update \
 && apt -y install \
      python3-pip \
 && apt clean

# Install packages via pip.

COPY requirements.txt .
RUN pip3 install --upgrade pip \
 && pip3 install -r requirements.txt \
 && rm /requirements.txt

# Set environment variables for root.

ENV LANGUAGE=C \
    LC_ALL=C \
    LD_LIBRARY_PATH=/opt/senzing/g2/lib \
    PATH=${PATH}:/opt/senzing/g2/python \
    PYTHONPATH=/opt/senzing/g2/python \
    PYTHONUNBUFFERED=1 \
    SENZING_DOCKER_LAUNCHED=true \
    SENZING_SKIP_DATABASE_PERFORMANCE_TEST=true

# Runtime execution.

WORKDIR /
CMD ["/bin/bash"]
