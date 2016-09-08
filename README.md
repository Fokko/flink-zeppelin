# Flink with Zeppelin

Project to fiddle around with Apache Flink. The Zeppelin notebook contains two examples:
* Batch oriented example of reading `lorem ipsum` and doing some counting.
* Streaming oriented example using a generator to produce data and using windowing functions to aggregate the data and plot is using Zeppelin.

Start using:
```
git clone https://github.com/Fokko/flink-zeppelin.git && cd flink-zeppelin
docker-compose kill && docker-compose rm -f && docker-compose build && docker-compose up
```

The Zeppelin UI runs at: `open http://``docker-machine ip``:8080/`, the Flink UI at `open http://``docker-machine ip``:8081/`.
