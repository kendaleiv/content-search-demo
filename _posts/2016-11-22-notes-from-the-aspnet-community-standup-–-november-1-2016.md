---
layout: post
site: MSDN blog
title: Notes from the ASPNET Community Standup – November 1 2016
date: 2016-11-22
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

Each week the standup is hosted live on Google Hangouts and the team publishes the recorded video of their discussion to YouTube for later reference. The guys answer your questions LIVE and unfiltered. This is your chance to ask about the why and what of ASP.NET! Join them each Tuesday on live.asp.net where the meeting’s schedule is posted and hosted.

<span id="more-8115"></span>  
**ASP.NET Community Standup 11/01/2016**

<iframe width="760" height="515" allowfullscreen="allowfullscreen" frameborder="0" src="https://www.youtube.com/embed/qB2XYjkCN_s"></iframe>

## Community Links

[Puma Scan](https://www.pumascan.com/) is a software security Visual Studio analyzer extension that is built on top of Roslyn.

[Plug ASP.NET Core Middleware in MVC Filters Pipeline ](http://www.hishambinateya.com/plug-asp.net-core-middlware-in-mvc-filters-pipeline)

[Building An API with NancyFX 2.0 + Dapper](http://blog.nandotech.com/post/2016-10-25-nancyfx-webapi-dapper/)

[.NET Standard based Windows Service support for .NET ](https://github.com/dasMulli/dotnet-win32-service)

[Accessing the HTTP Context on ASP.NET Core](https://pfelix.wordpress.com/2016/11/01/accessing-the-http-context-on-asp-net-core/)

[Accessing services when configuring MvcOptions in ASP.NET Core ](http://andrewlock.net/accessing-services-when-configuring-mvcoptions-in-asp-net-core/)

[Adding Cache-Control headers to Static Files in ASP.NET Core ](http://andrewlock.net/adding-cache-control-headers-to-static-files-in-asp-net-core/)

[Building .Net Core On Travis CI](https://rimdev.io/building-net-core-on-travis-ci/)

[Umbraco CLI running on ASP.NET Core](http://shazwazza.com/post/umbraco-cli-running-on-aspnet-core/)

[Testing SSL in ASP.NET Core](http://wildermuth.com/2016/10/26/Testing-SSL-In-ASP-NET-Core)

[ASP.NET API Versioning ](https://github.com/Microsoft/aspnet-api-versioning/blob/master/README.md)

[Creating a new .NET Core web application, what are your options?](https://jonhilton.net/2016/10/19/creating-a-new-net-core-web-application-what-are-your-options/)

[Using MongoDB .NET Driver with .NET Core WebAPI](http://qappdesign.com/using-mongodb-with-net-core-webapi/)

[ASP.NET Core project targeting .NET 4.5.1 running on Raspberry Pi](https://www.billbogaiv.com/posts/aspnet-core-project-targeting-net-451-running-on-raspberry-pi)

[Free ASP.NET Core 1.0 Training on Microsoft Virtual Academy](http://www.hanselman.com/blog/FreeASPNETCore10TrainingOnMicrosoftVirtualAcademy.aspx)

[Using dotnet watch test for continuous testing with .NET Core and XUnit.net ](http://www.hanselman.com/blog/UsingDotnetWatchTestForContinuousTestingWithNETCoreAndXUnitnet.aspx)

[Azure Log Analytics ASP.NET Core Logging extension](https://github.com/ealsur/loganalytics-extensions-logging/blob/master/README.md)

[Bearer Token Authentication in ASP.NET Core](https://blogs.msdn.microsoft.com/webdev/2016/10/27/bearer-token-authentication-in-asp-net-core/)

[ASP.NET Core Module](https://github.com/aspnet/AspNetCoreModule)[Removal of dnvm scripts for the aspnet/home repo](https://github.com/aspnet/Announcements/issues/205)

# Demos

ASP.NET Core 1.1  Preview 1  added a couple of  [new features](https://blogs.msdn.microsoft.com/webdev/2016/10/25/announcing-asp-net-core-1-1-preview-1/) around Azure integration, performance and more. In this Community Standup Damian walks us through how he easily upgraded live.asp.net site to ASP.NET Core 1.1, as well as, how to add View Compilation and  Azure App Services.

**Upgrading Existing Projects**

Before you start using any of the <span>ASP.NET Core 1.1  Preview 1 features makes sued to update the [following](https://blogs.msdn.microsoft.com/dotnet/2016/10/25/announcing-net-core-1-1-preview-1/):</span>

*   Install .NET Core 1.1 Preview 1 SDK
*   Upgrade existing project  from .NET Core 1.0 to .NET Core 1.1 Preview 1\. Make sure to also updated your ASP.NET Core packages to their latest versions 1.1.0-preview1.
*   Update the netcoreapp1.0 target framework to netcoreapp1.1.

## View compilation

Damian went over how he added View compilation to [live.asp.net](https://live.asp.net/). Typically your razor pages get complied the first time someone visits the site. The advantage of  View compilation is, you can now precompile the razor views that your application references and deploy them. This features allow for faster startup times in your application since your views are ready to go.

To start using  precompiled views in your application follow the following steps.

*   Add  View compilation package

<pre>            "Microsoft.AspNetCore.Mvc.Razor.ViewCompilation.Design": {
                "version": "1.1.0-preview4-final",
                "type": "build"
             }</pre>

*   Add View compilation tool

<pre>             "Microsoft.AspNetCore.Mvc.Razor.ViewCompilation.Tools": {
                 "version": "1.1.0-preview4-final"
               }
</pre>

*   Include the post publish script to evoke pre-compilation

Now, that live.asp.net is configured to use view compilation, it will pre-compile the razor views. Once you’ve published your application, you will notice that your PublishOutput folders no longer contains a view folder. Instead, you will see appname.PrecompileViews.dll.

## Azure App Service logging Provider

Damian also configured  <span></span> [live.asp.net](https://live.asp.net/) to use Azure App services.  By adding  Microsoft.AspNetCore.AzureAppServicesIntegration package , and calling the UseAzureAppservices method in Program.cs Diagnostic logs are now turned on in Azure.(_see image below_).

[![appservices-logging-150](https://msdnshared.blob.core.windows.net/media/2016/11/AppServices-Logging-150.png)](https://msdnshared.blob.core.windows.net/media/2016/11/AppServices-Logging-150.png)  
With Application Logging turned on,you can choose the log level you want and see them in Kudu console, or Visual Studio. (_see image below)_

<div id="attachment_8145" style="width: 889px" class="wp-caption aligncenter">[![appservices-viewlogginginkuduconsole-150](https://msdnshared.blob.core.windows.net/media/2016/11/AppServices-ViewLoggingInKuduConsole-150-1024x576.png)](https://msdnshared.blob.core.windows.net/media/2016/11/AppServices-ViewLoggingInKuduConsole-150.png)

_Application Logs in Kudu_

</div>

This week Damian went over how to use some of the new features in ASP.NET Core 1.1  Preview 1\. For more details on ASP.NET Core 1.1 please check out the [announcement](https://blogs.msdn.microsoft.com/webdev/2016/10/25/announcing-asp-net-core-1-1-preview-1/) from last month. Thanks for watching.
