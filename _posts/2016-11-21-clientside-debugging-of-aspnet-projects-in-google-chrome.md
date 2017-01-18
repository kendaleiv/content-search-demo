---
layout: post
site: MSDN blog
title: Clientside debugging of ASPNET projects in Google Chrome
date: 2016-11-21
description: Visual Studio 2017 RC now supports client-side debugging of both JavaScript and TypeScript in Google Chrome. For years, it has been possible to debug both the backend .NET code and the client-side JavaScript code running in Internet Explorer at the same time. Unfortunately, the capability was limited solely to Internet Explorer. In Visual Studio 2017...
tags: 
- AspNet
- Debugging
- Visual Studio 2017
authors: Mads Kristensen
categories: 
- AspNet
- Debugging
- Visual Studio 2017
---

[Visual Studio 2017 RC](https://www.visualstudio.com/vs/visual-studio-2017-rc/) now supports client-side debugging of both JavaScript and TypeScript in Google Chrome.

For years, it has been possible to debug both the backend .NET code and the client-side JavaScript code running in Internet Explorer at the same time. Unfortunately, the capability was limited solely to Internet Explorer.

In Visual Studio 2017 RC that changes. You can now debug both JavaScript and TypeScript directly in Visual Studio when using Google Chrome as your browser of choice. All you should do is to select Chrome as your browser in Visual Studio and hit F5 to debug.

If you’re interested in giving us feedback on future features and ideas before we ship them, [join our community](http://landinghub.visualstudio.com/webdevtools).

[![browser-selector](https://msdnshared.blob.core.windows.net/media/2016/11/browser-selector.png)](https://msdnshared.blob.core.windows.net/media/2016/11/browser-selector.png)

The first thing you’ll notice when launching Chrome by hitting F5 in Visual Studio is a page that says, “Please wait while we attach…”.

[![debugger-attach](https://msdnshared.blob.core.windows.net/media/2016/11/debugger-attach1.png)](https://msdnshared.blob.core.windows.net/media/2016/11/debugger-attach1.png)

What happens is that Visual Studio is attaching to Chrome using the [remote debugging protocol](https://developer.chrome.com/devtools/docs/debugger-protocol) and then redirects to the ASP.NET project URL (something like http://localhost:12345) after it attaches. After the attach is complete, the “Please wait while we attach…” message remains visible while the ASP.NET site starts up where normally you’d see a blank browser during this time.

Once the debugger is attached, script debugging is now enabled for all JavaScript files in the project as well as all TypeScript files if there is source map information available. Here’s a screen shot of a breakpoint being hit in a TypeScript file.

[![breakpoint-hit](https://msdnshared.blob.core.windows.net/media/2016/11/breakpoint-hit.png)](https://msdnshared.blob.core.windows.net/media/2016/11/breakpoint-hit.png)

For TypeScript debugging you need to instruct the compiler to produce a .map file. You can do that by placing a tsconfig.json file in the root of your project and specify the a few properties, like so:

<pre>{
  "compileOnSave": true,
  "compilerOptions": {
    "sourceMap": true
  }
}
</pre>

There are developers who prefer to use Chrome’s or IE’s own dev tools to do client-side debugging and that is great. There will be a setting in Visual Studio that allows you to disable client-side debugging in both IE and Chrome, but unfortunately that didn’t make it in to the release candidate.

We hope you’ll enjoy this feature and we would love to hear your feedback in the comments section below, or [via Twitter](https://twitter.com/mkristensen).

[Download Visual Studio 2017 RC](https://www.visualstudio.com/vs/visual-studio-2017-rc/)
