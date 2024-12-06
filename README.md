# senzingapi-tools

## :warning: Warning

This repository is specifically for Senzing SDK V4.
It is not designed to work with Senzing API V3.

To find the Senzing API V3 version of this repository, visit [senzingsdk-tools].

## Synopsis

A Docker image with Senzingapi library and Senzing tools installed.

## Overview

The [senzing/senzingapi-tools] Docker image is pre-installed with the Senzingapi library
and python tools to help simplify creating applications that use the Senzingapi library.

## Use

In your `Dockerfile`, set the base image to `senzing/senzingapi-tools`.
Example:

```Dockerfile
FROM senzing/senzingapi-tools
```

## License

View [license information] for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the [Senzing GitHub community]
under the [Apache License 2.0].

Further, as with all Docker images, this likely also contains other software which may
be under other licenses (such as Bash, etc. from the base distribution, along with any direct
or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that
any use of this image complies with any relevant licenses for all software contained within.

[Apache License 2.0]: https://www.apache.org/licenses/LICENSE-2.0
[license information]: https://senzing.com/end-user-license-agreement/
[Senzing GitHub community]: https://github.com/Senzing/
[senzing/senzingapi-tools]: https://hub.docker.com/r/senzing/senzingapi-tools
[senzingsdk-tools]: https://github.com/Senzing/senzingsdk-tools
