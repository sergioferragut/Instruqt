---
slug: druid-query-api
id: bsxgzoygy1mh
type: challenge
title: Druid Queries Using the Broker API
teaser: Perform queries using the Broker API
notes:
- type: video
  url: ../assets/03-splash.mp4
tabs:
- title: Shell
  type: terminal
  hostname: single-server
- title: Editor
  type: code
  hostname: single-server
  path: /root
difficulty: basic
timelimit: 600
---
You may want to perform Druid queries using an API.
In this challenge, we'll use the API to perform the same query we used in the previous challenge.


You may remember the query from the previous challenge that looks at Wikipedia update activity by users.

<h2 style="color:cyan">Step 1</h2><hr style="color:cyan;background-color:cyan;height:2px">

Here's the query formatted as JSON.

```
{
  "query":
  "SELECT __time, \"user\", page, added, deleted
    FROM wikipedia
    WHERE (TIMESTAMP '2016-06-27' <= __time
      AND
      __time < TIMESTAMP '2016-06-28')
    LIMIT 5"
}
```

Although the JSON specification does not allow line breaks within strings, the cURL command will remove the new-lines for us.
Notice how we escaped the double-quotes around _user_ using the backslash character.
Also, when using the API, we don't use the semicolon at the end of the query, like we did with the Druid client.

<h2 style="color:cyan">Step 2</h2><hr style="color:cyan;background-color:cyan;height:2px">

Open the file named _query-wiki-activity.json_, paste the query and save the file.

<a href="#img-2">
  <img alt="Build activity by user query" src="../assets/BuildActivityByUserQuery.png" />
</a>

<a href="#" class="lightbox" id="img-2">
  <img alt="Build activity by user query" src="../assets/BuildActivityByUserQuery.png" />
</a>

<h2 style="color:cyan">Step 3</h2><hr style="color:cyan;background-color:cyan;height:2px">

Back in the Shell, let's execute the query by submitting it to the API.

```
curl -X 'POST' -H 'Content-Type:application/json' -d @/root/query-wiki-activity.json http://localhost:8888/druid/v2/sql | jq
```

The cURL command sends the query to the Broker process with the following options.
- _-X 'POST'_ causes an HTTP POST operation
- _-H 'Content-Type:application/json'_ indicates the payload is JSON
- _-d @/root/query-wiki-activity.json_ specifies the payload file; Notice the _@_ which removes the line breaks from the file
- _http://localhost:8888/druid/v2/sql_ is the URL of the Broker process
- _| jq_ pipes the output from the query into _jq_, which formats the output

That's all there is to it!

<h2 style="color:cyan">Great! Accessing Druid via the API makes integrations easy!</h2>

<style type="text/css" rel="stylesheet">
.lightbox { display: none; position: fixed; justify-content: center; align-items: center; z-index: 999; top: 0; left: 0; right: 0; bottom: 0; padding: 1rem; background: rgba(0, 0, 0, 0.8); }
.lightbox:target { display: flex; }
.lightbox img { max-height: 100% }
.thumbnail:hover {
    position:fixed;
    top:-25px;
    left:-35px;
    width:500px;
    height:auto;
    display:block;
    z-index:999;
}
</style>
