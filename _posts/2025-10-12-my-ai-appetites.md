---
title: My AI appetites
date: 2025-10-12
author: Martin Brennan
layout: post
permalink: /my-ai-appetites/
---

I’d say my overall attitude to using AI for software engineering is still in the “cautious” phase (it gives me the ick when people say _bullish_ and _bearish_), but more and more I am integrating it into my day-to-day work and responsibilities at Discourse. 

In this article, I will go into some things that I am finding AI tooling useful for, and some areas where I wish it would improve, or that I am still finding my feet on. I will also cover how the prevalence of AI affects me as a tech lead and how it impacts our workflows on a product development team. So we are on the same page, I spent most of my time writing Ruby, Rails, JavaScript, Ember, and SQL code.

<!--more-->

* Table of contents
{:toc}

### AI editor integration

I use neovim as my main editor (I plan to write an article on my 2025 development setup soon), and I still haven't really found an AI plugin that I like using regularly here. For a while I used [copilot.vim](https://github.com/github/copilot.vim), but it never felt _good_ to use, there always felt like a bit of friction. Ideally I want something that can quickly operate on visual selections for minor refactors, or across multiple buffers using `fzf` for selecting file paths. I want to smoothly accept or reject AI suggested edits and refactors. I want to connect it to Claude, not being limited by model choice. I want to be able to ask it questions and search docs from within the code quickly, which is what I currently use ChatGPT for. Overall I am looking for better _integration_ rather than some cobbled together plugin.

