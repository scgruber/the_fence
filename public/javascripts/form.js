// TODO: Test dis shit

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
  
  function isHideableInput(input) {
    return $w('textarea text number').includes(input.type);
  }
  
  $$('.formtastic .inputs input,textarea').filter(isHideableInput).each(function(input) {
    var hint;
    if(hint = input.next('.inline-hints')) {
        hint.hide();
        
        input.on({
          focus: hint.show.bind(hint, 'fade'),
          blur: hint.hide.bind(hint, 'fade')
        });
    }
  });
  
});