---
id: 499
title: DocuSign connect XML schema
date: 2014-08-31T19:15:06+10:00
author: Martin Brennan
layout: post
permalink: /docusign-connect-xml-schema/
dsq_thread_id:
  - 2974578894
categories:
  - Development
tags:
  - Connect
  - DocuSign
  - XML
  - XSD
---

{% include deprecated.html message="In 2025, this article is likely out of date. The XSD link still works, but I am not sure if this is the best way to call the DocuSign API any more." cssclass="danger" %}

For those of you that have developed for the [DocuSign E-Signature platform](https://www.docusign.com), you'll have probably used their DocuSign Connect service to listen for document and recipient events so you don't have to long-poll their servers, which they strongly discourage. The example XML in their [DocuSign Connect Service Guide](https://www.docusign.com/sites/default/files/DocuSign_Connect_Service_Guide.pdf) frustratingly does not have all of the possible values and fields that could come through with each request.

I decided to investigate this and came upon [this StackOverflow Q&A](http://stackoverflow.com/questions/24653205/connect-docusign-xsd "StackOverflow") that had a handy answer, which linked to the complete DocuSign Connect XML Schema as an XSD. You can find the XSD below:

[DocuSign Connect XML Schema (XSD)](https://www.docusign.net/api/3.0/schema/dsx.xsd)