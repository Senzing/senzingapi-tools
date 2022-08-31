# senzingapi-tools

## Overview

The `senzing/senzingapi-tools` docker image is pre-installed with the Senzingapi library
and python tools to help simplify creating applications that use the Senzingapi library.

## Use

In a Dockerfile, the docker image created by this repo can be used in a Docker
file by setting it as the base image.

```Dockerfile
FROM senzing/senzingapi-tools
```

## License

View
[license information](https://senzing.com/end-user-license-agreement/)
for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the
[Senzing GitHub community](https://github.com/Senzing/)
under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

Further, as with all Docker images,
this likely also contains other software which may be under other licenses
(such as Bash, etc. from the base distribution,
along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage,
it is the image user's responsibility to ensure that any use of this image complies
with any relevant licenses for all software contained within.
