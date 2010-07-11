document.onReady(function(){
  
  if($('event_til_whenever')) {
    $('event_til_whenever').onClick(function() {
      if(this.checked) {
        $('event_finish').setStyle('color', 'transparent');
        $('event_finish').disable();
      } else {
        $('event_finish').setStyle('color', 'inherit');
        $('event_finish').enable();
      }
    });
  }
    
  $$('input.datetime').each(function(datetime){
    new Calendar({format: "%l:%M%p %m/%d/%Y"}).assignTo(datetime);
  });
  
  $$('.formtastic .inputs input,textarea').each(function(input) {
    // TODO de-dupe me
    function showHint() { var hint = this.next('.inline-hints'); if(hint) hint.show('fade'); };
    function hideHint() { var hint = this.next('.inline-hints'); if(hint) hint.hide('fade'); };
    
    var hint;
    if(hint = input.next('.inline-hints')) {
      // Don't hide file inputs, they're hard to focus on
      if(input.type === "textarea" || input.type === "text") {
        hint.hide();
      }
    }
    
    input.on({
      focus: showHint,
      blur: hideHint
    });
  });
  
  
});