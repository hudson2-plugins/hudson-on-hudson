<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <logRotator>
    <daysToKeep>${history.build.days}</daysToKeep>
    <numToKeep>${history.build.number}</numToKeep>
    <artifactDaysToKeep>${history.artifact.days}</artifactDaysToKeep>
    <artifactNumToKeep>${history.artifact.number}</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <creationTime>${import.time.timestamp}</creationTime>
  <properties>
    <org.jvnet.hudson.plugins.shelveproject.ShelveProjectProperty/>
    <JobRevision>
      <on>true</on>
      <revision>${import.time.text}</revision>
    </JobRevision>
    <dk.hlyh.hudson.plugins.displayname.DisplaynameProperty>
      <displayname>${displayname}</displayname>
    </dk.hlyh.hudson.plugins.displayname.DisplaynameProperty>
    <#include "/fragments/project_links.ftl">
  </properties>
  <#if scm?? && scm.type?? && scm.type == "git" >
      <#include "/fragments/scm-git.ftl">
  </#if>
  <advancedAffinityChooser>false</advancedAffinityChooser>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <jdk>${jdk}</jdk>
  <triggers class="vector">
<#if scm?? && scm.trigger?? >
    <hudson.triggers.SCMTrigger>
      <spec>${scm.trigger}</spec>
    </hudson.triggers.SCMTrigger>
</#if>
    <maven-dependency-trigger>
      <spec></spec>
    </maven-dependency-trigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <cleanWorkspaceRequired>false</cleanWorkspaceRequired>
  <builders>
 
     <#if sonar?? >
          <#assign goals="clean install deploy" />
     <#else>
          <#assign goals="clean install" />
     </#if>
     <#include "/fragments/maven-builder.ftl">    
    
    <!-- sonar if available -->
    <#if sonar??>     
      <!-- run the sonar -->
      <#assign goals="sonar:sonar" />
      <#include "/fragments/maven-builder.ftl">
    </#if>       
    
    <!-- run findbugs if no sonar -->
    <#if findbugs == "true">
      <#assign goals="org.codehaus.mojo:findbugs-maven-plugin:2.4.0:findbugs" />
      <#include "/fragments/maven-builder.ftl">
    </#if>
    
  </builders>
  <publishers>
    <#if findbugs == "true">
    <hudson.plugins.findbugs.FindBugsPublisher>
      <healthy></healthy>
      <unHealthy></unHealthy>
      <thresholdLimit>low</thresholdLimit>
      <pluginName>[FINDBUGS]</pluginName>
      <defaultEncoding></defaultEncoding>
      <canRunOnFailed>false</canRunOnFailed>
      <useDeltaValues>false</useDeltaValues>
      <thresholds>
        <unstableTotalAll></unstableTotalAll>
        <unstableTotalHigh></unstableTotalHigh>
        <unstableTotalNormal></unstableTotalNormal>
        <unstableTotalLow></unstableTotalLow>
        <failedTotalAll></failedTotalAll>
        <failedTotalHigh></failedTotalHigh>
        <failedTotalNormal></failedTotalNormal>
        <failedTotalLow></failedTotalLow>
      </thresholds>
      <shouldDetectModules>false</shouldDetectModules>
      <dontComputeNew>true</dontComputeNew>
      <pattern>**/findbugsXml.xml</pattern>
      <isRankActivated>false</isRankActivated>
    </hudson.plugins.findbugs.FindBugsPublisher>    
    </#if>
    <#if surefire == "true">
    <hudson.tasks.junit.JUnitResultArchiver>
      <testResults>**/target/surefire-reports/*.xml</testResults>
      <keepLongStdio>true</keepLongStdio>
      <testDataPublishers/>
    </hudson.tasks.junit.JUnitResultArchiver>    
    </#if>
    <maven-artifact-fingerprinter/>
    <maven-artifact-archiver>
      <includePomArtifacts>true</includePomArtifacts>
      <deleteOldArchiveArtifacts>true</deleteOldArchiveArtifacts>
    </maven-artifact-archiver>
    <maven-dependency-notifier>
      <notifyIfUnstable>false</notifyIfUnstable>
    </maven-dependency-notifier>
    <hudson.plugins.claim.ClaimPublisher/>
<#if mailer.active?? && mailer.active == "true">
    <hudson.tasks.Mailer>
      <recipients>${mailer.recipients}</recipients>
      <dontNotifyEveryUnstableBuild>${mailer.notalways}</dontNotifyEveryUnstableBuild>
      <sendToIndividuals>${mailer.breakers}</sendToIndividuals>
    </hudson.tasks.Mailer>
</#if>
  </publishers>
  <buildWrappers/>
</project>
