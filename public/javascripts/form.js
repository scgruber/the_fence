// TODO: Test dis shit

document.onReady(function(){
  
  function toggle_field(field, options) {
    if($(options.withElement)) {
      $(options.withElement).onClick(function() {
        if(this.checked) {
          $(field).setStyle('color', 'transparent');
          $(field).disable();
        } else {
          $(field).setStyle('color', 'inherit');
          $(field).enable();
        }
      });
    } 
  };
  
  toggle_field('event_finish', {withElement: 'event_til_whenever'});
  toggle_field('event_cost', {withElement: 'event_free'});
    
  $$('input.datetime').each(function(datetime){
    var calendar = new Calendar({
      format: "%l:%M%p %m/%d/%Y",
      minDate: new Date(),
      showTime: true,
      twentyFourHour: false,
      hideOnPick: true
    });
    calendar.assignTo(datetime);
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