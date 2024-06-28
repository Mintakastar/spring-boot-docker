# spring-boot-docker
I'm following the steps here:
    https://spring.io/guides/gs/spring-boot-docker

to Dockerize a spring boot application.

<h1>Run</h1>
To run this project manually just execute:

    ./mvnw package && java -jar target/spring-boot-docker-0.0.1-SNAPSHOT.jar

<h1>Test</h1>
To test this project manually just run: 

    curl localhost:8080

after that you will get this message as a response;

    Hello Docker World

<h1>Create image</h1>

    docker build -t springio/gs-spring-boot-docker .

<h1>Run image</h1>    

    docker run -p 8080:8080 springio/gs-spring-boot-docker


<br></br><br></br><br></br>

<h1>I had some issues:</h1>

<h2>First issue:</h2>

This plugin was causing errors to be added: 

    <plugin>
	    <groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-maven-plugin</artifactId>
    </plugin>

Error:

**Plugin 'org.springframework.boot:spring-boot-maven-plugin:' not found**

What I did to resolve it was adding this version line:
    
    <version>${project.parent.version}</version>

here is full block

    <plugin>
	    <groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-maven-plugin</artifactId>
		<version>${project.parent.version}</version>
    </plugin>

that i found here:</br>
    https://stackoverflow.com/questions/64639836/plugin-org-springframework-bootspring-boot-maven-plugin-not-found

<h2>Second Issue:</h2>

**./mvnw: 109: cannot open ./.mvn/wrapper/maven-wrapper.properties: No such file
cannot read distributionUrl property in ./.mvn/wrapper/maven-wrapper.properties**


for that I ran the command:
    mvn -N wrapper:wrapper
to create .mvn folder, the wrapper subfolder and the properties file, 
after that I was able to run "./mvnw package"

that solution I found it 
here:</br>
    https://stackoverflow.com/questions/50104172/could-not-find-or-load-main-class-org-apache-maven-wrapper-mavenwrappermain

and over here:</br>
    https://www.baeldung.com/maven-wrapper


<h2>Third issue:</h2>

I had this error:

    raffenio@Rafflap:~/Development/spring-boot-docker$ docker run -p 8080:8080 springio/gs-spring-boot-docker
    Error: A JNI error has occurred, please check your installation and try again
    Exception in thread "main" java.lang.UnsupportedClassVersionError: org/springframework/boot/loader/launch/JarLauncher has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 52.0
    at java.lang.ClassLoader.defineClass1(Native Method)
    at java.lang.ClassLoader.defineClass(ClassLoader.java:763)
    at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
    at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
    at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
    at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
    at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
    at java.security.AccessController.doPrivileged(Native Method)
    at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
    at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
    at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:495)


Seems the course has the java 8, but now in https://start.spring.io/ java 1.8 is not available, 
so it changed to JDK 17 by default   

to resolved this i change the java version on the docker file:

    #FROM openjdk:8-jdk-alpine
    FROM amazoncorretto:17.0.8-alpine3.18

I check these pages:

    https://forums.docker.com/t/openjdk-java-17-docker-image/125458/6

    https://hub.docker.com/layers/library/amazoncorretto/17.0.8-alpine3.18/images/sha256-6e6f780411eae55e8dcb59391aa09dd778f0fa2c896f9c218961fdb7da52f485?context=explore
