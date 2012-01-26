<#if scm?? && scm.trigger?? >
  <hudson.triggers.SCMTrigger>
    <spec>${scm.trigger}</spec>
  </hudson.triggers.SCMTrigger>
</#if>
