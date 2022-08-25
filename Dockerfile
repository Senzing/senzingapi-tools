ARG BASE_IMAGE=senzing/senzingapi-runtime:3.2.0
FROM ${BASE_IMAGE}

# Create the runtime image.

ARG SENZING_ACCEPT_EULA="I_ACCEPT_THE_SENZING_EULA"
ARG SENZING_APT_INSTALL_TOOLS_PACKAGE="senzingapi-tools=3.2.0-22234"

ENV REFRESHED_AT=2022-08-25

ENV SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
    SENZING_APT_INSTALL_TOOLS_PACKAGE=${SENZING_APT_INSTALL_TOOLS_PACKAGE}

LABEL Name="senzing/senzingapi-tools" \
      Maintainer="support@senzing.com" \
      Version="3.2.0"

# Run as "root" for system installation.

USER root

# Eliminate warning messages.

ENV TERM=xterm

# Install Senzing package.

RUN apt-get update \
 && apt-get -y install ${SENZING_APT_INSTALL_TOOLS_PACKAGE} \
 && apt-get clean

# Install packages via apt.

RUN apt-get update \
 && apt-get -y install \
      python3-psycopg2 \
 && apt-get clean

# Set environment variables for root.

ENV LANGUAGE=C \
    LC_ALL=C.UTF-8 \
    LD_LIBRARY_PATH=/opt/senzing/g2/lib \
    PATH=${PATH}:/opt/senzing/g2/python \
    PYTHONPATH=/opt/senzing/g2/python:/opt/senzing/g2/sdk/python \
    PYTHONUNBUFFERED=1 \
    SENZING_DOCKER_LAUNCHED=true \
    SENZING_SKIP_DATABASE_PERFORMANCE_TEST=true

# Runtime execution.

WORKDIR /
CMD ["/bin/bash"]
