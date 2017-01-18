---
layout: post
site: MSDN blog
title: Announcing Microsoft ASPNET WebHooks V1
date: 2016-12-14
description: We are very happy to announce ASP.NET WebHooks V1 making it easy to both send and receive WebHooks with ASP.NET. WebHooks provide a simple pub/sub model for wiring together Web APIs and services with your code. A WebHook can be used to get notified when a file has changed in Dropbox, a code change has...
tags: 
- WebHooks
- Announcements
- ASP.NET MVC
- ASP.NET Web Api
- ASP.NET WebHooks
authors: Henrik F Nielsen
categories: 
- WebHooks
- Announcements
- ASP.NET MVC
- ASP.NET Web Api
- ASP.NET WebHooks
---

We are very happy to announce ASP.NET WebHooks V1 making it easy to both send and receive WebHooks with ASP.NET.

WebHooks provide a simple pub/sub model for wiring together Web APIs and services with your code. A WebHook can be used to get notified when a file has changed in Dropbox, a code change has been committed to GitHub, a payment has been initiated in PayPal, a card has been created in Trello, and much more — the possibilities are endless! When subscribing, you provide a callback URI where you want to be notified. When an event occurs, an HTTP POST request is sent to your callback URI with information about what happened so that your Web app can act accordingly. WebHooks happen without polling and with no need to hold open a network connection while waiting for notifications.

Because of their simplicity, WebHooks are already exposed by most popular services and Web APIs. To help managing WebHooks, Microsoft ASP.NET WebHooks makes it easier to both send and receive WebHooks as part of your ASP.NET application:

