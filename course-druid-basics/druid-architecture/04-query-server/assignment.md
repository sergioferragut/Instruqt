---
slug: query-server
id: ulra3yw8yidt
type: challenge
title: Set Up the Query Server
teaser: Learn how to deploy the query server
notes:
- type: video
  url: ../assets/04splash.mp4
tabs:
- title: Query-shell
  type: terminal
  hostname: query-server
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
In this challenge we will deploy the query server named _query-server_.


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

Here are the commands you can use to see what changes we will be making to (four) different files.

<h2 style="color:cyan">Step 3</h2><hr style="color:cyan;background-color:cyan;height:2px">

We will change the broker's configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/broker/runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/query/broker/runtime.properties
```

Here, we limit the resources used by the broker.
Learn more [here](https://druid.apache.org/docs/latest/configuration/index.html#broker).

<h2 style="color:cyan">Step 4</h2><hr style="color:cyan;background-color:cyan;height:2px">

We will change the broker's JVM configuration too.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/broker/jvm.config /root/apache-druid-25.0.0/conf/druid/cluster/query/broker/jvm.config
```

Again, we shrink the JVM heap size and change the garbage collection algorithm.

<h2 style="color:cyan">Step 5</h2><hr style="color:cyan;background-color:cyan;height:2px">

Here are the changes to the router configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/router/runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/query/router/runtime.properties
```

One more time, we limit the resources consumed by the router.
Learn more [here](https://druid.apache.org/docs/latest/configuration/index.html#router).

<h2 style="color:cyan">Step 6</h2><hr style="color:cyan;background-color:cyan;height:2px">

Here are the changes to the router's JVM configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/router/jvm.config /root/apache-druid-25.0.0/conf/druid/cluster/query/router/jvm.config
```

And finally, we reduce the heap size of the router.

<h2 style="color:cyan">Step 7</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's copy the Broker files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/broker/* /root/apache-druid-25.0.0/conf/druid/cluster/query/broker
```

<h2 style="color:cyan">Step 8</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's copy the Router files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/router/* /root/apache-druid-25.0.0/conf/druid/cluster/query/router
```

<h2 style="color:cyan">Step 9</h2><hr style="color:cyan;background-color:cyan;height:2px">

One last time, let's copy the _common.runtime.properties_ file we edited in the first challenge so that the server knows how to contact ZooKeeper.

```
scp -o StrictHostKeyChecking=no master-server:/root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties
```

<h2 style="color:cyan">Step 10</h2><hr style="color:cyan;background-color:cyan;height:2px">

Now, we can launch the query server.
Again, we'll use _nohup_ so that the processes continue to run when we move to the next challenge.

```
nohup /root/apache-druid-25.0.0/bin/start-cluster-query-server > /root/apache-druid-25.0.0/log.out 2> /root/apache-druid-25.0.0/log.err < /dev/null & disown
```

<h2 style="color:cyan">Step 11</h2><hr style="color:cyan;background-color:cyan;height:2px">

Check that the broker and router processes are running.

```
ps -ef | grep "openjdk\-[8-8]" | awk 'NF{print $NF}'
```

<h2 style="color:cyan">Step 12</h2><hr style="color:cyan;background-color:cyan;height:2px">

You can find the log files for these processes here:

```
tail /root/apache-druid-25.0.0/log/broker.log
```

and here:

```
tail /root/apache-druid-25.0.0/log/router.log
```

<h2 style="color:cyan">Wonderful! You have deployed the query server.</h2>
