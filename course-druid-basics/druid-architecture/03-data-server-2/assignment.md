---
slug: data-server-2
id: 7iplczcca6k1
type: challenge
title: Set Up the Second Data Server
teaser: Learn how to deploy the second of two data servers
notes:
- type: video
  url: ../assets/03splash.mp4
tabs:
- title: Data-2-shell
  type: terminal
  hostname: data-server-2
- title: Data-1-shell
  type: terminal
  hostname: data-server-1
- title: Master-shell
  type: terminal
  hostname: master-server
- title: Master-editor
  type: code
  hostname: master-server
  path: /root
difficulty: basic
timelimit: 600
---
In this challenge we will deploy the second of two data servers named _data-server-2_.
This server works just like data-server-1.

By adding more data servers, we not only increase the amount of storage, but we also bring more CPU to bare for query processing.

<h2 style="color:cyan">Step 1</h2><hr style="color:cyan;background-color:cyan;height:2px">

Download the Druid distribution.

```
wget https://dlcdn.apache.org/druid/25.0.0/apache-druid-25.0.0-bin.tar.gz
```

<h2 style="color:cyan">Step 2</h2><hr style="color:cyan;background-color:cyan;height:2px">

Unzip the downloaded file.

```
tar -xzf apache-druid-25.0.0-bin.tar.gz
```

<h2 style="color:cyan">Step 3</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's copy the historical files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/historical/* /root/apache-druid-25.0.0/conf/druid/cluster/data/historical
```

<h2 style="color:cyan">Step 4</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's also copy the middle manager files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/middleManager/* /root/apache-druid-25.0.0/conf/druid/cluster/data/middleManager
```

<h2 style="color:cyan">Step 5</h2><hr style="color:cyan;background-color:cyan;height:2px">

Again, let's copy the _common.runtime.properties_ file we edited in the first challenge so that the server knows how to contact ZooKeeper.

```
scp -o StrictHostKeyChecking=no master-server:/root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties
```

<h2 style="color:cyan">Step 6</h2><hr style="color:cyan;background-color:cyan;height:2px">

Now, we can launch the second data server.
Again, we'll use _nohup_ so that the processes continue to run when we move to the next challenge.

```
nohup /root/apache-druid-25.0.0/bin/start-cluster-data-server > /root/apache-druid-25.0.0/log.out 2> /root/apache-druid-25.0.0/log.err < /dev/null & disown
```

<h2 style="color:cyan">Step 7</h2><hr style="color:cyan;background-color:cyan;height:2px">

Check that the historical and middleManager processes are running.

```
ps -ef | grep "openjdk\-[8-8]" | awk 'NF{print $NF}'
```

<h2 style="color:cyan">Outstanding! You have deployed the second data server.</h2>
