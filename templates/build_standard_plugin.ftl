<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <#include "/fragments/history.ftl">
  <creationTime>${import.time.timestamp}</creationTime>
  <properties>
    <org.jvnet.hudson.plugins.shelveproject.ShelveProjectProperty/>
    <#include "/fragments/jobrevision.ftl">  
    <#include "/fragments/displayname.ftl">
  </properties>
  <#if scm?? && scm.type?? && scm.type == "github" >
      <#include "/fragments/scm-github.ftl">
  </#if>
  <advancedAffinityChooser>false</advancedAffinityChooser>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <jdk>$[jdk}</jdk>
  <triggers class="vector">
    <#include "/fragments/scm-trigger.ftl">
    <maven-dependency-trigger>
      <spec></spec>
    </maven-dependency-trigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <cleanWorkspaceRequired>false</cleanWorkspaceRequired>
  <builders>
    <maven-builder>
      <config>
        <installationId>(Bundled)</installationId>
        <goals>clean install</goals>
        <privateRepository>false</privateRepository>
        <privateTmpdir>false</privateTmpdir>
        <pomFile>pom.xml</pomFile>
        <properties>
          <entries/>
        </properties>
        <errors>false</errors>
        <verbosity>NORMAL</verbosity>
        <offline>false</offline>
        <snapshotUpdateMode>NORMAL</snapshotUpdateMode>
        <recursive>true</recursive>
        <checksumMode>NORMAL</checksumMode>
        <failMode>NORMAL</failMode>
        <makeMode>NONE</makeMode>
        <settingsId>NONE</settingsId>
        <globalSettingsId>NONE</globalSettingsId>
        <toolChainsId>NONE</toolChainsId>
      </config>
    </maven-builder>
  </builders>
  <publishers>
    <maven-artifact-fingerprinter/>
    <maven-artifact-archiver>
      <includePomArtifacts>true</includePomArtifacts>
      <deleteOldArchiveArtifacts>true</deleteOldArchiveArtifacts>
    </maven-artifact-archiver>
    <maven-dependency-notifier>
      <notifyIfUnstable>false</notifyIfUnstable>
    </maven-dependency-notifier>
    <hudson.plugins.claim.ClaimPublisher/>
  </publishers>
  <buildWrappers/>
</project>
