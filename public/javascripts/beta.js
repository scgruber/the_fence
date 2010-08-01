Element.include({
  marginSizes: function() {
    return {
      x: parseInt(this.getStyle('marginLeft')) + parseInt(this.getStyle('marginRight')),
      y: parseInt(this.getStyle('marginTop')) + parseInt(this.getStyle('marginBottom'))
    }
  },
  
  borderSizes: function() {
    return {
      x: parseInt(this.getStyle('border-left-width')) + parseInt(this.getStyle('border-right-width')),
      y: parseInt(this.getStyle('border-top-width')) + parseInt(this.getStyle('border-bottom-width'))
    }
  },
  
  boxSizes: function() {
    var marginSizes = this.marginSizes();
    var borderSizes = this.borderSizes();
    
    return {
      x: this.offsetWidth + marginSizes.x + borderSizes.x,
      y: this.offsetHeight + marginSizes.y + borderSizes.y
    };
  }
})


document.onReady(function(){
  
  
  $$('a[href$="beta"], form.search-field, #escape-button').each(function(beta_link) {
    
    beta_link.onClick(function(click){

      click.stop();

      var boxSizes = beta_link.boxSizes();

      var backup_link = beta_link.insert(beta_link, 'after');

      var wrapper = $E('div', {style: {
        position: 'relative',
        'float': beta_link.getStyle('float')
      }});
      beta_link.wrap(wrapper);

      var replacement = $E('div', {'class': 'beta-fly-in'});
      replacement.setStyle({
        width: boxSizes.x+'px',
        height: boxSizes.y+'px',
        position: 'absolute',
        overflow: 'hidden',
      });
      var container = $E('div', {'class': 'fly-in-container', style: {width: (boxSizes.x-14)+'px', height: (boxSizes.y-14)+'px'}});
      container.insert('<h5>This feature isn&rsquo;t ready for prime time yet</h5><div>Learn more at <a href="/beta">our beta site</a></div>');
      replacement.insert(container);
      
      beta_link.insert(replacement, 'before');
      
      var transition = new Fx.Slide(replacement, {direction: 'right'});
      transition.start('in');

      replacement.onClick(function() {
        transition.start('out');
        transition.onFinish(function() {
          replacement.remove();
          beta_link.parent().replace(beta_link);
        });
      });
      
    });
    
  });
  
  
});