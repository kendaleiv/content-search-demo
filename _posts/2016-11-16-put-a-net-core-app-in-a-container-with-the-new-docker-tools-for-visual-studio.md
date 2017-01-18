---
layout: post
site: MSDN blog
title: Put a NET Core App in a Container with the new Docker Tools for Visual Studio
date: 2016-11-16
description: By now hopefully you’ve heard the good news that we’ve added first class support for building and running .NET applications inside of Docker containers in Visual Studio 2017 RC.  Visual Studio 2017 and Docker support building and running .NET applications using Windows containers (on Windows 10/Server 2016 only), and .NET Core applications on Linux containers,...
tags: 
- AspNetCore
- Azure
- Announcement
- Announcements
- app service
- container
authors: Jeffrey T. Fritz
categories: 
- AspNetCore
- Azure
- Announcement
- Announcements
- app service
- container
---

By now hopefully you’ve heard the good news that we’ve added first class support for building and running .NET applications inside of [Docker containers](https://www.docker.com/what-docker) in Visual Studio 2017 RC.  Visual Studio 2017 and Docker support building and running .NET applications using Windows containers (on Windows 10/Server 2016 only), and .NET Core applications on Linux containers, including the ability to publish and run Linux containers on Microsoft’s Azure App Service.

Docker containers package an application with everything it needs to run: code, runtime, system tools, system libraries – anything you would install on a server.  Put simply, a container is an isolated place where an application can run without affecting the rest of the system, and without the system affecting the application. This makes them an ideal way to package and run applications in production environments, where historically constraints imposed by the production environment (e.g. which version of the .NET runtime the server is running) have dictated development decisions.  Additionally, Docker containers are very lightweight which enable scaling applications quickly by spinning up new instances.

In this post, I’ll focus on creating a .NET Core application, publishing it to the Azure App Service Linux Preview and setting up continuous build integration and delivery to the Azure Container Service.

# Getting Started

To get started in Visual Studio 2017 you need to install the “.NET Core and Docker (Preview)” workload in the new Visual Studio 2017 installer

[![](https://msdnshared.blob.core.windows.net/media/2016/11/VS_Installer.png)](https://msdnshared.blob.core.windows.net/media/2016/11/VS_Installer.png)         [](https://msdnshared.blob.core.windows.net/media/2016/11/13-runningInAzureContainer.png)

Once it finishes installing, you’ll need to install [Docker for Windows](https://docs.docker.com/docker-for-windows/) (if you want to use Windows containers on Windows 10 or Server 2016 you’ll need the [Beta channel](https://download.docker.com/win/beta/InstallDocker.msi) and the [Windows 10 Anniversary Edition](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10), if you want Linux containers you can choose either the Stable or Beta channel installers).

After you’ve finished installing Docker, you’ll need to share a drive with it where your images will be built to and run from.  To do this:

*   Right click on the Docker system tray icon and choose settings
*   Choose the “Shared Drives” tab
*   Share the drive your images will run from (this is the same drive the Visual Studio project will live on)

[![2-driveconfig](https://msdnshared.blob.core.windows.net/media/2016/11/2-driveConfig-1024x611.png)](https://msdnshared.blob.core.windows.net/media/2016/11/2-driveConfig.png)

# Creating an application with Docker support

Now that Visual Studio and Docker are installed and configured properly let’s create a .NET Core application that we’ll run in a Linux container.

On the ASP.NET application dialog, there is a checkbox that allows us to add Docker support to the application as part of project creation.  For now, we’ll to skip this, so we can see how to add Docker support existing applications.

[![3-webapplication](https://msdnshared.blob.core.windows.net/media/2016/11/3-webapplication.png)](https://msdnshared.blob.core.windows.net/media/2016/11/3-webapplication.png)Now that we have our basic web application, let’s add a quick code snippet to the “About” page that will show what operating system the application is running on

[![4-about](https://msdnshared.blob.core.windows.net/media/2016/11/4-about.png)](https://msdnshared.blob.core.windows.net/media/2016/11/4-about.png)Next, we’ll hit Ctrl + F5 to run it inside IIS Express, we can see we’re running on Windows as we would expect.

[![5-runnatively](https://msdnshared.blob.core.windows.net/media/2016/11/5-runNatively.png)](https://msdnshared.blob.core.windows.net/media/2016/11/5-runNatively.png)Now, to add Docker support to the application, right click on the project in Solution Explorer, choose Add, and then “Docker Project Support” (use “Docker Solution Support” to create containers for multiple projects).

[![6-adddockersupport](https://msdnshared.blob.core.windows.net/media/2016/11/6-addDockerSupport.png)](https://msdnshared.blob.core.windows.net/media/2016/11/6-addDockerSupport.png)You’ll see that the “Start” button has changed to say “Docker” and several Docker files have been added to the project.

[![7-additionaldockerfiles](https://msdnshared.blob.core.windows.net/media/2016/11/7-additionalDockerFiles-1024x618.png)](https://msdnshared.blob.core.windows.net/media/2016/11/7-additionalDockerFiles.png)Let’s hit Ctrl+F5 again and we can see that the app is now running inside a Linux container locally.

[![8-runninginlinuxcontainer](https://msdnshared.blob.core.windows.net/media/2016/11/8-runningInLinuxContainer.png)](https://msdnshared.blob.core.windows.net/media/2016/11/8-runningInLinuxContainer.png)

# Running the application in Azure

Now let’s publish the app to Microsoft Azure App Service, which now offers the ability to run Linux Docker containers in a preview form.

To do this, I’ll right click on the app and choose “Publish”.  This will open our brand new publish page.  Click the “Profiles” dropdown and select “New Profile”, and then choose “Azure App Service Linux (Preview)” and click “OK”

[![9-publishtoazurecontainer](https://msdnshared.blob.core.windows.net/media/2016/11/9-publishToAzureContainer.png)](https://msdnshared.blob.core.windows.net/media/2016/11/9-publishToAzureContainer.png)

Before proceeding it’s important to understand the anatomy of how a Docker application works in a production environment:

*   A container registry is created that the Docker image is published to
*   The App Service site is created that downloads the image from the container registry and runs it
*   At any time, you can push a new image to the container registry which will then result in the copy running in App Service being updated.

With that understanding, let’s proceed to publishing our application to Azure.  The next thing we’ll see is the Azure provisioning dialog.  There are a couple of things to note about using this dialog in the RC preview:

*   If you are using an existing Resource Group, it must be in the same region as the App Service Plan you are creating
*   If you are creating a new Resource Group, you must set the Container Registry and the App Service plan to be in the same region (e.g. both must be in “West US”)
*   The VM size of the App Service Plan must be “S1” or larger

[![10-publishtoazurecontainerpart2](https://msdnshared.blob.core.windows.net/media/2016/11/10-publishToAzureContainerPart2.png)](https://msdnshared.blob.core.windows.net/media/2016/11/10-publishToAzureContainerPart2.png)When we click “OK” it will take about a minute, and then we’ll return to the “Publish” page, where we’ll see a summary of the publish profile we just created.

[![11-publishtoazurecontainerpart3](https://msdnshared.blob.core.windows.net/media/2016/11/11-publishToAzureContainerPart3.png)](https://msdnshared.blob.core.windows.net/media/2016/11/11-publishToAzureContainerPart3.png)Now we click “Publish” and it will take about another minute during which time you’ll see a Docker command prompt pop up

[![12-publishtoazurecontainerpart4](https://msdnshared.blob.core.windows.net/media/2016/11/12-publishToAzureContainerPart4-1024x229.png)](https://msdnshared.blob.core.windows.net/media/2016/11/12-publishToAzureContainerPart4.png)When the application is ready, your browser will open to the site, and we can see that we’re running on Linux in Azure!

[![13-runninginazurecontainer](https://msdnshared.blob.core.windows.net/media/2016/11/13-runningInAzureContainer.png)](https://msdnshared.blob.core.windows.net/media/2016/11/13-runningInAzureContainer.png)

# Setting up continuous build integration and delivery to the Azure Container Service

Now let’s setup continuous build delivery to Microsoft Azure Container Service. To do this, I’ll right click on the project and choose “Configure Continuous Delivery…”.  This will bring up a continuous delivery configuration dialog.

[![Configure Continuous Delivery](https://msdnshared.blob.core.windows.net/media/2016/11/EntryPoint.png)](https://msdnshared.blob.core.windows.net/media/2016/11/EntryPoint.png)

On the Configure Continuous Delivery dialog, select a user account with a valid Azure subscription as well as An Azure subscription with a valid Container registry and a DC/OC orchestrator Azure Container Service.

[![Configure Continuous Delivery](https://msdnshared.blob.core.windows.net/media/2016/11/ConfigureContinuousDelivery.png)](https://msdnshared.blob.core.windows.net/media/2016/11/ConfigureContinuousDelivery.png)

When done, click OK to start the setup process. A dialog will pop-up to explain that the setup process started.

[![Configuration Started](https://msdnshared.blob.core.windows.net/media/2016/11/ConfigurationStarted.png)](https://msdnshared.blob.core.windows.net/media/2016/11/ConfigurationStarted.png)

As the continuous build delivery setup can take several minutes to complete, you may consult the ‘Continuous Delivery Tools’ output tool window later to inspect the progress.

[![](https://msdnshared.blob.core.windows.net/media/2016/11/OutputSetupStarted-1024x195.png)](https://msdnshared.blob.core.windows.net/media/2016/11/OutputSetupStarted.png)

Upon successful completion of the setup, the output window will display the configuration details used to create the build and release definitions on VSTS to enable continuous build delivery for the project to the Azure Container Service.

[![Setup Complete](https://msdnshared.blob.core.windows.net/media/2016/11/OutputSetupComplete-1024x178.png)](https://msdnshared.blob.core.windows.net/media/2016/11/OutputSetupComplete.png)

# Conclusion

Please [download Visual Studio 2017](https://www.visualstudio.com/downloads/) today, and give our .NET Core and Docker experience a try.  It’s worth noting that this is a preview of the experience, so please help us make it great by providing feedback in the comments below.