*   On the receiving side, it provides a common model for receiving and processing WebHooks from any number of WebHook providers. It comes out of the box with support for [Azure Alerts](https://azure.microsoft.com/en-us/blog/webhooks-for-azure-alerts/), [BitBucket](https://confluence.atlassian.com/bitbucket/manage-webhooks-735643732.html), [Dropbox](https://www.dropbox.com/developers/webhooks/tutorial), [Dynamics CRM](https://blogs.msdn.microsoft.com/crm/2016/01/15/sending-webhooks-with-microsoft-dynamics-crm/), [GitHub](https://developer.github.com/webhooks/), [Kudu](https://github.com/projectkudu/kudu/wiki/Web-hooks), [Instagram](https://www.instagram.com/developer/subscriptions/), [MailChimp](https://apidocs.mailchimp.com/webhooks/), [MyGet](http://docs.myget.org/docs/reference/webhooks), [PayPal](https://developer.paypal.com/webapps/developer/docs/integration/direct/rest-webhooks-overview/), [Pusher](https://pusher.com/docs/webhooks), [Salesforce](http://blogs.msdn.com/b/webdev/archive/2015/09/07/integrating-with-salesforce-using-asp-net-webhooks-preview.aspx), [Slack](https://api.slack.com/outgoing-webhooks), [Stripe](https://stripe.com/docs/webhooks), [Trello](http://blog.trello.com/webhooks-are-here/), [Visual Studio Team Services](https://www.visualstudio.com/en-us/docs/integrate/get-started/service-hooks/services/webhooks), [WordPress](https://en.support.wordpress.com/webhooks/), and [Zendesk](https://developer.zendesk.com/) as well as [IFTTT and Zapier](https://blogs.msdn.microsoft.com/webdev/2015/11/20/using-asp-net-webhooks-with-ifttt-and-zapier-to-monitor-twitter-and-google-sheets/), but it is easy to add support for more.
*   On the sending side, it provides support for generating WebHooks as a result of changes in your service. It helps [managing and storing subscriptions as well as sending event notifications to the right set of subscribers](https://blogs.msdn.microsoft.com/webdev/2015/09/15/sending-webhooks-with-asp-net-webhooks-preview/). This allows you to define your own set of events that users can subscribe to. ASP.NET WebHooks provides a lot of flexibility for sending and persisting WebHooks, [scaling your solution up and out](https://blogs.msdn.microsoft.com/webdev/2015/12/31/new-year-updates-to-asp-net-webhooks-preview/), as well as [sending WebHooks from WebJobs](https://blogs.msdn.microsoft.com/webdev/2016/01/30/sending-asp-net-webhooks-from-azure-webjobs/) and other places in addition to your Web Application.

The two parts can be used together or apart depending on your scenario. If you only need to receive WebHooks from other services, then you can use just the receiver part; if you only want to expose WebHooks for others to consume, then you can do just that.

In addition to hosting your own WebHook server, ASP.NET WebHooks are part of [Azure Functions](https://azure.microsoft.com/en-us/services/functions/) where you can process WebHooks without hosting or managing your own server! You can even go further and host an [Azure Bot Service using Microsoft Bot Framework](https://azure.microsoft.com/en-us/services/bot-service/) for writing cool bots talking to your customers!

The WebHook code targets [ASP.NET Web API 2](http://www.asp.net/web-api/overview/getting-started-with-aspnet-web-api/tutorial-your-first-web-api) and [ASP.NET MVC 5](http://www.asp.net/mvc), is available as [Open Source on GitHub](https://github.com/aspnet/WebHooks), and as [Nuget packages](http://www.nuget.org/packages?q=microsoft.aspnet.webhooks).

A port to the ASP.NET Core is being planned so please stay tuned!

### Receiving WebHooks

Dealing with WebHooks depends on who the sender is. Sometimes there are additional steps registering a WebHook verifying that the subscriber is really listening. Often the security model varies quite a bit. Some WebHooks provide a push-to-pull model where the HTTP POST request only contains a reference to the event information which is then to be retrieved independently.

The purpose of Microsoft ASP.NET WebHooks is to make it both simpler and more consistent to wire up your API without spending a lot of time figuring out how to handle any WebHook variant:

[![WebHookReceivers](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/3051.WebHookReceivers_thumb_234D6595.png "WebHookReceivers")](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/0272.WebHookReceivers_4E91FC9C.png)

A WebHook handler is where you process the incoming WebHook. Here is a sample handler illustrating the basic model. No registration is necessary – it will automatically get picked up and called:

<div id="codeSnippetWrapper">

<pre id="codeSnippet"><span>public</span> <span>class</span> MyHandler : WebHookHandler  
{  
    <span>// The ExecuteAsync method is where to process the WebHook data regardless of receiver</span>  
    <span>public</span> <span>override</span> Task ExecuteAsync(<span>string</span> receiver, WebHookHandlerContext context)  
    {  
        <span>// Get the event type</span>   
        <span>string</span> action = context.Actions.First();  

        <span>// Extract the WebHook data as JSON or any other type as you wish</span>  
        JObject data = context.GetDataOrDefault<JObject>();  

        <span>return</span> Task.FromResult(<span>true</span>);  
    }  
}</pre>

</div>

Finally, we want to ensure that we only receive HTTP requests from the intended party. Most WebHook providers use a shared secret which is created as part of subscribing for events. The receiver uses this shared secret to validate that the request comes from the intended party. It can be provided by setting an application setting in the Web.config file, or better yet, configured through the Azure portal or even retrieved from Azure Key Vault**.**

For more information about receiving WebHooks and [lots of samples](https://github.com/aspnet/WebHooks/tree/master/samples), please see these resources:

*   [Sending and Receiving WebHooks triggered by workflows and custom workflow activities from Microsoft Dynamics CRM](http://blogs.msdn.com/b/crm/archive/2016/01/15/sending-webhooks-with-microsoft-dynamics-crm.aspx).
*   [Subscribing to Instagram listening for media posted within a given geo-location](http://blogs.msdn.com/b/webdev/archive/2015/09/21/integrating-with-instagram-using-asp-net-webhooks-preview.aspx) and [associated sample](https://github.com/aspnet/WebHooks/tree/master/samples/InstagramReceiver).
*   [Subscribing to new and updated leads and opportunities from Salesforce](http://blogs.msdn.com/b/webdev/archive/2015/09/07/integrating-with-salesforce-using-asp-net-webhooks-preview.aspx).
*   [Subscribing to Slack WebHooks](http://blogs.msdn.com/b/webdev/archive/2015/09/06/receiving-slack-webhooks-with-asp-net-webhooks.aspx) and [Using Slack Slash Commands](https://blogs.msdn.microsoft.com/webdev/2016/02/14/asp-net-webhooks-and-slack-slash-commands/) enabling rich commands with structured data, images, and more; see [associated sample](https://github.com/aspnet/WebHooks/tree/master/samples/SlackReceiver).
*   [Integrating with IFTTT and Zapier to Monitor Twitter and Google Sheets](http://blogs.msdn.com/b/webdev/archive/2015/11/21/using-asp-net-webhooks-with-ifttt-and-zapier-to-monitor-twitter-and-google-sheets.aspx) and [associated sample](https://github.com/aspnet/WebHooks/tree/master/samples/GenericReceivers).
*   [Receiving WebHooks from Azure Alerts and Kudu (Azure Web App Deployment)](http://blogs.msdn.com/b/webdev/archive/2015/10/04/receive-webhooks-from-azure-alerts-and-kudu-azure-web-app-deployment.aspx) and [associated sample](https://github.com/aspnet/WebHooks/tree/master/samples/AzureReceivers).
*   [Sample building a Bitbucket WebHooks receiver](https://github.com/aspnet/WebHooks/tree/master/samples/BitbucketReceiver).
*   [Sample building a Stripe WebHooks receiver](https://github.com/aspnet/WebHooks/tree/master/samples/StripeReceiver).

### Sending WebHooks

Sending WebHooks is slightly more involved in that there are more things to keep track of. To support other APIs registering for WebHooks from your ASP.NET application, we need to provide support for:

*   Exposing which events subscribers can subscribe to, for example _Item Created_ and _Item Deleted_;
*   Managing subscribers and their registered WebHooks which includes persisting them so that they don’t disappear;
*   Handling per-user events in the system and determine which WebHooks should get fired so that WebHooks go to the correct receivers. For example, if user _A_ caused an _Item Created_ event to fire then determine which WebHooks registered by user _A_ should be sent. We don’t want events for user _A_ to be sent to user _B_. 
*   Sending WebHooks to receivers with matching WebHook registrations.

As described in the blog [Sending WebHooks with ASP.NET WebHooks Preview](http://blogs.msdn.com/b/webdev/archive/2015/09/15/sending-webhooks-with-asp-net-webhooks-preview.aspx), the basic model for sending WebHooks works as illustrated in this diagram:

[![WebHooksSender](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/7635.WebHooksSender_thumb_1CA3CB64.png "WebHooksSender")](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/2678.WebHooksSender_049B8B41.png)

Here we have a regular Web site (for example deployed in Azure) with support for registering WebHooks. WebHooks are typically triggered as a result of incoming HTTP requests through an MVC controller or a WebAPI controller. The orange blocks are the core abstractions provided by ASP.NET WebHooks:

1.  [IWebHookStore](https://github.com/aspnet/WebHooks/blob/master/src/Microsoft.AspNet.WebHooks.Custom/WebHooks/IWebHookStore.cs): An abstraction for storing WebHook registrations persistently. Out of the box we provide support for [Azure Table Storage](http://blogs.msdn.com/b/webdev/archive/2015/09/15/sending-webhooks-with-asp-net-webhooks-preview.aspx) and [SQL](http://blogs.msdn.com/b/webdev/archive/2015/11/07/updates-to-microsoft-asp-net-webhooks-preview.aspx) but the list is open-ended.
2.  [IWebHookManager](https://github.com/aspnet/WebHooks/blob/master/src/Microsoft.AspNet.WebHooks.Custom/WebHooks/IWebHookManager.cs): An abstraction for determining which WebHooks should be sent as a result of an event notification being generated. The manager can match event notifications with registered WebHooks as well as applying filters.
3.  [IWebHookSender](https://github.com/aspnet/WebHooks/blob/master/src/Microsoft.AspNet.WebHooks.Custom/WebHooks/IWebHookSender.cs): An abstraction for sending WebHooks determining the retry policy and error handling as well as the actual shape of the WebHook HTTP requests. Out of the box we provide support for immediate transmission of WebHooks as well as a queuing model which can be used for scaling up and out, see the blog [New Year Updates to ASP.NET WebHooks Preview](http://blogs.msdn.com/b/webdev/archive/2015/12/31/new-year-updates-to-asp-net-webhooks-preview.aspx) for details.

The registration process can happen through any number of mechanisms as well. Out of the box we support registering WebHooks through a REST API but you can also build registration support as an MVC controller or anything else you like.

It’s also possible to generate WebHooks from inside a [WebJob](http://www.hanselman.com/blog/IntroducingWindowsAzureWebJobs.aspx). This enables you to send WebHooks not just as a result of incoming HTTP requests but also as a result of messages being sent on a queue, a blob being created, or anything else that can trigger a WebJob:

[![WebHooksWebJobsSender](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/6683.WebHooksWebJobsSender_thumb_5C017EF4.png "WebHooksWebJobsSender")](https://msdnshared.blob.core.windows.net/media/MSDNBlogsFS/prod.evol.blogs.msdn.com/CommunityServer.Blogs.Components.WeblogFiles/00/00/00/63/56/metablogapi/8080.WebHooksWebJobsSender_033BC82A.png)

The following resources provide details about building support for sending WebHooks [as well as samples](https://github.com/aspnet/WebHooks/tree/master/samples):

*   [Sending WebHooks with ASP.NET WebHooks Preview](http://blogs.msdn.com/b/webdev/archive/2015/09/15/sending-webhooks-with-asp-net-webhooks-preview.aspx) describes the basic model for handling WebHook subscriptions, generating event notifications, and for receiving such WebHooks. Also check out the associated [sample of a basic Web Application sending custom WebHooks](https://github.com/aspnet/WebHooks/tree/master/samples/CustomSender) and a [sample receiving custom WebHooks](https://github.com/aspnet/WebHooks/tree/master/samples/CustomReceiver).
*   The blog [New Year Updates to ASP.NET WebHooks Preview Dec 2015](http://blogs.msdn.com/b/webdev/archive/2015/12/31/new-year-updates-to-asp-net-webhooks-preview.aspx) goes into details for how to send events to _all_ users and how to scale up and out your solution using persistent queues. There is also a [sample scaling out WebHooks by sending them to a queue](https://github.com/aspnet/WebHooks/tree/master/samples/CustomSender.QueuedSender).
*   The blog [Sending ASP.NET WebHooks from Azure WebJobs](http://blogs.msdn.com/b/webdev/archive/2016/01/31/sending-asp-net-webhooks-from-azure-webjobs.aspx) describes how to send WebHooks from WebJobs, which enable you to generate WebHooks triggered by [a number of sources](https://azure.microsoft.com/en-us/documentation/articles/websites-webjobs-resources/) including queues, blogs, etc. See also the associated [sample sending WebHooks from a WebJob](https://github.com/aspnet/WebHooks/tree/master/samples/CustomSender.WebJob).
*   The blog [Updates to Microsoft ASP.NET WebHooks Preview Nov 2015](http://blogs.msdn.com/b/webdev/archive/2015/11/07/updates-to-microsoft-asp-net-webhooks-preview.aspx) describes how to store WebHook registrations in SQL and how to register WebHook modules with a dependency engine.

Thanks to all the feedback and comments throughout the development process, it is very much appreciated!

Have fun!

Henrik
