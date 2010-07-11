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
    function showHint() { this.next('.inline-hints').show('fade'); };
    function hideHint() { this.next('.inline-hints').hide('fade'); };
    
    var hint;
    if(hint = input.next('.inline-hints')) {
      hint.hide(); // Hide existing hints
    }
    
    input.on({
      focus: showHint,
      blur: hideHint
    });
  });
  
  
});