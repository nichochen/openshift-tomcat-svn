make
docker tag -f openshift-tomcat7-svn:latest registry.example.com:5000/openshift-tomcat7-svn
docker push registry.example.com:5000/openshift-tomcat7-svn
s2i build http://git.example.com/git/cakephp.git -e "SVN_URI=svn://192.168.172.157/javademo" registry.example.com:5000/openshift-tomcat7-svn test-app

