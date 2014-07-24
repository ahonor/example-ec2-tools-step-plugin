
This is an example node-step plugin that invokes Amazon EC2 Tools commands.
It's main purpose is to provide an interface to execute the commands but'
keep important configuration like the AWS access key in the Rundeck project configuration.

## Build

Run the make command in the source directory.

## Install

Copy the built plugin into $RDECK_BASE/libext or /var/lib/rundeck/libext (depending on install).

## Configuration

Example project configuration settings

```
# Location where the EC2 Tools are installed.
project.plugin.WorkflowNodeStep.example-ec2-tools-step-plugin.EC2_BASE=EC2_BASE
# URL to the ec2 API
project.plugin.WorkflowNodeStep.example-ec2-tools-step-plugin.EC2_URL=EC2_URL
# access key
project.plugin.WorkflowNodeStep.example-ec2-tools-step-plugin.AWS_ACCESS_KEY=AWS_ACCESS_KEY
# secret key
project.plugin.WorkflowNodeStep.example-ec2-tools-step-plugin.AWS_SECRET_KEY=AWS_SECRET_KEY
# Java install location
project.plugin.WorkflowNodeStep.example-ec2-tools-step-plugin.JAVA_HOME=JAVA_HOME
```
## Use

Example job definition: Execute the ec2-describe-regions command.

```
<joblist>
  <job>
    <loglevel>INFO</loglevel>
    <sequence keepgoing='false' strategy='node-first'>
      <command>
        <node-step-plugin type='ec2-tools-step-plugin'>
          <configuration>
            <entry key='command' value='ec2-describe-regions' />
            <entry key='region' value='us-east-1' />
            <entry key='verbose' value='false' />
          </configuration>
        </node-step-plugin>
      </command>
    </sequence>
    <description></description>
    <name>Run ec2-describe-regions command</name>
    <context/>
  </job>
</joblist>
```