I have been experimenting a little with [zed](https://zed.dev/). It feels like a super smooth and performant editor, with an excellent UI and AI integrations. I think it will only get better over time -- hell at the time of writing this article it's already got more features than it did a month ago. I've partially set it up with the same configuration as my nvim setup, but I haven't had enough time to truly migrate everything. It's hard to juggle this and my day-to-day responsibilities -- maybe a project for the quieter Christmas period, this is when I migrated from vim to neovim earlier this year (or was it last year? 😵‍💫). The AI features here feel like what I want for neovim. I need more time to evaluate this, but I can see myself moving over to zed from neovim if I can replicate at least the important parts of my workflow and not get too tripped up by missing features or janky UX.

Of course I use GitHub Copilot for autocompletion. That is really helpful and a lot of the time if you have the right files open in buffers in neovim it's extraordinarily good at guessing what you want, especially when writing repetitive code like specs, or refactoring an existing file. I even use it in git commit message buffers occasionally, to varying degrees of success. Maybe ~60% of the time it's helpful there.  I like that you can direct it with comments.

However there are times where I feel like it gets in the way of my thought process -- I find it difficult to ignore the suggestions and they can be distracting. Thankfully `:Copilot disable` is always on hand to get it to go away. So TL;DR...for novel and creative work it can be distracting and not all that useful, but for ROTE work and refactoring it's great.

### Web-based AI tooling

It feels as though ChatGPT is by far my most used AI tool, and I still reach for the web-based chat interface frequently. For me ChatGPT offers the least friction, I can jump to the chat page and send it any request and get an answer back quickly (well...sometimes not so quickly when it's "thinking"). It feels like I can ask it absolutely anything, and I don't have the weird anxiety of seeing tokens ticking up inexorably (I know the tokens are still being used in the background...but I don't want to see this).

I use it for a lot of different things. It excels at explaining concepts and code in simple terms, especially because you can ask it questions and clarifications until it explains things in the way that helps you understand. I use it often to explain how things work in ruby, rails, SQL, or Ember, and most of the time it's fairly accurate (though its Ember knowledge can be quite outdated, I trust that the least). It's excellent for writing little onceoff scripts that only I am ever going to use, especially in languages like bash where I know a little but not enough to write a full script, or I don't want to spend a bunch of time doing something that AI can do in seconds.

Another thing I use it often for is for converting documents or data into different formats, for example generating a markdown table from a JSON list. It's good at generating example data, and for generating names of things, or suggesting variations on a word when you are stuck on what to call something, which is a problem in both writing and programming.

A few examples of different things I've asked it to help with recently:

* Updating a bash script I have for running Discourse specs to take into account symlinks to plugins
* Writing a recursive Ember component (i.e. one that calls itself inside itself)
* How to auto-reload [hyprpapr](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/) config
* Helping me convert my neovim LSP config to the new `vim.lsp.config` format
* Converting [LuaSnip](https://github.com/L3MON4D3/LuaSnip) snippets into the JSON format needed for zed

I used it [heavily to clean up this blog](/cleaning-up-this-blog-with-ai) and I don't see my usage slowing down much anytime soon, at least until I have a nice neovim integration for the coding-related questions and jobs that I give it.

At Discourse we have several web-based AI tools built into the product. I think the killer feature here is our [AI-based spam detection tooling](https://meta.discourse.org/t/discourse-ai-spam-detection/343541), which I don't really need to use in my day-to-day, but I know it helps our moderators a lot. Our search and related topic enhancements are the things I use the most -- it is quite difficult to make a normal `tsvector`-based search that works reliably for all queries, and AI is a great enhancement here, and since it is excellent and finding patterns and relations between things, the recommendations it gives for similar topics are quite accurate.

We also have [Ask Discourse](https://ask.discourse.com/) using AI helpers which can also be used on any Discourse site, and I find this useful from time to time to ask questions about certain parts of the Discourse software that I am unfamiliar or for help with configuration, though like any AI tool things like this are only as good as the backing documentation.

Overall the web-based AI tooling I use the least is summarisation. I feel like I have to be too on-guard for incorrect information or inconsistencies in the summaries, and so I do not trust them. AI is still too prone to hallucination and making up links to things that don't make sense or don't exist. I am a fast reader anyway, and most of the time I would much prefer to read the source material on my own and understand the original text.

I also do not use AI for writing. Writing is thinking, and writing is a creative process for me. I value my own voice, and I do not want AI's milquetoast voice to override my own. This is not something I need in my life.

### Agentic AI

Claude code is by far my most heavily used tool here. I haven't tried OpenAI Codex yet, but I suppose I should at some point. At Discourse, we use Claude backed by Amazon Bedrock, so individual engineers don't really need to worry about token use or costs. Generally I use Claude for bugfixes and explanations of existing code, sometimes refactoring but sometimes that feels “wasteful” or overkill for very small refactors. This is where I would like a better neovim system to perform a refactor on a selection of lines. 

Claude is extremely useful for "grunt" work. For example, we have [admin UI guidelines and classes](https://meta.discourse.org/t/creating-consistent-admin-interfaces/326780?tl=en) and so on for tables at discourse. I made a Glimmer component with a basic HTML table while experimenting, then I could tell Claude to look at existing examples from other Glimmer components in our admin UI and give it a link to the Meta docs to reference so Claude can read them. Claude can then go and inspect these resources and bully the table into shape, it worked extremely well for this.

MCP in Claude can be very useful. We have a [Discourse MCP](https://github.com/discourse/discourse-mcp) which can be used to create various resources or to search, read topics, or list users and so on. This can be extremely helpful in local engineering development where you need to create a lot of records fast with natural language. There is a [Playwright MCP](https://github.com/microsoft/playwright-mcp) from Microsoft that can be used to control the browser in cases where you need Claude to debug web-based JS errors, logs, or network requests, though I did notice that this seems to use a _ton_ of tokens. Another MCP that is useful as an engineer is the [PostgreSQL MCP](https://github.com/crystaldba/postgres-mcp) which allows Claude to inspect the state of a database, though I haven't used this one much just yet.

What I haven't had a lot of experience with yet, and the tooling I am most skeptical of, is the "unsupervised" agentic AI where you give it a prompt and free reign to use whatever tooling it wants in a loop, then come back _a few hours later_ to a fully realised changeset. I am only getting a start in this area, so I don't have too much to comment on, but the results I have gotten so far from [Jules](https://jules.google/) have been underwhelming to say the least. Also, I struggle to find things that I would _want_ AI to go off and do itself outside of small bugfixes and chore maintenance work like version bumps. If it's something more in-depth or creative, I would rather do it myself, since I enjoy that part of software engineering.

I know there are also tools like [OpenAI Codex](https://openai.com/codex/) and the [GitHub CoPilot agent](https://docs.github.com/en/enterprise-cloud@latest/copilot/concepts/agents/coding-agent/about-coding-agent) that fit into this niche of AI tooling, so I want to find some opportunities to try these out and see what kind of result I can get.

### Code review

I do a lot of code reviews in my role as tech lead for my own product team, but also general reviews for other engineers and designers at Discourse. By far I think this is the place where AI has had the most impact, in that AI-generated PRs push a lot of work onto the reviewer, rather than front-loading it onto the individual doing the work. I find this similar to editing someone else’s writing, in that it feels like you are not getting the full picture, and you need to try and reconstruct what the other person was thinking in your own mind to review their work.

This is not really possible with AI generated work though...because although AI tools say “Thinking…” now, they are not really. That dimension is missing. AI tools live in a temporary existence without a history or learned lessons that a human has built up over the years. There is no-one behind the end product to relate to, no-one to trust. AI doesn't care about whatever poor sod is going to be responsible for reading or maintaining its output. AI tools produce a lot of output, but rarely remove or self-edit their output, so the end result is that these tools make it very easy to make a huge volume of generated code or writing (also known as _slop_) without much thought.

Even when it’s generating code that I requested, I still find reviewing AI-generated code much more time consuming and effortful to review than something generated by myself or another person. It feels like you always need to remind it of the same things, and even when you do it tries to be lazy or forgets what you told it partway through. A commenter on Hacker News put this quite nicely:

> When it comes to agentically generated code every review feels like interacting with a brand new coworker and need to be vigilant about sneaky stuff

The caveat here is that I don't think there is anything inherently _wrong_ with using AI to assist you in writing your PRs, as I've covered earlier they are valuable tools that can be integrated in various ways into daily engineering work. What _is_ wrong is generating a PR completely with AI and lobbing it over the fence, making it someone else's problem, especially without communicating that the work was done solely by AI.

It is still critically important that engineers using AI tooling and expecting colleagues to review it do the following:

* Understand the output of the tooling and stand behind it. No hiding behind "Oh claude did this, I don't get it but it's fine, let's merge".
* Ensure everything is thoroughly tested with both automated and manual testing.
* Make sure telltale signs of AI use are removed, like excessive comments.
* Ensure the code matches the coding style of the rest of the codebase, and any linting rules and UI guidelines that may be defined.
* Recognize that the reviewer needs more context for this work, so add extra PR comments and a great PR description (one generated by AI doesn't count) that covers the _why_ and not only the _what_ to help with review.
* Anticipate more comments than usual from the reviewer, and be ready to respond to them with an open mind.

Even before AI, PR etiquette was sometimes lacking between engineers. We all need to remember that the sole goal of software engineering is not the code output -- we all work with other humans that must understand and support our code, and see the history and context behind our decisions, even when we are not around. Code review is supposed to be a back and forth where we learn from one another and make the end result better, not just a chore in the way of steamrolling new code into production.

Maybe over time AI generated code will become easier to review (maybe even with AI-assisted review tools, which seem to be lacking right now), but that remains to be seen. There is still no substitute for a considered PR description and an attentive contributor.

### Daily impact

Generally my daily work is broken down into a few categories:

* Reviewing code
* Investigating bugs and fixing them
* Writing creative or novel code to solve a business problem
* Reading and writing product specs and TODOs
* Communicating with my colleagues

Out of all these AI has had the most impact on reviewing code (which I cover above) and investigating and fixing bugs. So far the things that AI has helped with the most are clarifications, grunt work, helping with tools or languages I don’t work with often, and so on. I don’t want to have to remember the options of `sed` or all the different syntax for writing once-off bash scripts. AI can be great to help you identify a tricky bug, or to do things like write out specs that do not exist or will aid in the identification of a bug. AI is great at recognizing patterns and inconsistencies in those patterns, or missing or invalid data, which are common sources of bugs.

As I've already covered I won't use it for writing, as writing is thinking, in the same way that programming is thinking. It is very hard to know if you've ended up at the right place if you never were a participant on the journey that took you there. So much of any deep or creative work is going down dead ends and eliminating things that don’t work, rather than only doing the thing that does work right from the get-go. Especially in an async work environment like Discourse where communication is paramount, you need to think about what you are trying to get across to your colleagues. If you can't be bothered to write something yourself, or solve a problem with code yourself, why should anybody else be bothered to read it?

In the case of other creative or novel work, it doesn't really feel satisfying in the slightest to use AI to completely do something for me. The only times where it feels _okay_ to use completely are in the rare cases where it was something I really didn't want to do or felt very painful to do, or something I didn't feel was particularly worthwhile to spend my time on. For things I do want to spend my time on that I find fun or interesting, I don’t know why I would ever give that over to AI.

Another use of AI that impacts our whole team is the use of AI to generate UI prototypes and rough demos and implementations of features. AI is able to generate something reasonable-looking that at first glance may look impressive or appear to solve the problem on the surface, but under scrutiny can fall apart. This AI output isn't well-considered in the same way that it would be if an actual designer, product manager, or engineer worked on the concept with their own skill and experience, and it removes some capacity for independent learning and growth.

As long as we are clear and treat these kind of demos and prototypes as just that -- a proof of concept that is entirely disposable -- this will not become too much of a problem. But it is _mighty_ tempting to see something 75% of the way there and think that the last 25% is easy to finish, or in any way the same as a human doing the first 75%.

### Conclusion

AI is a tool that has the potential to be terribly misused by the wielder, but that does not make it a bad tool per se. I don't believe the greater hype bubble around AI or that we are going to get something like AGI anytime soon, but over the past year or two it has become an indispensable tool in my day-to-day work as a staff engineer and tech lead. We all need to _tread lightly_ when using AI, and not forget the human factor in our work.

Some recent articles on the subject that I've found interesting:

* <https://hojberg.xyz/the-programmer-identity-crisis/> 
* <https://simonwillison.net/2025/Oct/5/parallel-coding-agents/>
* <https://simonwillison.net/2025/Oct/7/vibe-engineering/>
* <https://hbr.org/2025/09/ai-generated-workslop-is-destroying-productivity>
* <https://www.itsnicethat.com/features/the-productivity-paradox-light-and-shade-digital-220925>

Title reference: The art critic Jerry Saltz wrote this article in 2020 about his life, career, and habits and I find it strangely compelling <https://www.vulture.com/2020/05/jerry-saltz-my-appetites.html>
