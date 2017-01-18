---
layout: post
site: MSDN blog
title: MVP Hackathon 2016 Cool Projects from Microsoft MVPs
date: 2016-11-22
description: Last week was the annual MVP Summit on Microsoft’s Redmond campus.  We laughed, we cried, we shared stories around the campfire, and we even made s’mores.  Ok, I’m stretching it a bit about the last part, but we had a good time introducing the MVPs to some of the cool technologies you saw at Connect()...
tags: 
- Uncategorized
authors: Jeffrey T. Fritz
categories: 
- Uncategorized
---

Last week was the annual [MVP Summit](https://mvp.microsoft.com/en-us/Summit) on Microsoft’s Redmond campus.  We laughed, we cried, we shared stories around the campfire, and we even made s’mores.  Ok, I’m stretching it a bit about the last part, but we had a good time introducing the [MVPs](https://mvp.microsoft.com) to some of the cool technologies you saw at [Connect()](https://connectevent.microsoft.com) yesterday, and some that are still in the works for 2017.  As part of the MVP Summit event, we hosted a hackathon to explore some of the new features and allow attendees to write code along with Microsoft engineers and publish that content as an open source project.

We shared the details of some of these projects with the supervising program managers covering Visual Studio, ASP.NET, and the .NET framework.  Those folks were impressed with the work that was accomplished, and now we want to share these accomplishments with you.  This is what a quick day’s worth of work can accomplish when working with your friends.

<div id="attachment_8105" style="width: 889px" class="wp-caption aligncenter">[![MVP Hackers at the end of the Hackathon](https://msdnshared.blob.core.windows.net/media/2016/11/HackathonGroup-cropped-1024x340.jpg)](https://msdnshared.blob.core.windows.net/media/2016/11/HackathonGroup-cropped.jpg)

MVP Hackers at the end of the Hackathon

</div>

*   Shaun Luttin wrote a console application in F# that plays a card trick.  Source code at:  [https://github.com/shaunluttin/magical-mathematics](https://github.com/shaunluttin/magical-mathematics)
*   Rainer Stropek created a docker image to fully automate the deployment and running of a Minecraft server with bindings to allow interactions with the server using .NET Core.  Rainer summarized [his experience and the docker image on his blog](http://www.software-architects.com/devblog/2016/11/10/minecraft-server-for-dotnet-csharp-modding)
*   Tanaka Takayoshi wrote an extension command called “add” for the dotnet command-line interface.  The Add command helps format new classes properly with namespace and initial class declaration code when you are working outside of Visual Studio. Tanaka’s [project is on GitHub](https://github.com/tanaka-takayoshi/MVPSummitHackathon2016/tree/hackathon-dotnet-add).
*   Tomáš Herceg wrote an extension for Visual Studio 2017 that supports development with the [DotVVM framework for ASP.NET](https://www.dotvvm.com).  DotVVM is a front-end framework that dramatically simplifies the amount of code you need to write in order to create useful web UI experiences.  His project can be found on GitHub at: [https://github.com/riganti/dotvvm](https://github.com/riganti/dotvvm)   See the animated gif below for a sample of how DotVVM can be coded in Visual Studio 2017:

    <div id="attachment_8155" style="width: 1323px" class="wp-caption aligncenter">[![DotVVM Intellisense in action](https://msdnshared.blob.core.windows.net/media/2016/11/dotvvm_intellisense.gif)](https://msdnshared.blob.core.windows.net/media/2016/11/dotvvm_intellisense.gif)

    DotVVM Intellisense in action

    </div>

*   The [ASP.NET Monsters](https://twitter.com/aspnetmonsters) wrote [Pugzor](https://github.com/AspNetMonsters/pugzor/), a drop-in replacement for the Razor view engine using the “Pug” JavaScript library as the parser and renderer. It can be added side-by-side with Razor in your project and enabled with one line of code. If you have Pug templates (previously called Jade) these now work as-are inside ASP.NET Core MVC. The ASP.NET Monsters are: [Simon Timms](https://twitter.com/stimms), [David Paquette](https://twitter.com/dave_paquette) and [James Chambers](https://twitter.com/CanadianJames)

    <div id="attachment_8245" style="width: 889px" class="wp-caption aligncenter">[![Pugzor](https://msdnshared.blob.core.windows.net/media/2016/11/pugzor-1024x571.jpg)](https://msdnshared.blob.core.windows.net/media/2016/11/pugzor.jpg)

    Pugzor

    </div>

*   Alex Sorkoletov wrote an addin for Xamarin Studio that helps to clean up unused using statements and sort them alphabetically on every save.  The project can be found at: [https://github.com/alexsorokoletov/XamarinStudio.SortRemoveUsings](https://github.com/alexsorokoletov/XamarinStudio.SortRemoveUsings)
*   Remo Jansen put together an extension for Visual Studio Code to display class diagrams for TypeScript.  The extension is in alpha, but looks very promising on [his GitHub project page](https://github.com/remojansen/MVPSummit2016Hackathon).

    <div id="attachment_8165" style="width: 889px" class="wp-caption aligncenter">[![Visual Studio Code - TypeScript UML Generator](https://msdnshared.blob.core.windows.net/media/2016/11/VsCodeTsUmlPreview-1024x576.gif)](https://msdnshared.blob.core.windows.net/media/2016/11/VsCodeTsUmlPreview.gif)

    Visual Studio Code – TypeScript UML Generator

    </div>

*   Giancarlo Lelli put together an extension to help deploy front-end customizations for Dynamics 365 directly from Visual Studio.  It uses the TFS Client API to detect any changes in you workspace and check in everything on your behalf. It is able to handle conflicts that prevents you to overwrite the work of other colleagues. The extension keeps the same folder structure you have in your solution explorer inside the CRM. It also supports adding the auto add of new web resources to a specific CRM solution. This extension uses the VS output window to provide feedback during the whole publish process.  The project can be found [on its GitHub page](https://github.com/GiancarloLelli/xrmdeployvsx).

    <div id="attachment_8175" style="width: 823px" class="wp-caption aligncenter">[![Publish to Dynamics](https://msdnshared.blob.core.windows.net/media/2016/11/PublishToDynamics.png)](https://msdnshared.blob.core.windows.net/media/2016/11/PublishToDynamics.png)

    Publish to Dynamics

    </div>

*   Simone Chiaretta wrote an extension for the dotnet command-line tool to manage the properties in .NET Core projects based on MSBuild. It allows setting and removing the version number, the supported runtimes and the target framework (and more properties are being added soon). And it also lists all the properties in the project file.  You can extend your .NET CLI with his [NuGet package](https://www.nuget.org/packages/dotnet-prop) or grab [the source code from GitHub](https://github.com/simonech/dotnet-prop/).  He’s written [a blog post](http://codeclimber.net.nz/archive/2016/11/16/Extending-the-dotnet-core-cli-introducing-dotnet-prop.aspx) with more details as well.

    <div id="attachment_8185" style="width: 978px" class="wp-caption aligncenter">[![The dotnet prop command](https://msdnshared.blob.core.windows.net/media/2016/11/dotnet-prop.png)](https://msdnshared.blob.core.windows.net/media/2016/11/dotnet-prop.png)

    The dotnet prop command

    </div>

*   Nico Vermeir wrote an amazing little extension that enables the Surface Dial to help run the Visual Studio debugger.  He wrote a [blog post about it](http://www.spikie.be/blog/post/2016/11/10/.aspx) and published [his source code on GitHub](https://github.com/NicoVermeir/DialDebug).

    <div style="text-align: center"><iframe width="560" height="315" src="https://www.youtube.com/embed/FxdQ5XwYBFI" frameborder="0" allowfullscreen="allowfullscreen"></iframe></div>

*   David Gardiner wrote a Roslyn Analyzer that provides tips and best practice recommendations when authoring extensions for Visual Studio.  [Source code is on GitHub](https://github.com/flcdrg/VsixAnalyzer).

    <div id="attachment_8195" style="width: 2505px" class="wp-caption aligncenter">[![VSIX Analyzers](https://msdnshared.blob.core.windows.net/media/2016/11/VsixAnalyzers.gif)](https://msdnshared.blob.core.windows.net/media/2016/11/VsixAnalyzers.gif)

    VSIX Analyzers

    </div>

*   Cecilia Wirén wrote an extension for Visual Studio that allows you to add a folder on disk as a solution folder, preserving all files in the folder.  [Cecilia’s code can be found on GitHub](https://github.com/ceciliasharp/Extension.FolderToSolutionFolder)

    <div id="attachment_8225" style="width: 1290px" class="wp-caption aligncenter">[![Add as Solution Folder](https://msdnshared.blob.core.windows.net/media/2016/11/AddAsSolutionFolder.gif)](https://msdnshared.blob.core.windows.net/media/2016/11/AddAsSolutionFolder.gif)

    Add Folder as Solution Folder

    </div>

*   Terje Sandstrom updated the NUnit 3 adapter to support Visual Studio 2017.

    <div id="attachment_8215" style="width: 214px" class="wp-caption aligncenter">[![NUnit Results in Visual Studio 2017](https://msdnshared.blob.core.windows.net/media/2016/11/Nunit-204x350.png)](https://msdnshared.blob.core.windows.net/media/2016/11/Nunit.png)

    NUnit Results in Visual Studio 2017

    </div>

*   Ben Adams made the [Kestrel web server](https://github.com/aspnet/KestrelHttpServer) for ASP.NET Core 8% faster while sitting in with some of the ASP.NET Core folks.

## Summary

We had an amazing time working together, pushing each other to develop and build more cool things that could be used with Visual Studio 2015, 2017, Code, and Xamarin Studio.  Stepping away from the event, and reading about these cool projects inspires me to write more code, and I hope it does the same for you.  Would you be interested in participating in a hackathon with MVPs or Microsoft staff?  Let us know in the comments below
