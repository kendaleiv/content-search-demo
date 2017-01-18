---
layout: post
site: MSDN blog
title: Introducing the ASPNet Async OutputCache Module
date: 2016-12-5
description: OutputCacheModule is ASP.NET’s default handler for storing the generated output of pages, controls, and HTTP responses.  This content can then be reused when appropriate to improve performance. Prior to the .NET Framework 4.6.2, the OutputCache Module did not support async read/write to the storage. Starting with the .NET Framework 4.6.2 release, we introduced a new...
tags: 
- Uncategorized
authors: lanlanlee2008
categories: 
- Uncategorized
---

OutputCacheModule is ASP.NET’s default handler for storing the generated output of pages, controls, and HTTP responses.  This content can then be reused when appropriate to improve performance. Prior to the .NET Framework 4.6.2, the OutputCache Module did not support async read/write to the storage.

Starting with the [.NET Framework 4.6.2 release](https://blogs.msdn.microsoft.com/dotnet/2016/08/02/announcing-net-framework-4-6-2/), we introduced a new OutputCache async provider abstract class named OutputCacheProviderAsync, which defines interfaces for an async OutputCache provider to enable asynchronous access to a shared OutputCache. The Async OutputCache Module that supports those interfaces is released as a NuGet package, which you can install to any 4.6.2+ web applications.

## **Benefits of the Async OutputCache Module**

It’s all about the scalability. The cloud makes it really easy to scale-out computing resources to serve the large spikes in service requests to an application. When you consider the scalability of an OutputCache, you can not use an in-memory provider because the in-memory provider does not allow you to share data across multiple web servers.

You will need to store OutputCache data in another storage medium such as Microsoft Azure SQL Database, NoSQL, or Redis Cache.  Currently, the OutputCache interaction with these storage mediums is restricted to run synchronously. With this update, the new async OutputCache module enables you to read and write data from these storage providers asynchronously. Async I/O operations help release threads quicker than synchronous I/O operations, which allows ASP.NET to handle other requests. If you are interested in more details about programming asynchronously and the use of the async and await keywords, you can read Stephen Cleary’s excellent article on <u>[Async Programming : Introduction to Async/Await on ASP.NET](https://msdn.microsoft.com/en-us/magazine/dn802603.aspx).</u>

## **How to use the Async OutputCache Module**

1.  Target your application to 4.6.2+.

The OutputCacheProviderAsync interface was introduced in .NET Framework 4.6.2, therefore you need to target your application to .NET Framework 4.6.2 or above in order to use the Async OutputCache Module. Download the [.NET Framework 4.6.2 Developer Pack](https://www.microsoft.com/en-us/download/details.aspx?id=53321) if you do not have it installed yet and update your application’s web.config targetFrameworks attributes as demonstrated below:

<pre><system.web>
  <compilation debug="true" targetFramework="4.6.2"/>
  <httpRuntime targetFramework="4.6.2"/>
</system.web></pre>

1.  Add the [Microsoft.AspNet.OutputCache.OutputCacheModuleAsync](https://www.nuget.org/packages/Microsoft.AspNet.OutputCache.OutputCacheModuleAsync/) NuGet package.

Use the NuGet package manager to install the Microsoft.AspNet.OutputCache.OutputCacheModuleAsync package.  This will add a reference to the Microsoft.AspNet.OutputCache.OutputCacheModuleAsync.dll and add the following configuration into the web.config file.

<pre><system.webServer>
  <modules>
    <remove name="OutputCache"/>
    <add name="OutputCache" type="Microsoft.AspNet.OutputCache.OutputCacheModuleAsync, Microsoft.AspNet.OutputCache.OutputCacheModuleAsync" preCondition="integratedMode"/>
  </modules>
</system.webServer></pre>

Now your applications will start using Async OutputCache Module. If no outputcacheprovider is specified in web.config, the module will use a default synchronous in-memory provider, with that you won’t get the async benefits. We have not yet released an Async OutputCache provider, but plan to in the near future. Let’s take a look at how you can implement an async OutputCache Provider of your own.

### **How to implement an async OutputCache Provider**

An async OutputCache Provider just needs to implement the [OutputCacheProviderAsync interface](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheproviderasync(v=vs.110).aspx).

More specifically, the async provider should implement the following 8 APIs.

<table>

<tbody>

<tr>

<td></td>

<td>[Add(String, Object, DateTime)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider.add(v=vs.110).aspx)</td>

<td>Inserts the specified entry into the output cache. (Inherited from [OutputCacheProvider](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider(v=vs.110).aspx).)</td>

</tr>

<tr>

<td></td>

<td>[AddAsync(String, Object, DateTime)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheproviderasync.addasync(v=vs.110).aspx)</td>

<td>Asynchronously inserts the specified entry into the output cache.</td>

</tr>

<tr>

<td></td>

<td>[Get(String)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider.get(v=vs.110).aspx)</td>

<td>Returns a reference to the specified entry in the output cache.(Inherited from [OutputCacheProvider](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider(v=vs.110).aspx).)</td>

</tr>

<tr>

<td></td>

<td>[GetAsync(String)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheproviderasync.getasync(v=vs.110).aspx)</td>

<td>Asynchronously returns a reference to the specified entry in the output cache.</td>

</tr>

<tr>

<td></td>

<td>[Remove(String)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider.remove(v=vs.110).aspx)</td>

<td>Removes the specified entry from the output cache.(Inherited from [OutputCacheProvider](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider(v=vs.110).aspx).)</td>

</tr>

<tr>

<td></td>

<td>[RemoveAsync(String)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheproviderasync.removeasync(v=vs.110).aspx)</td>

<td>Asynchronously removes the specified entry from the output cache.</td>

</tr>

<tr>

<td></td>

<td>[Set(String, Object, DateTime)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider.set(v=vs.110).aspx)</td>

<td>Inserts the specified entry into the output cache, overwriting the entry if it is already cached.(Inherited from [OutputCacheProvider](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheprovider(v=vs.110).aspx).)</td>

</tr>

<tr>

<td></td>

<td>[SetAsync(String, Object, DateTime)](https://msdn.microsoft.com/en-us/library/system.web.caching.outputcacheproviderasync.setasync(v=vs.110).aspx)</td>

<td>Asynchronously Inserts the specified entry into the output cache, overwriting the entry if it is already cached.</td>

</tr>

</tbody>

</table>

If you want your provider to support Cache Dependency and callback functionality, you will need to implement the interface ICacheDependencyHandler, which is defined within the Microsoft.AspNet.OutputCache.OutputCacheModuleAsync.dll.  You can add this reference by installing the same [NuGet package](https://www.nuget.org/packages/Microsoft.AspNet.OutputCache.OutputCacheModuleAsync/) referenced in our web project.

The current version of the Async OutputCache Module does not support Registry Key nor SQL dependencies. Depending on the feedback we hear, we may consider adding them in the future.

Once you have finished implementing your provider class, you can use it in a web application by adding a reference to your library and adding the following configurations into the web.config file:

<pre><system.web>
  <caching>
    <outputCache defaultProvider="CustomOutputCacheProvider">
    <providers>
      <add name="CustomOutputCacheProvider" type="CustomOutputCacheProvider.CustomOutputCacheProvider, CustomOutputCacheProvider" />
    </providers>
    </outputCache>
  </caching>
</system.web>
</pre>

That should work! <span style="margin: 0px;color: #333333;font-family: 'Georgia',serif">If you need some help to get started, here is an example of an in-memory Async OutputCache Provider as a proof of concept. You can see that it has implemented all the APIs needed and is ready to plug in and use.</span>

## **Summary**

To wrap up things we have talked about: we have released an async version of the OutputCache Module which allows ASP.NET to take advantage of modern async techniques to help scale your OutputCache. With this new interface, you can now write your own async version of OutputCache providers easily. We encourage you to try this module and extend the your current OutputCache provider to any storage medium that supports async interactions. We also encourage you to share the providers you wrote on NuGet.org and let us know about them in the comments area below. Good luck and happy coding! If you have any questions or suggestions, please feel free to reach out to us by leaving your comments here.
