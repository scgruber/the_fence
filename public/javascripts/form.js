document.onReady(function(){
  
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