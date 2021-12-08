# Check maven version 
mvn --version

# create a project 
mvn archetype:generate -DgroupId=com.ajit -DartifactId=hellomaven -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false               

# cd into project 
cd /hellomaven

# packaging 
mvn install 

# Run app from the jar 
java -cp target/hellomaven-1.0-SNAPSHOT.jar com.ajit.App    

# Create a Java standalone Project [.jar packaging]
mvn archetype:generate -DgroupId=com.ajit -DartifactId=java-project -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
# Create a Java Web Project [.war packaging]
mvn archetype:generate -DgroupId=com.ajit -DartifactId=java-web-project -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false