---
title: JSON schema
date: 2016-12-04
author: Martin Brennan
layout: post
permalink: /json-schema/
---

{% include deprecated.html message="Updated this article in 2025 with fresh information." cssclass="info" %}

When writing a common data transfer format, you will need a strong schema or specification so each client that uses that format knows how to parse, validate, and construct data using it. In XML you can use [XSD](https://en.wikipedia.org/wiki/XML_Schema_(W3C)), which is used to specify validation rules and elements expected in an XML file, as well as specifying the type of data expected (strings, integers, dates etc.). When using JSON, the best way to achieve this is with [JSON Schema](http://json-schema.org/), and I'll give a quick run through of how to use it and the things you can do with it in this article.

<!--more-->

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
    "caliber": 0.36
  }, {
    "make": "Smith & Wesson",
    "model": "Model 2 Army",
    "caliber": 0.32
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

## Complex Objects (Sub-Schema)

Say we wanted to make a sub-schema for the `pistols` array. Every pistol needs a make, model, and caliber. We can do this by defining another schema in the same file, and referencing it with the `items` property for the `array`. We will change it to look like this:

```json
{
  "pistols": {
    "type": "array",
    "description": "A list of pistols the gunslinger was known to use",
    "items": {
      "$ref": "#/definitions/pistol"
    }
  }
}
```

You can then make a `definitions` property in the main schema to hold all of the sub-schemas. It doesn't _have_ to be called `definitions`, it's just an easy way to keep all of these references grouped together. You can use the same rules as your main schema for your sub-schema:

```json
{
  "definitions": {
    "pistol": {
      "properties": {
        "make": {
          "type": "string"
        },
        "model": {
          "type": "string"
        },
        "caliber": {
          "type": "number",
          "minimum": 0,
          "maximum": 1,
          "exclusiveMinimum": true
        }
      }
    }
  }
}
```

I had some trouble with these references at first, until I realize I had misspelled the `$ref` path. Watch your spelling and case! (as always in programming, duh)

## Validation Libraries

From here, you will want a way to validate your **actual** JSON data against your schema. There is a library to do this in pretty much every language, here are some of the more popular ones:

- **C#** — [JsonSchema.Net (json-everything)](https://github.com/json-everything/json-everything) or [NJsonSchema](https://github.com/RicoSuter/NJsonSchema)  
- **JavaScript** — [Ajv](https://ajv.js.org/)  
- **Ruby** — [json_schemer](https://github.com/davishmcclurg/json_schemer)  
- **Python** — [jsonschema](https://github.com/python-jsonschema/jsonschema)  
- **Java** — [networknt/json-schema-validator](https://github.com/networknt/json-schema-validator)  
- **Go** — [santhosh-tekuri/jsonschema](https://github.com/santhosh-tekuri/jsonschema)  
- **PHP** — [opis/json-schema](https://github.com/opis/json-schema)  

For reference, here is an example implementation I wrote to run JSON validation against a schema using node.js, as a static tester for an established schema. This has been updated in 2025 to use `Ajv`:

```javascript
// validate.mjs
import { readFile } from "node:fs/promises";
import Ajv from "ajv";
import addFormats from "ajv-formats";
import yargs from "yargs/yargs";
import { hideBin } from "yargs/helpers";

const argv = yargs(hideBin(process.argv))
  .option("datafile", {
    alias: "d",
    type: "string",
    default: "datafile.json",
    describe: "Path to JSON data file",
  })
  .option("schema", {
    alias: "s",
    type: "string",
    default: "schema.json",
    describe: "Path to JSON schema file",
  })
  .strict()
  .help()
  .parse();

const ajv = new Ajv({ allErrors: true, strict: false });
addFormats(ajv); // enable "format" validations (email, uri, etc.)

function formatErrors(errors = []) {
  return errors
    .map((e) => {
      const path = e.instancePath || "/";
      const where = path === "" ? "/" : path;
      const schemaLoc = e.schemaPath ? ` (${e.schemaPath})` : "";
      return `- ${where}: ${e.message}${schemaLoc}`;
    })
    .join("\n");
}

async function main() {
  const [dataRaw, schemaRaw] = await Promise.all([
    readFile(argv.datafile, "utf8"),
    readFile(argv.schema, "utf8"),
  ]);

  const data = JSON.parse(dataRaw);
  const schema = JSON.parse(schemaRaw);

  const validate = ajv.compile(schema);
  const valid = validate(data);

  if (!valid) {
    console.error(
      `ERROR validating ${argv.datafile} against ${argv.schema}\n` +
        "--------------------------------------------------------\n" +
        formatErrors(validate.errors)
    );
    process.exitCode = 1;
    return;
  }

  console.log(`SUCCESS validating ${argv.datafile} against ${argv.schema}.`);
}

main().catch((err) => {
  console.error("Unexpected error:", err);
  process.exit(1);
});
```

## References

The JSON schema documentation is quite extensive and contains [miscellaneous examples](https://json-schema.org/learn/miscellaneous-examples). There is also the following main documentation:

- [JSON Schema Core Documentation](https://json-schema.org/draft/2020-12/json-schema-core)
- [JSON Schema Validation Documentation](https://json-schema.org/draft/2020-12/json-schema-validation)

I really recommend that you go and read over these, because there are _a lot_ of different validations you can perform on your JSON schema. There is also a great resource out there called [Understanding JSON Schema](https://json-schema.org/UnderstandingJSONSchema.pdf) that is useful in explaining areas where the documentation is a bit light.