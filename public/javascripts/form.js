document.onReady(function(){
  
  
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