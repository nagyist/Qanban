<html>
  <head>
    <title><g:layoutTitle default="Grails" /></title>
    <link rel="stylesheet" href="${resource(dir:'css/jq_theme_blitzer',file:'jquery-ui.css')}"
    <link rel="stylesheet" href="${resource(dir:'css',file:'style.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css',file:'cardDialog.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css',file:'phaseDialog.css')}" />
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
  <g:layoutHead />
  <g:javascript library="application" />
</head>
<body>

  <div id="menu">

    <div class="background">

      <img src="${resource(dir:'images',file:'qanbanlogo.gif')}" height="20px">
    </div>

    <ul>
      <g:ifAllGranted role="ROLE_QANBANADMIN">
        <li><a href="${createLink(controller:'card',action:'create')}" class="addCardLink"><g:message code="layout.inside.menu.addCard"/></a></li>
        <li><a href="${createLink(controller:'phase',action:'create')}" class="addPhaseLink"><g:message code="layout.inside.menu.addPhase"/></a></li>
      </g:ifAllGranted>

      <g:isLoggedIn>
        <li><a href="${createLink(controller:'logout')}"><g:message code="layout.inside.menu.logOut"/></a></li>
        <li><a href="${createLink(controller:'mainView',action:'showLog')}"><g:message code="layout.inside.menu.showLog"/></a></li>
      </g:isLoggedIn>
      <li><span id="debug"></span></li>

    </ul>

  </div>

  <g:layoutBody />

</body>
</html>