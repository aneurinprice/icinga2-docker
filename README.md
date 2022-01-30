# ICINGA2-DOCKER

[Dockerhub](https://hub.docker.com/r/m08y/icinga2-docker)

[Github](https://github.com/aneurinprice/icinga2-docker)

This is a docker container to run [Icinga2](https://icinga.com/). Mount in your own Config or keep it in a git repo.

## How to run

```
docker run -d -p 5665:5665 m08y/icinga2-docker:latest
```

## Gotchas

- Not done loads of testing yet, probably a bit broken
- CONFIG AND CERTIFICATE HANDLIG HERE
