---
layout: post
site: MSDN blog
title: New Updates to Web Tools in Visual Studio 2017 RC
date: 2016-12-12
description: Update 12/15, There was a bug in the Visual Studio 2017 installer that shipped between 12/12 and 12/14, that if you updated a prior RC installation it uninstalled IIS Express, Web Deploy, and LocalDB.  The fix is to manually re-install IIS Express, Web Deploy, and LocalDB.  We shipped an updated installer on 12/15 that fixed...
tags: 
- Uncategorized
authors: Daniel Roth
categories: 
- Uncategorized
---

**Update 12/15: There was a bug in the Visual Studio 2017 installer that shipped between 12/12 and 12/14, that if you updated a prior RC installation it uninstalled IIS Express, Web Deploy, and LocalDB.  The fix is to manually re-install IIS Express, Web Deploy, and LocalDB.  We shipped an updated installer on 12/15 that fixed this issue, so if you updated Visual Studio 2017 RC on 12/15 or later you will not be affected. [For details see our known issues page](https://github.com/aspnet/Tooling/blob/master/known-issues-vs2017.md#web-tools-known-issues).**

Today we [announced](https://blogs.msdn.microsoft.com/visualstudio/2016/12/12/updating-visual-studio-2017-release-candidate/) an update to [Visual Studio 2017 RC](https://www.visualstudio.com/vs/visual-studio-2017-rc/) that includes a variety of improvements for both ASP.NET and ASP.NET Core projects. If you’ve already installed Visual Studio 2017 RC then these updates will be pushed to you automatically. Otherwise, simply install [Visual Studio 2017 RC](https://www.visualstudio.com/vs/visual-studio-2017-rc/) and you will get the latest updates. Below is a summary of the improvements to the Web tools in this release:

*   The ability to turn off [script debugging for Chrome and Internet Explorer](https://blogs.msdn.microsoft.com/webdev/2016/11/21/client-side-debugging-of-asp-net-projects-in-google-chrome/) if you prefer to use the in-browser tools. To do this, go to Debug -> Options, and uncheck “Enable JavaScript debugging for ASP.NET (Chrome and IE)”.  
    [![chrome-script-debugging](https://msdnshared.blob.core.windows.net/media/2016/12/Chrome-script-debugging.png)](https://msdnshared.blob.core.windows.net/media/2016/12/Chrome-script-debugging.png)
*   [Bower packages](https://docs.microsoft.com/en-us/aspnet/core/client-side/bower) now restore correctly without any manual workarounds required.
*   General stability improvements for ASP.NET Core applications, including:
    *   Usability and stability improvements for creating [ASP.NET Core apps with Docker containers](https://blogs.msdn.microsoft.com/webdev/2016/11/16/new-docker-tools-for-visual-studio/). Most notably we’ve fixed the issue that when provisioning a app in Azure App Service, new resource groups no longer need to be created in the same region as the App Service plan.
    *   Entity Framework Core commands such as Add-Migration, and Update-Database can be invoked from the NuGet Package Manager Console.
    *   ASP.NET Core applications now work with Windows Authentication.
    *   Lots of improvements to the .NET Core tooling. For complete details see the [.NET team blog post](https://blogs.msdn.microsoft.com/dotnet/2016/12/12/updating-visual-studio-2017-rc-net-core-tooling-improvements).

Thanks for trying out this latest update of Visual Studio 2017! For an up to date list of known issues [see our GitHub page](https://github.com/aspnet/Tooling/blob/master/known-issues-vs2017.md), and keep the feedback coming by reporting any issues using the [built-in feedback tools](https://docs.microsoft.com/en-us/visualstudio/ide/how-to-report-a-problem-with-visual-studio-2017).
