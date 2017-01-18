---
layout: post
site: MSDN blog
title: Notes from the ASPNET Community Standup – November 29 2016
date: 2016-12-6
description: This is the next in a series of blog posts that will cover the topics discussed in the ASP.NET Community Standup. The community standup is a short video-based discussion with some of the leaders of the ASP.NET development teams covering the accomplishments of the team on the new ASP.NET Core framework over the previous week....
tags: 
- Uncategorized
- CommunityStandup
authors: Maria Naggaga
categories: 
- Uncategorized
- CommunityStandup
---

This is the next in a series of blog posts that will cover the topics discussed in the ASP.NET Community Standup. The community standup is a short video-based discussion with some of the leaders of the ASP.NET development teams covering the accomplishments of the team on the new ASP.NET Core framework over the previous week. Join [Scott Hanselman](https://twitter.com/shanselman), [Damian Edwards](https://twitter.com/damianedwards), [Jon Galloway](https://twitter.com/jongalloway)(_Jon’s in Russia this week_)and an occasional guest or two discuss new features and ask for feedback on important decisions being made by the ASP.NET development teams.

Each week the standup is hosted live on Google Hangouts and the team publishes the recorded video of their discussion to YouTube for later reference. The guys answer your questions LIVE and unfiltered. This is your chance to ask about the why and what of ASP.NET! Join them each Tuesday on live.asp.net where the meeting’s schedule is posted and hosted.

<span id="more-8275"></span>

**ASP.NET Community Standup 11/29/2016**  
<iframe width="760" height="515" src="https://www.youtube.com/embed/hjwT0av9gzU" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

_Quick Note: Jon’s in Russia this week so, we don’t have any community links this week.  _

#### Question and Answers

This week  Damian and Scott jumped right into question. Damian had a question on Hanselman’s post “[Publishing ASP.NET Core 1.1 applications to Azure using git deploy](http://www.hanselman.com/blog/PublishingASPNETCore11ApplicationsToAzureUsingGitDeploy.aspx)“.

**Damian’s Question**: “_How did you create a project without a global.json? …. In Visual Studio today the project always includes a global.json… did you create it on a Mac?_ ”

— Scott: “_dotnet new in the command line_.”

Damian went on to explain the difference between a new application created using the dotnet cli and one created in Visual Studio. When a .NET Core project is created using the dotnet new templates, it does not come with solution level files like global.json.

<div id="attachment_8655" style="width: 1019px" class="wp-caption alignnone">[![dotnet new template](https://msdnshared.blob.core.windows.net/media/2016/12/dotnetnew.png)](https://msdnshared.blob.core.windows.net/media/2016/12/dotnetnew.png)

dotnet new template files

</div>

<div id="attachment_8665" style="width: 1004px" class="wp-caption alignnone">[![Visual Studio 2015 template](https://msdnshared.blob.core.windows.net/media/2016/12/vs.png)](https://msdnshared.blob.core.windows.net/media/2016/12/vs.png)

Visual Studio 2015 template with global.json

</div>

Today global.json is how you set the version of the .NET Core SDK needed for your application. Remember that unless you specify the version SDK, .NET Core will use the latest one on your machine and your app will not work. If you find yourself in a similar scenario to the one mentioned this how you fix it.

Find out what version of SDK you have locally.

[![dotnetversion](https://msdnshared.blob.core.windows.net/media/2016/12/dotnetversion-300x35.png)](https://msdnshared.blob.core.windows.net/media/2016/12/dotnetversion.png)

Add global.json to your project and include the appropriate version of the SDK.

Check out Hanselman’s post “[Publishing ASP.NET Core 1.1 applications to Azure using git deploy](http://www.hanselman.com/blog/PublishingASPNETCore11ApplicationsToAzureUsingGitDeploy.aspx)” for more information on the above.

**Question**: What are we doing to simplify the Docker versioning numbers?

— Now, that we have release 1.0 and 1.1 we can make a fair assessment of how well the versioning strategy is working. Based on those experiences we are going to make some adjustments.

**Question:** Why isn’t ASP.NET Core 1.1 backward compatible? I have a lot of 1.0 libraries.

— The intent is that with minor releases like from  1.0 to 1.1 of  any package or component shouldn’t  break stuff. However, the support matrix for the .NET Core is you can’t mix current components with LTS components. For example you can use ASP.NET Core hosting 1.0 with MVC for ASP.NET Core 1.1

See you at our next community standup!
