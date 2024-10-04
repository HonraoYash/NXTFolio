/*
 * Easing Compatibility v1 - http://gsgd.co.uk/sandbox/jquery/easing
 *
 * Adds compatibility for applications that use the pre 1.2 easing names
 *
 * Copyright (c) 2007 George Smith
 * Licensed under the MIT License:
 *   http://www.opensource.org/licenses/mit-license.php
 */

(function($){
	function addEasing(oldName, newName){
		$.easing[oldName] = function(options){
			const {x, t, b, c, d} = options;
			return $.easing[newName](x, t, b, c, d);
		};
	}
	addEasing('easeIn', 'easeInQuad');
    addEasing('easeOut', 'easeOutQuad');
    addEasing('easeInOut', 'easeInOutQuad');
    addEasing('expoin', 'easeInExpo');
    addEasing('expoout', 'easeOutExpo');
    addEasing('expoinout', 'easeInOutExpo');
    addEasing('bouncein', 'easeInBounce');
    addEasing('bounceout', 'easeOutBounce');
    addEasing('bounceinout', 'easeInOutBounce');
    addEasing('elasin', 'easeInElastic');
    addEasing('elasout', 'easeOutElastic');
    addEasing('elasinout', 'easeInOutElastic');
    addEasing('backin', 'easeInBack');
    addEasing('backout', 'easeOutBack');
    addEasing('backinout', 'easeInOutBack');

})(jQuery);