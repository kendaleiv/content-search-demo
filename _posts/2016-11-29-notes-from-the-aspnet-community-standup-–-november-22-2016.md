---
layout: post
site: MSDN blog
title: Notes from the ASPNET Community Standup – November 22 2016
date: 2016-11-29
description: This is the next in a series of blog posts that will cover the topics discussed in the ASP.NET Community Standup. The community standup is a short video-based discussion with some of the leaders of the ASP.NET development teams covering the accomplishments of the team on the new ASP.NET Core framework over the previous week....
tags: 
- Uncategorized
- CommunityStandup
authors: Maria Naggaga
categories: 
- Uncategorized
- CommunityStandup
---

This is the next in a series of blog posts that will cover the topics discussed in the ASP.NET Community Standup. The community standup is a short video-based discussion with some of the leaders of the ASP.NET development teams covering the accomplishments of the team on the new ASP.NET Core framework over the previous week. Join [Scott Hanselman](https://twitter.com/shanselman), [Damian Edwards](https://twitter.com/damianedwards), [Jon Galloway](https://twitter.com/jongalloway) and an occasional guest or two discuss new features and ask for feedback on important decisions being made by the ASP.NET development teams.

This week the team hosted the standup on [Aerial Spaces](https://twitter.com/useAerial/status/801263711021318144).  Every week’s episode is published on YouTube for later reference. The team answers your questions LIVE and unfiltered. This is your chance to ask about the why and what of ASP.NET! Join them each Tuesday on live.asp.net where the meeting’s schedule is posted and hosted.

<span id="more-8255"></span>

**ASP.NET Community Standup 11/22/2016**

<iframe width="760" height="515" allowfullscreen="allowfullscreen" frameborder="0" src="https://www.youtube.com/embed/ImFTzxmCPkc?list=PL0M0zPgJ3HSftTAAHttA3JQU4vOjXFquF"></iframe>

## Community Links

[Announcing the Fastest ASP.NET Yet, ASP.NET Core 1.1 RTM](https://blogs.msdn.microsoft.com/webdev/2016/11/16/announcing-asp-net-core-1-1/)

[Announcing .NET Core 1.1](https://blogs.msdn.microsoft.com/dotnet/2016/11/16/announcing-net-core-1-1/#user-content-performance)

[App Service on Linux now supports Containers and ASP.NET Core](https://azure.microsoft.com/en-us/blog/app-service-on-linux-now-supports-containers-and-asp-net-core/)

[ASP.NET Core Framework Benchmarks Round 13](https://www.techempower.com/blog/2016/11/16/framework-benchmarks-round-13/)

[MVP Hackathon 2016: Cool Projects from Microsoft MVPs](https://blogs.msdn.microsoft.com/webdev/2016/11/22/mvp-hackathon-2016/)

[Damian Edwards live coding live.asp.net](https://www.youtube.com/watch?v=oHOB1QjqbGg)

[EDI.Net Serializer/Deserializer](https://github.com/indice-co/EDI.Net)

[ASP.NET Core’s URL Rewrite Middleware behind a load balancer](http://blog.treeloop.com/asp-net-core-url-rewrite-module-behind-load-balancer/)

[ASP.NET Core  Workshops and Code Labs](https://channel9.msdn.com/Series/aspnetmonsters/ASPNET-Monsters-79-Code-Labs-with-Jon-Galloway)

[Unexpected Behavior in LanguageViewLocationExpander](http://www.hishambinateya.com/unexpected-behavior-in-languageviewlocationexpander)

[Project.json to CSproj](https://www.stevejgordon.co.uk/project-json-replaced-by-csproj)

[OrchardCMS Roadmap](https://github.com/OrchardCMS/Orchard2/wiki/Roadmap)

[ASP.NET Core and the Enterprise Part 3: Middleware](http://odetocode.com/blogs/scott/archive/2016/11/22/asp-net-core-and-the-enterprise-part-3-middleware.aspx)

[Using .NET Core Configuration with legacy projects](http://benfoster.io/blog/net-core-configuration-legacy-projects)

[High-Performance Data Pipelines](https://github.com/dotnet/corefxlab/blob/master/docs/roadmap.md)

[.NET Core versioning](https://blogs.infosupport.com/net-core-versioning/)

[Not your granddad’s .NET – Pipes Part 1](https://cetus.io/tim/Part-1-Not-your-grandads-dotnet/)

## Accomplishments

#### Tech Empower Benchmark

Tech Empower Benchmark Round 13 came out and ASP.NET Core is Top 10 receiving  1,822,366 requests per second on ASP.NET Core in Round 13.  [Read more](https://www.techempower.com/blog/2016/11/16/framework-benchmarks-round-13/)

[![capture](https://msdnshared.blob.core.windows.net/media/2016/11/Capture28.png)](https://msdnshared.blob.core.windows.net/media/2016/11/Capture28.png)

#### Question and Answers

**Question:**  Will there be MVC 4 project support in Visual Studio 2017?

— Removed in RC but should be coming back in the next release.

**Question:** What should I grab ASP.NET Core 1.1 runtime or SDK? / What’s the difference between the .NET Core SDK and runtime?

— In short, if you a developer you want to install the .NET Core SDK. If you are server administrator you may only want install the runtime.

**Question:** Will .csproj tooling be finalized with Visual Studio 2017 RTM?

— Yes, that is the current plan in place. There are couple of know issues for ASP.NET Core support in Visual Studio 2017; we have listed the workarounds on our [GitHub repo](https://github.com/aspnet/Tooling/blob/master/known-issues-vs2017.md).

**Question:** How for along is the basic pipeline API?

— Currently, being tested by some folks at Stack Overflow.  If you would like to get involved tweet David Fowler.

**Question:** When will URL based cultural localization be available?

— It’s available now.  With ASP.NET Core 1.1  [Middleware as MVC filters](https://blogs.msdn.microsoft.com/webdev/2016/10/25/announcing-asp-net-core-1-1-preview-1/).

In [this example](https://blogs.msdn.microsoft.com/webdev/2016/10/25/announcing-asp-net-core-1-1-preview-1/) from the ASP.NET Core 1.1 announcement we used a route value based request culture provider to establish the current culture for the request using the localization middleware.

The team will be back on Tuesday the 29th of November to discuss the latest updates on ASP.NET Core.  See you then!
