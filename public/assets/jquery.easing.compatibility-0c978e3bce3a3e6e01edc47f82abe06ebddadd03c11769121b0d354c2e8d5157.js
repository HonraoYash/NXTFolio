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
$.extend( $.easing,
{
	easeIn: function (options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInQuad(x, t, b, c, d);
	},
	easeOut: function (options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeOutQuad(x, t, b, c, d);
	},
	easeInOut: function (options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInOutQuad(x, t, b, c, d);
	},
	expoin: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInExpo(x, t, b, c, d);
	},
	expoout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeOutExpo(x, t, b, c, d);
	},
	expoinout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInOutExpo(x, t, b, c, d);
	},
	bouncein: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInBounce(x, t, b, c, d);
	},
	bounceout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeOutBounce(x, t, b, c, d);
	},
	bounceinout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInOutBounce(x, t, b, c, d);
	},
	elasin: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInElastic(x, t, b, c, d);
	},
	elasout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeOutElastic(x, t, b, c, d);
	},
	elasinout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInOutElastic(x, t, b, c, d);
	},
	backin: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInBack(x, t, b, c, d);
	},
	backout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeOutBack(x, t, b, c, d);
	},
	backinout: function(options) {
		const {x, t, b, c, d} = options;
		return $.easing.easeInOutBack(x, t, b, c, d);
	}
});})(jQuery);
