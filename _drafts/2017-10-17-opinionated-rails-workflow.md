---
title: Opinionated Rails Workflow
date: 2017-10-17T20:35:00+10:00
author: Martin Brennan
layout: post
permalink: /opinionated-rails-workflow/
---

I've been working with rails since April this year, and previously worked with Ruby and Grape before that. Coming into a new work environment with a new framework meant that I had to learn the rules all over again, and find a workflow that worked for me and fit in with the engineering practices of the company. I've now got a pretty repeatable workflow with Rails that I haven't changed in a while, and it's working pretty well for me, so I thought I'd get it out of my head and onto the page so to speak to help out others who may be in the same position, learning Rails.

## Discovery

Generally as a software engineer, you will be working with _requirements_. These can come from your clients or customers in the form of new features or bugfixes, as part of planned roadmap work, or sometimes formed internally as a part of refactoring efforts or infrastructure changes. I find the most important thing before you write a single line of code is to clarify these requirements so you don't go and develop something that is incomplete or buggy due to missed information. Worse, you can make something that ultimately doesn't suit your client's or customer's needs, prompting costly rewrites or changes.

To this end, when I start working on the next piece of work, I do the following, which may be obvious:

1. Read over the defined requirements (if any)
2. Write user [acceptance criteria](https://nomad8.com/acceptance_criteria/) for the requirements. This process involves coming up with different edge cases that the end-user may encounter, as well as the happy path that will make them satisfied in the feature or the fix
3. If necessary, look over any provided designs or wireframes, and make additional wireframes if the problem calls for it
4. Consult with coworkers or in some cases the client to extract all the detail I can before beginning
5. Determine if the ticket can be split up into multiple smaller tickets, to facilitate smaller code reviews for increased velocity. The faster new things can be put in front of your client, the better

Once I've done this, I find that I'm in a much better headspace to begin the changeset, and I can come up with a plan of attack for what parts of the codebase need to change and when. If I find more edge cases while I'm coding, I'll go back and add them to the original ticket. For you this may be a brief, specification, anything really. We just want other members of our team to see the requirements and user acceptance criteria when they go and review our code so they know what the change should do.

## Structure

* no logic in models or controllers
* facades -> services
* easier to test and SOLID

## Testing

* rspec & parallel rspec
* faker & factorygirl for seed data
* capybara for features
* TDD
* keyboard shortcuts for faster dev (run spec from line, open spec, etc)

## Rules

* sandi, rubocop, rubycritic