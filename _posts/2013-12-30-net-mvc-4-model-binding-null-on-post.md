---
id: 398
title: .NET MVC 4 model binding null on POST
date: 2013-12-30T17:26:44+10:00
author: Martin Brennan
layout: post
permalink: /net-mvc-4-model-binding-null-on-post/
exclude_from_feed: true
iconcategory:
  - aha
dsq_thread_id:
  - 2081204107
categories:
  - Aha!
  - Development
---


{% include deprecated.html message="This article is more than a decade old, it is no longer relevant in 2025." cssclass="danger" %}

This was an extremely frustrating problem I came across when building an API using .NET MVC 4. I was using HTTP POST to send a model to the API using JSON, and relying on the built in Model-binding to correctly interpret the JSON and convert it to a model. However, for one particular model none of the properties were binding correctly. After a lot of head scratching and threatening my computer screen, I found this post by Anders Åberg<!--more-->:

[.NET MVC 4 Model Binding null on POST](http://ideasof.andersaberg.com/idea/9/net-mvc-4-model-binding-null-on-post)

Basically, take this model for an example of how the problem occurs. This represents a message in some sort of chat system:

```csharp
public class ChatMessage
{
    public int ID { get; set; }
    public string Message { get; set; }
    public bool Read { get; set; }
}
```

And your API for example has a Controller method that accepts a HTTP POST request to add a new message:

```csharp
[HttpPost]
public ActionResult Send( ChatMessage message)
{
    var id = Chat.Send(message);
    return Content(id);
}
```

And then the JSON POST body would look something like this:

```json
{
  "ID": null,
  "Message": "Hey how's it going?",
  "Read": false
}
```

{% include in-post-ad.html %}

You would expect that the model would be bound correctly and that all the properties would be filled in correctly right? Right?! WRONG! Because I’ve named the parameter for the `Send` method the same thing as one of the model’s properties, `Message`. This really confuses the model binder because it’s trying to just use the message **property** and binding it to the **model**, instead of just counting as a property of the model.

There are two things you can do to get around this:

  1. Don’t name any of your method parameters the same thing as any of your model’s properties! E.g. newMessage instead of message.
  2. Don’t name your model properties anything similar to the name of the model class, as you may want to use it as a variable name. E.g. MessageText instead of Message.
