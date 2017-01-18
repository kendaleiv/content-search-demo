---
layout: post
site: MSDN blog
title: Visual Studio Tools for Azure Functions
date: 2016-12-1
description: Update 12-6-16 @5,00 PM, Updated version of the tools are available that fix the ability to open .NET Core projects with Azure Functions tools installed. Install the updated version over your old version to fix the issue, there is no need to uninstall the previous copy.  Today we are pleased to announce a preview of...
tags: 
- Azure
authors: Andrew B Hall - MSFT
categories: 
- Azure
---

**Update 12-6-16 @5:00 PM: Updated version of the tools are available that fix the ability to open .NET Core projects with Azure Functions tools installed. [Install the updated version](https://aka.ms/azfunctiontools) over your old version to fix the issue, there is no need to uninstall the previous copy. **

Today we are pleased to announce a preview of tools for building [Azure Functions](https://azure.microsoft.com/en-us/services/functions/) for Visual Studio 2015\. Azure Functions provide event-based serverless computing that make it easy to develop and scale your application, paying only for the resources your code consumes during execution. This preview offers the ability to create a function project in Visual Studio, add functions using [any supported language](https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview), run them locally, and publish them to Azure. Additionally, C# functions support both local and remote debugging.

In this post, I’ll walk you through using the tools by creating a C# function, covering some important concepts along the way. Then, once we’ve seen the tools in action I’ll cover some known limitations we currently have.

Also, please take a minute and [let us know who you are](http://landinghub.visualstudio.com/webdevtools-0) so we can follow up and see how the tools are working.

# Getting Started

Before we dive in, there are a few things to note:

*   These tools are offered as a preview release and will have some rough spots and limitations
*   They currently only work with Visual Studio 2015 Update 3 with “Microsoft Web Developer Tools” installed
*   You must have [Azure 2.9.6 .NET SDK](https://go.microsoft.com/fwlink/?LinkId=518003&clcid=0x409) installed
*   [Download and install Visual Studio Tools for Azure Functions](https://aka.ms/azfunctiontools)

For our sample function, we’ll create a C# function that is triggered when a message is published into a storage Queue, reverses it, and stores both the original and reversed strings in Table storage.

*   To create a function, go to:
*   File -> New Project
*   Then select the “Cloud” node under the “Visual C#” section and choose the “Azure Functions (Preview) project type  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb632.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image755.png)
*   This will give us an empty function project. There are a few things to note about the structure of the project:
    *   **appsettings.json** is where we’ll store configuration information such as connection strings  
        _It is recommended that you exclude this file from source control so you don’t check in your developer secrets._
    *   **host.json** [enables us to configure the behavior of the Azure Functions host](https://github.com/Azure/azure-webjobs-sdk-script/wiki/host.json)  
        [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb633.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image756.png)
*   For the purposes of this blog post, we’ll add an entry that speeds up the queue polling interval from the default of once a minute to once a second by setting the “maxPollingInterval” in the host.json (value is in ms)  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb634.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image757.png)
*   Next, we’ll add a function to the project, by right clicking on the project in Solution Explorer, choose “Add” and then “New Azure Function”  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb635.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image758.png)
*   This will bring up the New Azure Function dialog which enables us to create a function using any language supported by Azure Functions  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb636.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image759.png)
*   For the purposes of this post we’ll create a “QueueTrigger – C#” function, fill in the “Queue name” field, “Storage account connection” (this is the name of the key for the setting we’ll store in “appsettings.json”), and the “Name” of our function.  _Note: All function types except HTTP triggers require a storage connection or you will receive an error at run time_  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb637.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image760.png)
*   This will create a new folder in the project with the name of our function with the following key files:
    *   **function.json:** [contains the configuration data for the function](https://github.com/Azure/azure-webjobs-sdk-script/wiki/function.json) (including the information we specified as part of creating the new function)
    *   **project.json (C#):** is where we’ll specify any NuGet dependencies our function may have. _Note: [Azure functions automatically import some namespaces and assemblies](https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-csharp#importing-namespaces) (e.g. Json.NET)._
    *   **run.csx:** this contains the body of the function that will be executed when triggered  
        [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb638.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image761.png)
*   The last thing we need to do in order to hook up function to our storage Queue is provide the connecting string in the appsettings.json file (in this case by setting the value of “AzureWebJobsStorage”)  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb639.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image762.png)
*   Next we’ll edit the “function.json” file to add two bindings, [one that gives us the ability to read from the table](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-table#storage-table-input-binding) we’ll be pushing to, and [another that gives us the ability to write entries to the table](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-table#storage-table-output-binding)  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb640.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image763.png)
*   Finally, we’ll write our function logic in the run.csx file  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb641.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image764.png)
*   Running the function locally works like any other project in Visual Studio, Ctrl + F5 starts it without debugging, and F5 (or the Start/Play button on the toolbar) launches it with debugging. _Note: Debugging currently only works for C# functions. Let’s hit F5 to debug the function._
*   The first time we run the function, we’ll be prompted to install the Azure Functions CLI (command line) tools. Click “Yes” and wait for them to install, our function app is now running locally. We’ll see a command prompt with some messages from the Azure Functions CLI pop up, if there were any compilation problems, this is where the messages would appear since functions are dynamically compiled by the CLI tools at runtime.  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb642.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image765.png)
*   We now need to manually trigger our function by pushing a message into the queue with [Azure Storage Explorer](http://storageexplorer.com/). This will cause the function to execute and hit our breakpoint in Visual Studio.  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb643.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image766.png)

# Publishing to Azure

*   Now that we’ve tested the function locally, we’re ready to publish our function to Azure. To do this right click on the project and choose “Publish…”, then choose “Microsoft Azure App Service” as the publish target  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb644.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image767.png)
*   Next, you can either pick an existing app, or create a new one. We’ll create a new one by clicking the “New…” button on the right side of the dialog
*   This will pop up the provisioning dialog that lets us choose or setup the Azure environment (we can customize the names or choose existing assets). These are:
    *   **Function App Name:** the name of the function app, this must be unique
    *   **Subscription:** the Azure subscription to use
    *   **Resource Group:** what resource group the to add the Function App to
    *   **App Service Plan:** What app service plan you want to run the function on. For complete information [read about hosting plans](https://docs.microsoft.com/en-us/azure/azure-functions/functions-scale), but it’s important to note that if you choose an existing App Service plan you will need to [set the plan to “always on”](https://docs.microsoft.com/en-us/azure/app-service-web/web-sites-configure#application-settings) or your functions won’t always trigger (Visual Studio automatically sets this if you create the plan from Visual Studio)
*   Now we’re ready to provision (create) all of the assets in Azure. _Note: that the “Validate Connection” button does not work in this preview for Azure Functions _  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb645.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image768.png)
*   Once provisioning is complete, click “Publish” to publish the Function to Azure. We now have a publish profile which means all future publishes will skip the provisioning steps  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb646.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image769.png)  
    **Note:** If you publish to a Consumption plan, there is currently a bug where new triggers that you define (other than HTTP) will not be registered in Azure, which can cause your functions not to trigger correctly. To work around this, open your Function App in the Azure portal and click the “Refresh” button on the lower left to fix the trigger registration. This bug with publish will be fixed on the Azure side soon.
*   To verify our function is working correctly in Azure, we’ll click the “Logs” button on the function’s page, and then push a message into the Queue using Storage Explorer again. We should see a message that the function successfully processed the message  
    [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb647.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image770.png)
*   The last thing to note, is that it is possible to remote debug a C# function running in Azure from Visual Studio. To do this:
    *   Open [Cloud Explorer](https://docs.microsoft.com/en-us/azure/vs-azure-tools-resources-managing-with-cloud-explorer)
    *   Browse to the Function App
    *   Right click and choose “Attach Debugger”  
        [![image](https://msdnshared.blob.core.windows.net/media/2016/11/image_thumb648.png "image")](https://msdnshared.blob.core.windows.net/media/2016/11/image771.png)

# Known Limitations

As previously mentioned, this is the first preview of these tools, and we have several known limitations with them. They are as follow:

*   **IntelliSense:** IntelliSense support is limited, and available only for C#, and JavaScript by default. F#, Python, and PowerShell support is available if you have installed those optional components. It is also important to note that C# and F# IntelliSense is limited at this point to classes and methods defined in the same .csx/.fsx file and a few system namespaces.
*   **Cannot add new files using “Add New Item”:** Adding new files to your function (e.g. .csx or .json files) is not available through “Add New Item”. The workaround is to add them using file explorer, the [Add New File extension](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.AddNewFile), or another tool such as [Visual Studio Code](https://code.visualstudio.com).
*   **Functions published from Visual Studio are not properly registered in Azure:** This is caused by a bug in the Azure service for Functions running on a Consumption plan. The workaround is to open the Function App’s page in the [Azure portal](https://portal.azure.com) and click the “Refresh” button in the bottom left. This will register the functions with Azure.
*   **Function bindings generate incorrectly when creating a C# Image Resize function:** The settings for the binding “Azure Storage Blob out (imageSmall)” are overridden by the settings for the binding “Azure Storage Blob out (imageMedium)” in the generated function.json. The workaround is to go to the generated function.json and manually edit the “imageSmall” binding.
*   **Cannot use project names with a “.” character:** The Azure Functions CLI version 1.0.0-beta.8 will not work if launched from a folder with a “.” character ([tracked by this GitHub issue](https://github.com/Azure/azure-webjobs-sdk-script/issues/1006)). The workaround is to use spaces or dashes until this bug is fixed.
*   **Local deployment and web deploy packages are not supported:** Currently, only Web Deploy to App Service is supported. If you try to use Local Deploy or a Web Deploy Package, you’ll see the error “GatherAllFilesToPublish does not exist in the project”.
*   **The Publish Preview shows all files in the project’s folder even if they are not part of the project: **Publish preview does not function correctly, and will cause all files in the project folder to be picked up and and published.  Avoid using the Preview view.

# Conclusion

Please [download and try out this preview of Visual Studio Tools for Azure Functions](https://aka.ms/azfunctiontools) and [let us know who you are so we can follow up and see how they are working](http://landinghub.visualstudio.com/webdevtools-0). Additionally, please report any issues you encounter on our [GitHub repo](https://go.microsoft.com/fwlink/?linkid=836326) (include “Visual Studio” in the issue title) and provide any comments or questions you have below, or [via Twitter](https://twitter.com/AndrewBrianHall).
