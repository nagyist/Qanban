<head>
  <meta name='layout' content='login' />
  <title>Login</title>
<g:javascript library="jquery"/>
<script type="text/javascript">

        $(function() {

                $(".tabLink").click(function(event){
                        $link = $(this);
                        xPosition = "-" + (( $link.attr('href').split("-")[1] - 1 ) * 800) + "px";

                        $(".tabLink").removeClass('active');
                        $link.addClass('active');

                        $("#tabs").animate({
                                left: xPosition,
                                duration: 500
                        });

                        event.preventDefault();

                });

        });

</script>

</head>

<body>
  <div id="top">
    <div id="header">
      <div class="wrap">
        <div id="logo">
          <h1>
            <span class="red">Q</span>ANBAN
          </h1>
        </div>
        <div id="mainmenu">
          <ul>
            <li>
              <a href="#tabs-1" class="tabLink active"><g:message code="loginPage.tab.1"/></a>
            </li>
            <li>
              <a href="#tabs-2" class="tabLink"><g:message code="loginPage.tab.2"/></a>
            </li>
            <li>
              <a href="#tabs-3" class="tabLink"><g:message code="loginPage.tab.3"/></a>
            </li>
          </ul>
        </div>
      </div>
    </div>

  </div>

  <div id="content" class="wrap">

    <div id="tabs">
      <div class="huge red">Q</div>
      <div id="tabs-1" class="tab" >

        <div class="col-1">
          <g:if test='${flash.message}'>
            <div class='login_message'>${flash.message}</div>
          </g:if>
          <div id="login" class="framed">

            <h2><g:message code="loginPage.auth.form.title"/></h2>
            <form action='${postUrl}' method='POST' id='loginForm'>
              <div class="fieldWrapper">
                <label for='j_username'>
                  <g:message code="loginPage.auth.form.label.username"/>
                </label>
                <input type='text' class='text_' name='j_username' id='j_username' value='${request.remoteUser}' />
              </div>
              <div class="fieldWrapper">
                <label for='j_password'>
                  <g:message code="loginPage.auth.form.label.password"/>
                </label>
                <input type='password' class='text_' name='j_password' id='j_password' />
              </div>

              <div class="checkboxWrapper">
                
                <label for='remember_me'>
                  <g:message code="loginPage.auth.form.label.remember"/>
                </label>

                <input type='checkbox' class='chk' name='_spring_security_remember_me' id='remember_me'
                     <g:if test='${hasCookie}'>checked='checked'</g:if> />
              </div>

              <input type='submit' value='<g:message code="loginPage.auth.form.button.login"/>' />

            </form>
          </div>
        </div>

        <div class="col-2">
          <h2>
            <g:message code="lorem.qanban"/>
          </h2>
          <p>
            <g:message code="lorem.paragraph"/>
          </p>
          <p>
            <g:message code="lorem.paragraph"/>
          </p>
        </div>
      </div>

      <div id="tabs-2" class="tab">

        <div class="wideCol">

          <div class="solid">
            <div class="bg"></div>
            <div class="content">
              <h2><g:message code="loginPage.addUser.form.title"/></h2>
              <form>
                <ul>
                  <li>
                    <label for="firstName"><g:message code="loginPage.addUser.form.label.firstName"/></label>
                    <input name="firstName" type="text"/>
                  </li>

                  <li>
                    <label for="lastName"><g:message code="loginPage.addUser.form.label.lastName"/></label>
                    <input name="lastName" type="text"/>
                  </li>
                  <li>
                    <label for="email"><g:message code="loginPage.addUser.form.label.eMail"/></label>
                    <input name="email" type="text"/>
                  </li>
                  <li>
                    <label for="passwd1"><g:message code="loginPage.addUser.form.label.password1"/></label>
                    <input name="passwd1" type="password"/>
                  </li>
                  <li>
                    <label for="passwd2"><g:message code="loginPage.addUser.form.label.password2"/></label>
                    <input name="passwd2" type="password"/>
                  </li>
                  <li>
                    <input type="button" value="<g:message code="loginPage.addUser.form.button.submit"/>"/>
                  </li>
                </ul>
              </form>
            </div>
          </div>

        </div>
      </div>

      <div id="tabs-3" class="tab">
        <div class="col-2">
          <h2>
            <g:message code="lorem.qanban"/>
          </h2>
          <p>
            <g:message code="lorem.paragraph"/>
          </p>
          <p>
            <g:message code="lorem.paragraph"/>
          </p>
        </div>
      </div>

      <div class="leveler"></div>
    </div>
  </div>

  <script type='text/javascript'>
  <!--
  (function(){
          document.forms['loginForm'].elements['j_username'].focus();
  })();
  // -->
  </script>
</body>
