<%@ import="se.qbranch.qanban.Board" %>

<head>

  <meta name='layout' content='inside'/>

  <title>Qanban</title>

  <g:javascript library="jquery"/>
  <g:javascript src="jquery/jquery.ui.core.js"/>
  <g:javascript src="jquery/jquery.ui.sortable.js"/>
  <g:javascript src="jquery/jquery.ui.draggable.js"/>
  <g:javascript src="jquery/jquery.ui.dialog.js"/>

  <jq:jquery>


    $createCardDialog = $('<div id="createCard" class="dialog"></div>');
    $createCardDialog.dialog({
      autoOpen: false,
      modal: true,
      title: "<g:message code="mainView.jQuery.dialog.addCardForm.title"/>"
    });

    $('.addCardLink').click(function(event){
      $createCardDialog.dialog('open');
      $createCardDialog.load('${createLink(controller:'card',action:'ajaxShowForm')}');
      event.preventDefault();
    });

    $createPhaseDialog = $('<div id="createPhase" class="dialog"></div>');
    $createPhaseDialog.dialog({
      autoOpen: false,
      modal: true,
      title: "<g:message code="mainView.jQuery.dialog.addPhaseForm.title"/>"
    });

    $('.addPhaseLink').click(function(event){
      $createPhaseDialog.dialog('open');
      $createPhaseDialog.load('${createLink(controller:'phase',action:'ajaxPhaseForm')}');
      event.preventDefault();
    });
    
    /*****
    * Board logic
    */

    var sort = false;

    /*  Enables the phases to be sortable
    $('#phaseList').sortable({
      
    });
    */

    $('.card').click(function(){
      showCard( $(this).attr('id').split('_')[1] );
    });


    function showCard(id){
      if( !sort ){
        //alert('klick on card #' + id);
      }
      sort = false;
    }

    setupSortable();


  </jq:jquery>

  <g:javascript>

   function deletePhaseDialog(id){
    $('<div><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Are you sure you want to delete the phase?</p></div>').dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
            <g:message code="yes"/>: function() {
                    $.ajax({  url: '${createLink(controller:'phase',action:'ajaxDelete')}',
                              data: {'id': id},
                              type: 'POST',
                              error: function (XMLHttpRequest, textStatus, errorThrown) {
                                 $('<div><p><span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span><g:message code="mainView.jQuery.dialog.errorDeletingPhase.content"/></p></div>').dialog({
                                  modal: true,
                                  buttons: {
                                  <g:message code="ok"/>: function() {
                                      $(this).dialog('close');
                                    }
                                  }
                                });
                              }});
                    $(this).dialog('close');
                    updateBoard();
            },
            <g:message code="no"/>: function() {
                    $(this).dialog('close');
            }
        }
      });
   }


  function setupSortable(){
     $('.phase').sortable({
      connectWith: '.phase',
      start: function(event,ui){
        sort = true;
      },
      stop: function(event,ui){
        var newPos = ui.item.prevAll().length;
        var cardId = ui.item.attr('id').split('_')[1];
        var newPhase = ui.item.parent().attr('id').split('_')[1];
        $.post(
          '${createLink(controller:'mainView',action:'moveCard')}',
          {'id': cardId , 'movePosition' : newPos , 'movePhase' : newPhase},
          function(data){
            if( !data.result ){
              $('<div><p><span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span><g:message code="mainView.jQuery.dialog.illegalMove"/></p></div>').dialog({
                modal: true,
                buttons: {
                  <g:message code="ok"/>: function() {
                    $(this).dialog('close');
                    updateBoard();
                  }
                }
              });

              
            }
          },
          "json");
      }
    });


    $editPhaseDialog = $('<div id="editPhase" class="dialog"></div>');
    $editPhaseDialog.dialog({
      autoOpen: false,
      modal: true,
      title: "<g:message code="mainView.jQuery.dialog.editPhaseForm.title"/>"
    });

    $('.editPhaseLink').click(function(event){

      var phaseId = $(this).attr('id').split('_')[1];
      $editPhaseDialog.dialog('open');
      $editPhaseDialog.load('${createLink(controller:'phase',action:'ajaxPhaseForm')}',{'id': phaseId });
      event.preventDefault();
    });

    
    }

    function updateBoard(){
      $('#boardWrapper').load('${createLink(controller:'mainView',action:'showBoard')}',function(){setupSortable();});
    }

    function closeDialog(){
        $('.dialog').dialog('close');
    }

  </g:javascript>

  <style type="text/css">

  </style>



</head>

<body>

  <div id="wrapper">

    <div id="boardWrapper">
      <g:render template="/board/board" bean="${board}" />
    </div>

  </div>

</body>

