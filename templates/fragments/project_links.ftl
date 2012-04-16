<#if link?? >
    <hudson.plugins.sidebar__link.ProjectLinks>
        <links>
        <#list link?keys as item>
        <hudson.plugins.sidebar__link.LinkAction>
          <url>${link[item].url}</url>
          <text>${link[item].text}</text>
          <icon>document.gif</icon>
        </hudson.plugins.sidebar__link.LinkAction>
        </#list>
      </links>
    </hudson.plugins.sidebar__link.ProjectLinks>    
</#if> 
