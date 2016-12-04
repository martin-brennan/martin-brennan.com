---
title: JSON Schema
date: 2016-10-23T08:30:00+10:00
author: Martin Brennan
layout: post
permalink: /json-schema/
---

When writing a common data transfer format, you will need a strong schema or specification so each client that uses that format knows how to parse, validate, and construct data using it. In XML you can use [XSD](https://en.wikipedia.org/wiki/XML_Schema_(W3C)), which is used to specify validation rules and elements expected in an XML file, as well as specifying the type of data expected (strings, integers, dates etc.). When using JSON, the best way to achieve this is with [JSON Schema](http://json-schema.org/), and I'll give a quick run through of how to use it and the things you can do with it in this article.

<!-- more -->

First of all we will start with the structure of the data we are expecting via JSON. We have numbers, strings, datetimes, and even complex objects.

```json
{
  "id": 1,
  "firstName": "James",
  "lastName": "Hickock",
  "dob": "1837-05-27T00:00:00Z",
  "pistols": [{
    "make": "Colt",
    "model": "1851 Navy",
    "caliber": ".36"
  }, {
    "make": "Smith & Wesson",
    "model": "Model 2 Army",
    "caliber": ".32"
  }]
}
```

To begin, we need to define the most basic properties of the schema, which itself is in JSON format. We will define the `$schema`, which is like the schema definition in an XSD file. We define a basic title and description for the schema and the `type` which is like a language type.

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "Old West Folk Heroes",
  "description": "A hero of the Old West",
  "type": "object"
}
```

From here, we want to make sure that the `id`, `firstName`, `lastName`, and `dob` are all filled in and the correct type. We use the `properties` key for this in the JSON schema. We also want to make all of the fields `required`. Note that the `description` for each property is optional. Add this onto the above JSON.

```json
{
  "properties": {
    "id": {
      "type": "integer"
    },
    "firstName": {
      "description": "The first name of the hero",
      "type": "string"
    },
    "lastName": {
      "description": "The last name of the hero",
      "type": "string"
    },
    "dob": {
      "description": "The estimated date of birth",
      "type": "string",
      "format": "date-time"
    },
    "pistols": {
      "type": "array",
      "description": "A list of pistols the gunslinger was known to use"
    }
  },
  "required": ["id", "firstName", "lastName", "dob"]
}
```

## Validation Libraries
