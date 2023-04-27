---
slug: data-server-1
id: lntr8dpyyjxo
type: challenge
title: Set Up the First Data Server
teaser: Learn how to deploy the first of two data servers
notes:
- type: video
  url: ../assets/02splash.mp4
tabs:
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
In this challenge we will deploy the first of two data servers named _data-server-1_.


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

Again, we will be working with servers that are smaller than you would use in production.
We need to restrict the amount of memory the various processes use.
So, to cut back on memory usage, we will use the same configuration files we used in the single server quickstart example.

Following are the commands you can use to see what changes we will be making to (four) different files.

<h2 style="color:cyan">Step 3</h2><hr style="color:cyan;background-color:cyan;height:2px">

Here the changes we will make to the Druid historical configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/historical/runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/data/historical/runtime.properties
```

The results of this command show that we are reducing resources such as number of threads for servicing HTTP requests and general processing, buffer sizes and cache sizes.
Learn more [here](https://druid.apache.org/docs/latest/configuration/index.html#historical).

<h2 style="color:cyan">Step 4</h2><hr style="color:cyan;background-color:cyan;height:2px">

Next, review the changes to the historical's JVM.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/historical/jvm.config /root/apache-druid-25.0.0/conf/druid/cluster/data/historical/jvm.config
```

The results here show the changes in the historical JVM options to reduce the heap size, the direct memory mapping size and also changing the garbage collection algorithm.

<h2 style="color:cyan">Step 5</h2><hr style="color:cyan;background-color:cyan;height:2px">

Review the changes to the middle manager's configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/middleManager/runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/data/middleManager/runtime.properties
```

We reduce many resources used by the middle manager.
Learn more [here](https://druid.apache.org/docs/latest/configuration/index.html#middlemanager-configuration).

<h2 style="color:cyan">Step 6</h2><hr style="color:cyan;background-color:cyan;height:2px">

Finally, review the changes to the middle manager's JVM configuration.

```
diff /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/middleManager/jvm.config /root/apache-druid-25.0.0/conf/druid/cluster/data/middleManager/jvm.config
```

Similar to the historical process, we see we are reducing the middle manager's JVM heap size and garbage collection algorithm.

<h2 style="color:cyan">Step 7</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's copy the historical files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/historical/* /root/apache-druid-25.0.0/conf/druid/cluster/data/historical
```

<h2 style="color:cyan">Step 8</h2><hr style="color:cyan;background-color:cyan;height:2px">

Let's also copy the middle manager files into our cluster configuration.

```
cp /root/apache-druid-25.0.0/conf/druid/single-server/nano-quickstart/middleManager/* /root/apache-druid-25.0.0/conf/druid/cluster/data/middleManager
```

<h2 style="color:cyan">Step 9</h2><hr style="color:cyan;background-color:cyan;height:2px">

Now, let's copy the _common.runtime.properties_ file we edited in the first challenge to this server.
Remember, this file tells the server how to contact ZooKeeper.

```
scp -o StrictHostKeyChecking=no master-server:/root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties /root/apache-druid-25.0.0/conf/druid/cluster/_common/common.runtime.properties
```

<h2 style="color:cyan">Step 10</h2><hr style="color:cyan;background-color:cyan;height:2px">

We are set to launch the first data server.
Again, we'll use _nohup_ so that the processes continue to run when we move to the next challenge.

```
nohup /root/apache-druid-25.0.0/bin/start-cluster-data-server > /root/apache-druid-25.0.0/log.out 2> /root/apache-druid-25.0.0/log.err < /dev/null & disown
```

<h2 style="color:cyan">Step 11</h2><hr style="color:cyan;background-color:cyan;height:2px">

Check that the historical and middleManager processes are running.

```
ps -ef | grep "openjdk\-[8-8]" | awk 'NF{print $NF}'
```

<h2 style="color:cyan">Step 12</h2><hr style="color:cyan;background-color:cyan;height:2px">

You can find the log files for these processes here:

```
tail /root/apache-druid-25.0.0/log/historical.log
```

and here:

```
tail /root/apache-druid-25.0.0/log/middleManager.log
```

<h2 style="color:cyan">Cool! You have deployed the first data server.</h2>
