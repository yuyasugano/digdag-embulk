AIジョブカレ分析基盤構築・インフラ基礎講座 <br>
https://www.aijobcolle.com/infrastructure

### References
- [treasure-data/digdag](https://github.com/treasure-data/digdag) 
- [docs.digdag.io](https://docs.digdag.io/)
- [EMBULK PLUGINS BY CATEGORY](https://plugins.embulk.org/)

### Usage
- copy docker-compose.example.yml file as docker-compose.yml
  - do not commit docker-compose.yml file if it has sensitive information such as keys
```
cp docker-compose.example.yml docker-compose.yml
```
- build Docker image
```
docker bulid -t digdag-embulk .
```
- turn up digdag and embulk
```
docker-compose up
```
digdag UI is accessible on the  http://127.0.0.1:3000

- close digdag
  - exit from digdag with the ctrl-c or ctrl-z
  - shut down the containers running in background
```
docker-compose down
```

### Topics
- environment variables are saved under `docker-compose.yml(docker-compose.example.yml)` and `config.template.yml`

