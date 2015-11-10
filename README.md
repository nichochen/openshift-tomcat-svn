openshift-tomcat-svn
-----------------
This is an experimental Tomcat 7 S2I Image for OpenShift, which supports WAR deployment and Subversion source checkout and build.

### How to setup###
Downlaod the source to a Linux host with docker, make and [Openshift S2I](https://github.com/openshift/source-to-image/releases) installed.

####Step 1####
Download Apache Tomcat 7 from [Apache Tomcat homepage](http://tomcat.apache.org/download-70.cgi). Please download the tar.gz format.

####Step 2####
Extract the content of the Tomcat 7 tar.gz file into folder openshift-tomcat7-svn/tomcat7

####Step 3####
Build the image

        $ cd openshift-tomcat7-svn
        $ make
After the build is completed successfully, you can see the newly created image by running:

        $ docker images
  
####Step 4####
Tag and push the image to your own registry

        $ docker tag openshift-tomcat7-svn <your registry>/openshift-tomcat7-svn  
        $ docker push <your registry>/openshift-tomcat7-svn  

####Step ####
To use the image in OpenShift, you need to create ImageStream and Template for the image.
Sample ImageStream and Template JSON files are provided in openshift-tomcat7-svn/ose-json.
Please modify them according to your need, before importing into OpenShift.

        $oc create -n openshift -f openshift-tomcat7-svn-is.json
        $oc create -n openshift -f openshift-tomcat7-svn-template.json

####Step 6####
Now you can create a new project in OpenShift and add a new app to the project, remember to select the template we just created. 

#####Subversion Source Checkout & build#####
After selecting the template, you will be navigated to a UI to enter detail information. In there, you can enter your Subversion endpoint which pointing to your Java source. You also need to enter a valid Git URI, because OpenShift S2I needs to do a Git clone during S2I anyway (yes, I might fix that in the future), in this case we can just enter a valid Git URI, no need to care about what content the Git URI is pointing to. Finish filling up the form and submit. The image will checkout source code from the Subversion URI you provided and run mvn package to build the source. The output WAR file of the Maven build will be copied to the webapps of Tomcat 7.

#####WAR Deployment#####
If you want the image to just deploy your WAR file. Just put your WAR file to a Git repo, then enter the URI of your Git repo in the application detail page. Leave the Subversion URI blank and proceed. The image is smart enough to know that you want to do a WAR deployment, instead of a Subverion one.

Sit back and relax, your application should be up and running in no time.

###YOU NEED TO KNOW###
This image is just something I came up with during my exploration on OpenShift S2I, please don't expect it to be perfect.

Enjoy, have fun!

