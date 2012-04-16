  <maven-builder>
      <config>
        <installationId>(Bundled)</installationId>
        <goals>${goals}</goals>
        <privateRepository>true</privateRepository>
        <privateTmpdir>false</privateTmpdir>
        <pomFile>pom.xml</pomFile>
        <properties>
          <entries>
            <#if maven_property??>
              <#list maven_property?keys as item>
                <entry name="${maven_property[item].name}" value="${maven_property[item].value}"/>
              </#list>            
            </#if>
            <#if goals=="sonar:sonar">
              <entry name="sonar.jdbc.url" value="${sonar.database}"/>
              <entry name="sonar.jdbc.driver" value="${sonar.driver}"/>
              <entry name="sonar.host.url" value="${sonar.url}"/>
            </#if>
            <#if goals=="org.apache.maven.plugins:maven-dependency-plugin:2.4:purge-local-repository">
              <entry name="actTransitively" value="false"/>
              <entry name="reResolve" value="false"/>
              <entry name="resolutionFuzziness" value="artifactId"/>
              <entry name="verbose" value="true"/>
            </#if>            
          </entries>
        </properties>
        <errors>true</errors>
        <verbosity>NORMAL</verbosity>
        <offline>false</offline>
        <snapshotUpdateMode>NORMAL</snapshotUpdateMode>
        <#if maven_profiles??>        
          <profiles>
            <#list maven_profiles?split(",") as item>
              <string>${item}</string>
            </#list>            
          </profiles>
        </#if>
        <recursive>true</recursive>
        <checksumMode>NORMAL</checksumMode>
        <failMode>NORMAL</failMode>
        <makeMode>NONE</makeMode>
        <mavenOpts>-XX:MaxPermSize=1024m -Xmx2040m</mavenOpts>
        <settingsId>${settings_file}</settingsId>
        <globalSettingsId>NONE</globalSettingsId>
        <toolChainsId>NONE</toolChainsId>
      </config>
    </maven-builder>
